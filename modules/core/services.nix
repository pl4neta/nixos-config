{ config, pkgs, ... }:
let
    userHome = config.users.users.pl4neta.home;
in {
  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    blueman.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    transmission = {
      enable = true;
      package = pkgs.transmission_4;
      settings = {
        download-dir = "${userHome}/torrents";
      };
    };
  };
  security.polkit.enable = true;
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
    '';
  services.udev.enable = true;
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEM=="usb", ATTR{idVendor}=="3310", MODE="0666", GROUP="plugdev"
    '';
}

