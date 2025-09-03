{ pkgs, username, ... }: 
let
 compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
        ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../../.config/xkb/layout.xkb} $out
      '';
in
{
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout} $DISPLAY";

  services.displayManager.defaultSession = "none+Hyprland";
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
      
      #xkb = {
        #layout = "pt";
      #  layout = "carrak";
      #  variant = "usde";
      #  extraLayouts.carrak = {
      #    languages = ["por" "eng"];
      #    description = "test";
      #    symbolsFile = ../../.config/xkb/symbols/carrak;
      #  };
      #};
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
  #systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
