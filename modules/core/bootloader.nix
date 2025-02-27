{ pkgs, ... }:
{
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			systemd-boot.configurationLimit = 10;
		};
		initrd.kernelModules = [ "amdgpu" ];
		kernelParams = [ "radeon.si_support=0" "amdgpu.si_support=1" ];
		#kernelPackages = pkgs.linuxPackages_6_11; #latest had problems with nvidia drivers
		#supportedFilesystems = [ "ntfs" ];
	};
  boot.kernel.sysctl."vm.max_map_count" = 1048576;
}
