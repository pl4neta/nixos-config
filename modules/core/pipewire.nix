{ pkgs, ... }: 
{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    # lowLatency.enable = true;
  };
  environment.systemPackages = with pkgs; [
    pulseaudioFull
  ];
}
