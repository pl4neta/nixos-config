{ pkgs, username, ... }: 
{


  services = {
    xserver = {
      windowManager.awesome.enable = true;
      enable = true;
      displayManager = {
        setupCommands = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --output eDP-1 --left-of HDMI-0
        '';
        gdm = {
          enable = true;
          wayland = true;
          autoSuspend = false;
        };
        defaultSession = "none+Hyprland";
        session = [
          {
            name = "Hyprland";
            manage = "window";
            start = ''
              export XDG_SESSION_TYPE=wayland
              ${pkgs.hyprland}/bin/hyprland -ls &
              waitPID=$!
            '';
          }
          {
            name = "Awesome";
            manage = "window";
            start = ''
              export XDG_SESSION_TYPE=x11
              ${pkgs.awesome}/bin/awesome
              waitPID=$!
            '';
          }
        ];
      };
      xkb.layout = "pt";
    };

    #displayManager.autoLogin = {
    #  enable = true;
    #  user = "${username}";
    #};
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
