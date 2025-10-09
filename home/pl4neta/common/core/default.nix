{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}:
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
    ])
    ./nixos.nix

    ./bat.nix
    ./btop.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./lf.nix
    ./rofi.nix
    ./ssh.nix
    ./starship.nix
    ./xdg-directories.nix
    ./xdg-mimes.nix
    ./zsh.nix
  ];

  inherit hostSpec;

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "25.05";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/projects/nix/nix-config";
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)

      curl
      pciutils
      pfetch # system info
      pre-commit # git hooks
      p7zip # compression & encryption
      usbutils
      unzip # zip extraction
      unrar # rar extraction
      ;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
