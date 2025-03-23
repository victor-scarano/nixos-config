{ pkgs, lib, ... }: {
	imports = [ ./hardware-configuration.nix ];

	nixpkgs.config.allowUnfree = true;
	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			trusted-users = [ "root" "@wheel" ];
		};
		channel.enable = false;
	};

	# system packages
	environment.systemPackages = with pkgs; [ gh git neovim wget ];

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
			# enable = true;
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
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	# enable daemons and services
	services.openssh.enable = true;
	programs.dconf.enable = true;
	security.polkit.enable = true;
	services.greetd = {
		enable = true;
		settings.default_session = {
			command = "sway";
			user = "victor";
		};
	};
	programs.hyprland.enable = false;
	services.printing.enable = true;

	# font config
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu-mono
		nerd-fonts.ubuntu
	];

	# misc config
	time.timeZone = "America/Chicago";

	system.stateVersion = "25.05";
}
