{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.python3
    pkgs.python3Packages.virtualenv
  ];
}

