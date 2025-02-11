{ pkgs, username, ... }: 
{


  services = {
    xserver = {
      windowManager.awesome.enable = true;
      enable = true;
      displayManager = {
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
              ${pkgs.hyprland}/bin/hyprland -ls &
              waitPID=$!
            '';
          }
          {
            name = "Awesome";
            manage = "window";
            start = ''
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
