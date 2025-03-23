{ pkgs, ... }: {
	home = {
		username = "victor";
		homeDirectory = "/home/victor";
	};

	home.packages = with pkgs; [
		btop
		discord-canary
		fastfetch # configure with home manager
		fzf
		gimp
		google-chrome
		grim
		libreoffice
		nautilus
		obsidian
		obs-studio
		ripgrep
		rustup
		slurp
		spotify
		spotify-tray # TODO: GDK_BACKEND=x11 spotify-tray
		swww
		tree
		unzip
		vlc
		waypaper
		wl-clipboard
		zig
		zip
		zls
	];

	# update this to 25.05 when it's released
	home.stateVersion = "24.11";

	# let home manager install and manage itself
	programs.home-manager.enable = false;
}
