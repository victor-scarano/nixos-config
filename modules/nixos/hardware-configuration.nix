{ config, lib, modulesPath, ... }: {
	imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

	boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-amd" ];
	boot.extraModulePackages = [ ];

	fileSystems."/" = {
		device = "/dev/disk/by-uuid/7c2b4c47-40ca-4500-9536-9a5668e3433f";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/92A8-935F";
		fsType = "vfat";
		options = [ "fmask=0022" "dmask=0022" ];
	};

	fileSystems."/home" = {
		device = "/dev/disk/by-uuid/128f49cb-63d0-452c-8292-6aaf2c209251";
		fsType = "ext4";
	};

	swapDevices = [ ];

	networking.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
