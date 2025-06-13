{ pkgs, ... }:
{
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
			systemd-boot.configurationLimit = 10;
		};
		initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "usbnet rndis_host" ];
		kernelParams = [
      #"radeon.si_support=0"
      #"amdgpu.si_support=1"
      "amdgpu.ppfeaturemask=0xffffffff"
      "amd_iommu=on"
      "idle=nomwait"
      "processor.max_cstate=1"
      "vm.max_map_count=16777216"
    ];
    extraModprobeConfig = ''
      options amdgpu si_support=1
      options amdgpu cik_support=1
      options amdgpu enable_guc=3
      options amdgpu enable_psr=1
    '';
		#kernelPackages = pkgs.linuxPackages_6_11; #latest had problems with nvidia drivers
	};
  #boot.kernel.sysctl."vm.max_map_count" = 1048576;
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.overcommit_memory" = 1;
    "vm.overcommit_ratio" = 100;
    "vm.max_map_count" = 16777216;
  };
}
