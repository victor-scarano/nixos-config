{ pkgs, inputs, ... }: {
	home = {
		username = "victor";
		homeDirectory = "/home/victor";
	};

	home.packages = [
		pkgs.btop
		pkgs.discord-canary
		pkgs.fastfetch # TODO: configure with home manager
		pkgs.fzf
		pkgs.gimp
		pkgs.google-chrome
		pkgs.libreoffice
		pkgs.lunar-client
		pkgs.obsidian
		pkgs.obs-studio
		pkgs.python314
		pkgs.rustup
		pkgs.spotify
		# spotify-tray # TODO: GDK_BACKEND=x11 spotify-tray
		pkgs.tree
		pkgs.vlc
		# waypaper
		# https://github.com/quantumvoid0/better-control
		inputs.neovim.packages.${pkgs.system}.default
	];

	programs.git = {
		enable = true;
		userName = "Victor Scarano";
		userEmail = "victorascarano@gmail.com";
	};
	
	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	# update this to 25.05 when it's released
	home.stateVersion = "24.11";

	# let home manager install and manage itself
	# programs.home-manager.enable = true;
}
