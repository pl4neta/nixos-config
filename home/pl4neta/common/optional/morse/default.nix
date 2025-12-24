{ config, ... }:
{
  home.file = {
    "bin/morse_daemon.py".source = ./morse_daemon.py;
  };

  systemd.user.services.morse-daemon = {
    Unit = {
      Description = "Morse Audio Tone Generator";
      After = [ "pipewire.service" "pipewire-pulse.service" "wireplumber.service" ];
      Wants = [ "wireplumber.service" ];
    };

    Service = {
      Environment = "PULSE_PROP_application.name=morse-daemon";
      ExecStart = "${config.hostSpec.home}/bin/morse_daemon.py";
      Restart = "always";
      RestartSec = "1s";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
