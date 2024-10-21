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
    	    modesetting.enable = true;
	        open = false;
	        nvidiaSettings = true;
        };
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.enableRedistributableFirmware = true;
}
