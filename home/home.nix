{ pkgs, inputs, ... }: {
	imports = [ inputs.my-neovim.homeModules.default ];

	home = {
		username = "victor";
		homeDirectory = "/home/victor";
	};

	home.packages = with pkgs; [
		btop
		discord-canary
		fastfetch
		fzf
		google-chrome
		libreoffice
		spotify
		tree
		tmux
		vlc
		unzip

		# waypaper
		# spotify-tray # TODO: GDK_BACKEND=x11 spotify-tray
		# https://github.com/quantumvoid0/better-control
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

	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases.ff = "fastfetch";
	};

	neovim = {
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

	programs.yazi = {
		enable = true;
		enableFishIntegration = true;
	};

	home.stateVersion = "25.05";
}
