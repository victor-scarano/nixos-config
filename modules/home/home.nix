{ pkgs, ... }: {
	home = {
		username = "victor";
		homeDirectory = "/home/victor";
	};

	home.packages = with pkgs; [
		# btop
		discord-canary
		fastfetch # TODO: configure with home manager
		fzf
		gimp
		google-chrome
		grim
		libreoffice
		lunar-client
		# nautilus
		obsidian
		obs-studio
		python314
		ripgrep
		rustup
		spotify
		# spotify-tray # TODO: GDK_BACKEND=x11 spotify-tray
		tree
		vlc
		# waypaper
		# https://github.com/quantumvoid0/better-control
	];

	# update this to 25.05 when it's released
	home.stateVersion = "24.11";

	# let home manager install and manage itself
	# programs.home-manager.enable = true;
}
