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
	        open = true;
	        nvidiaSettings = true;
        };
        opengl = {
          extraPackages = with pkgs; [
            mesa.drivers
            #libglvnd
          ];
        };
    };
    services.xserver.videoDrivers = ["nouveau"];
    hardware.enableRedistributableFirmware = true;
}
