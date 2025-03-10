{ pkgs, ... }: {
	imports = [
		./hardware-configuration.nix
		# inputs.home-manager.nixosModules.home-manager
	];

	# enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	# system packages
	environment.systemPackages = with pkgs; [
		# gcc
		git
		# libgcc
		# polkit
		# polkit_gnome
		# sbctl
		vim
		wget
	];

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
			enable = true;
			# enable = lib.mkForce false;
			consoleMode = "max";
		};
		efi.canTouchEfiVariables = true;
		timeout = 10;
	};
	boot.lanzaboote = {
		enable = false; # enable = true;
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

	# polkit
	/*
	security.polkit.enable = true;
	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
	};
	*/

	# font config
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu-mono
	];

	# misc config
	time.timeZone = "America/Chicago";
	i18n.defaultLocale = "en_US.UTF-8"; # does this need to be set?
	# programs.nix-ld.enable = true;

	# nixos release (https://nixos.org/nixos/options.html)
	system.stateVersion = "25.05";
}
