{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = lib.flatten [
    inputs.home-manager.nixosModules.home-manager

    (map lib.custom.relativeToRoot [
      "modules/common"
      "hosts/common/core/bootloader.nix"
      "hosts/common/core/hardware.nix"
      "hosts/common/core/network.nix"
      "hosts/common/core/nh.nix"
      "hosts/common/core/pipewire.nix"
      "hosts/common/core/program.nix"
      "hosts/common/core/security.nix"
      "hosts/common/core/services.nix"
      "hosts/common/core/shell.nix"
      "hosts/common/core/system.nix"
      "hosts/common/core/wayland.nix"
      "hosts/common/users/primary"
      "hosts/common/users/primary/nixos.nix"
    ])
  ];

  hostSpec = {
    username = "pl4neta";
    handle = "pl4neta";
  };

  networking.hostName = config.hostSpec.hostName;

  environment.systemPackages = [ pkgs.openssh ];

  home-manager.useGlobalPkgs = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [ "@wheel" ];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      warn-dirty = false;

      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
