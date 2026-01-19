#{ pkgs, pkgsUnstable, ... }: 
#{
#  programs.steam = {
#    enable = true;
#    package = pkgsUnstable.steam;
#    remotePlay.openFirewall = true;
#    dedicatedServer.openFirewall = true;
#    extraCompatPackages = with pkgs; [
#      protontricks
#      steamcmd
#      steam-run
#    ];
#  };
#  programs.gamemode.enable = true;
#}
{ pkgs, pkgsUnstable, ... }:
{
  #hardware.xpadneo.enable = true;

  programs = {
    steam = {
      enable = true;
      package = pkgsUnstable.steam;
      protontricks = {
        enable = true;
        package = pkgsUnstable.protontricks;
      };
      extraCompatPackages = [ pkgsUnstable.proton-ge-bin ];
    };
    # To run steam games in game mode, add the following to the game's properties within steam
    # `gamemoderun %command%`
    gamemode = {
      enable = true;
      settings = {
        #see gamemode man page for settings info
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };
        gpu = {
          #apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 1; # The DRM device number on the system (usually 0), ie. the number in /sys/class/drm/card0/
          amd_performance_level = "high";
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };
}
