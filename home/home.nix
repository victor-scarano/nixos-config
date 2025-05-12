{ pkgs, inputs, ... }: {
	imports = [ inputs.my-neovim.homeModules.my-neovim ];

	home = {
		username = "victor";
		homeDirectory = "/home/victor";
	};

	home.packages = [
		pkgs.btop
		pkgs.discord-canary
		pkgs.fastfetch # TODO: configure with home manager
		pkgs.ffmpeg
		pkgs.file
		pkgs.fzf
		pkgs.gimp
		pkgs.google-chrome
		pkgs.libreoffice
		pkgs.lunar-client
		pkgs.obsidian
		pkgs.obs-studio
		pkgs.python314
		pkgs.cargo
		pkgs.spotify
		# spotify-tray # TODO: GDK_BACKEND=x11 spotify-tray
		pkgs.tree
		pkgs.tmux
		pkgs.vlc
		pkgs.zig
		pkgs.unzip
		# waypaper
		# https://github.com/quantumvoid0/better-control
		# inputs.neovim.packages.${pkgs.system}.default
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

	my-neovim = {
		enable = true;
		languages = {
			lua.enable = true;
			markdown.enable = true;
			nix.enable = true;
			python.enable = true;
			rust.enable = true;
			toml.enable = true;
			zig.enable = true;
		};
	};

	# update this to 25.05 when it's released
	home.stateVersion = "24.11";
}
