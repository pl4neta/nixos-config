{ pkgs, ... }:
{
  home.packages = with pkgs; [
    quickshell
    lm_sensors
  ];

  xdg.configFile."quickshell/woah" = {
    source = ./config;
    recursive = true;
  };
}
