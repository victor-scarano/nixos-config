{ pkgs, lib, ... }: {
	imports = [ ./hardware-configuration.nix ];

	nixpkgs.config.allowUnfree = true;
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
		trusted-users = [ "root" "@wheel" ];
	};

	# user config
	users.users.victor = {
		isNormalUser = true;
		description = "Victor";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
	};

	# shell config
	programs.fish.enable = true;

	# bootloader config
	boot.loader = {
		systemd-boot = {
			enable = lib.mkForce false;
			consoleMode = "max";
		};
		efi.canTouchEfiVariables = true;
		timeout = 10;
	};

	# enable secure boot
	boot.lanzaboote = {
		enable = true;
		pkiBundle = "/var/lib/sbctl";
	};

	# networking config
	networking.networkmanager.enable = true;
	networking.hostName = "nixos"; 

	# audio config
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		audio.enable = true;
		pulse.enable = true;
		jack.enable = true;
		alsa = {
			enable = true;
			support32Bit = true;
		};
	};

	# display manager
	services.greetd = {
		enable = true;
		settings.default_session = {
			command = "sway";
			user = "victor";
		};
	};

	# xwayland
	xdg.portal = {
		enable = true;
		wlr.enable = true;
		configPackages = [ pkgs.xdg-desktop-portal-gtk ];
	};

	# font config
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu
		nerd-fonts.ubuntu-mono
		noto-fonts
		noto-fonts-cjk-sans
	];

	# misc config
	time.timeZone = "America/Chicago";
	services.openssh.enable = true;
	programs.dconf.enable = true;
	security.polkit.enable = true;
	services.printing.enable = true;
	services.blueman.enable = true;
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

	system.stateVersion = "25.05";
}
