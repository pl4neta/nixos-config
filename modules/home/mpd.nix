{
  services.mpd = {
    enable = true;
    musicDirectory = "$HOME/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire Sound Server"
      }
      audio_output {
        type "fifo"
        name "fifo"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
    '';
  };
}
