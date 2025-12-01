#!/usr/bin/env nix-shell
#! nix-shell -i python3
#! nix-shell -p python3Packages.sounddevice python3Packages.numpy
import sounddevice as sd
import numpy as np
import threading

# Config
FREQ = 700          # tone frequency
SAMPLE_RATE = 48000
VOLUME = 0.3

tone_on = False
phase = 0.0
phase_inc = 2 * np.pi * FREQ / SAMPLE_RATE

lock = threading.Lock()

def audio_callback(outdata, frames, time, status):
    global phase
    buf = np.zeros(frames, dtype=np.float32)

    with lock:
        active = tone_on

    if active:
        # Generate continuous sine wave
        t = (phase + np.arange(frames) * phase_inc)
        buf = np.sin(t).astype(np.float32) * VOLUME
        phase = (phase + frames * phase_inc) % (2*np.pi)

    outdata[:, 0] = buf  # mono

def set_tone(state: bool):
    global tone_on
    with lock:
        tone_on = state

def main():
    print("Morse tone engine started.")
    print("Use: echo on > /tmp/morse_pipe   or   echo off > /tmp/morse_pipe")

    # Create a named pipe to receive commands
    import os
    pipe = "/tmp/morse_pipe"
    if not os.path.exists(pipe):
        os.mkfifo(pipe)

    # Start audio stream
    with sd.OutputStream(callback=audio_callback, channels=1, samplerate=SAMPLE_RATE):
        while True:
            with open(pipe, "r") as p:
                for line in p:
                    cmd = line.strip()
                    if cmd == "on":
                        set_tone(True)
                    elif cmd == "off":
                        set_tone(False)

if __name__ == "__main__":
    main()

