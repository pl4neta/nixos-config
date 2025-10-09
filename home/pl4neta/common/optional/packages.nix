{ inputs, pkgs, ... }: 
{
  home.keyboard = null;
  home.packages = with pkgs; [
        firefox
        godot3
        inkscape
        kitty
        libresprite
        lf
        lutris
        mupdf
        obs-studio
        obsidian
        pavucontrol
        playerctl
        qjackctl
        signal-desktop
	steam
        sunshine
        trashy
        unzip
        vlc
        wev
        wine-wayland
        zip

	qimgv
	bat
	
	inputs.zen-browser.packages."${system}".default
	inputs.hyprpanel.packages."${system}".default
	inputs.nixvim.packages."${system}".default
	discord

	wl-clipboard

	sway-contrib.grimshot

	usbutils

	transmission_4-qt

	htop

	wdisplays

	libreoffice

	thunderbird
  ];
}
