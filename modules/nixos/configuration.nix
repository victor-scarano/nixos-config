{ pkgs, lib, ... }: {
	imports = [ ./hardware-configuration.nix ];

	nixpkgs.config.allowUnfree = true;
	nix = {
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
			trusted-users = [ "root" "victor" "@wheel" ]; # do i need all of these?
		};
		channel.enable = false;
	};

	# system packages
	environment.systemPackages = with pkgs; [ git vim wget ];

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
	networking.hostName = "victor-nixos"; 

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
	services.xserver.displayManager.gdm.enable = true;
	# for some reason this line has to exist otherwise gdm won't work:
	# do i also have to set the package so that it uses the flake version?
	programs.hyprland.enable = true;
	services.printing.enable = true;

	# font config
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu-mono
	];

	# misc config
	time.timeZone = "America/Chicago";

	# nixos release (https://nixos.org/nixos/options.html)
	system.stateVersion = "25.05";
}
