{inputs, username, host, ...}: {
  imports = [
    ./bat.nix                         # better cat command
    ./btop.nix                        # resouces monitor 
    ./discord.nix                     # discord with catppuccin theme
    ./fastfetch.nix                         # fetch tool
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./git.nix                         # version control
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./kitty.nix                       # terminal
    ./swaync/swaync.nix               # notification deamon
    ./nvim.nix                        # neovim editor
    ./packages.nix                    # other packages
    ./retroarch.nix  
    ./rofi.nix                        # launcher
    ./scripts/scripts.nix             # personal scripts
    ./spicetify.nix                   # spotify client
    ./starship.nix                    # shell prompt
    ./swaylock.nix                    # lock screen
    ./waybar                          # status bar
    ./xdg-mimes.nix                   # xdg config
    ./zsh.nix                         # shell
    ./zen.nix			      # foss browser
    ./hyprpanel.nix
  ];
}
