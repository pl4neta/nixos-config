{ pkgs, ... }:
{
    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;
            extraPackages = with pkgs; [
    
            ];
        };
        nvidia = {
          powerManagement.enable = false;
    	    modesetting.enable = true;
	        open = false;
	        nvidiaSettings = true;
        };
        opengl = {
          extraPackages = with pkgs; [
            libglvnd
          ];
        };
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.enableRedistributableFirmware = true;
}
