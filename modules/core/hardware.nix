{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
          mesa
          libva
      ];
    };
  };
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.enableRedistributableFirmware = true;
}
