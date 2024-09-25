{ pkgs, ... }:
{  
  hardware = {
    graphics = {
      enable = true;
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
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
