{
  imports = [
    ./bat.nix                         # better cat command
    ./btop.nix                        # resouces monitor 
    ./fastfetch.nix                         # fetch tool
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./git.nix                         # version control
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal
    ./swaync/swaync.nix               # notification deamon
    ./packages.nix                    # other packages
    #./retroarch.nix  
    ./rofi.nix                        # launcher
    ./scripts/scripts.nix             # personal scripts
    ./spicetify.nix                   # spotify client
    ./starship.nix                    # shell prompt
    ./swaylock.nix                    # lock screen
    ./xdg-mimes.nix                   # xdg config
    ./zsh.nix                         # shell
		./lf.nix
    ./awesome.nix
    ./mpd.nix
    ./ncmpcpp.nix
    ./polkit.nix
  ];
}
