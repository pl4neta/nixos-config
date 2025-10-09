{ pkgs, pkgsUnstable, ... }: 
{
  programs.steam = {
    enable = true;
    package = pkgsUnstable.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      protontricks
      steamcmd
      steam-run
    ];
  };
  programs.gamemode.enable = true;
}
