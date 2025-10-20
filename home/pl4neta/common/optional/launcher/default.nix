{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rofi
  ];
  home.file = {
    ".config/rofi/style.rasi".source = ./style.rasi;
    ".config/rofi/fonts.rasi".source = ./fonts.rasi;
    ".config/rofi/colors.rasi".source = ./colors.rasi;
    ".config/rofi/colors".source = ./colors;
  };
}
