{ pkgs, ... }:
{
  home.file = {
    ".config/awesome" = {
      recursive = true;
      source = ../../.config/awesome;
    };
  };
  home.packages = with pkgs; [
    xorg.xrandr
    eww
  ];
}
