{ config, pkgs, lib, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		# ./home.nix
	];

	# enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	# system packages
	programs.hyprland.enable = true;
	environment.systemPackages = with pkgs; [
		btop
		gcc
		gh
		ghostty
		git
		gparted # must be installed as a system package
		kdePackages.breeze
		libgcc
		oh-my-posh
		polkit
		polkit_gnome
		ripgrep
		rustup
		sbctl
		stow
		tree
		vlc
		wget
		# zsh
	];

	# user config
	users.users.victor = {
		isNormalUser = true;
		description = "Victor";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
		packages = with pkgs; [
			anyrun
			discord-canary
			fastfetch
			firefox
			gimp
			github-desktop
			google-chrome
			grim
			kitty
			neovim
			obsidian
			rust-analyzer
			slurp
			spotify
			swww
			waypaper
			wl-clipboard
		];
	};

	# shell config
	programs.zsh.enable = true;
	environment.shells = [ pkgs.zsh ];

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
	services.printing.enable = true;

	# polkit
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

	# font config
	fonts.packages = with pkgs; [
		noto-fonts
		noto-fonts-cjk-sans
		nerd-fonts.jetbrains-mono
		nerd-fonts.ubuntu-mono
	];

	# misc config
	time.timeZone = "America/Chicago";
	i18n.defaultLocale = "en_US.UTF-8";

	# nixos release (https://nixos.org/nixos/options.html)
	system.stateVersion = "24.11";
}
