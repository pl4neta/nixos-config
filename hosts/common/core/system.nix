{ self, pkgs, lib, inputs, ...}: 
{
  environment.variables.EDITOR = "nvim";
  # imports = [ inputs.nix-gaming.nixosModules.default ];
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      #substituters = [ "https://nix-gaming.cachix.org" ];
      #trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git

    vulkan-tools
    mangohud
    goverlay
    libva
    libva-utils
    mesa
    mesa.drivers
    mesa-demos
    pciutils
    glxinfo
    xorg.xrandr
    xorg.libXrandr
    xorg.libX11
    xorg.xinput
    steam-run
    wineWowPackages.stable
    winetricks
    lutris
  ];

  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;

    boot.supportedFilesystems = [ "ntfs" ];
}
