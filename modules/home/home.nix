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
		# https://www.reddit.com/r/unixporn/comments/1ji2flj/oc_bettercontrol_a_sleek_gtkbased_control_panel/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	];

	# update this to 25.05 when it's released
	home.stateVersion = "24.11";

	# let home manager install and manage itself
	# programs.home-manager.enable = true;
}
