{ pkgs, ... }:
{
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			systemd-boot.configurationLimit = 10;
		};
		kernelPackages = pkgs.linuxPackages_6_11; #latest had problems with nvidia drivers
		#kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];
    kernelParams = [ "nouveau.modeset=1" "nouveau.pstate=1"];
		supportedFilesystems = [ "ntfs" ];
	};
}
