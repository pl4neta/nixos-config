{ pkgs, ... }:
{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        mesa
        mesa-demos
        #libva
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers
        libdrm
        directx-headers
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        amdvlk
        mesa
        vulkan-loader
        libdrm
      ];
    };
  };
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.enableRedistributableFirmware = true;
}
