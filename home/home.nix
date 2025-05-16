{ pkgs, inputs, ... }: {
	imports = [ inputs.my-neovim.homeModules.my-neovim ];

	home = {
		username = "victor";
		homeDirectory = "/home/victor";
	};

	home.packages = with pkgs; [
		audacity
		btop
		discord-canary
		fastfetch # TODO: configure with home manager
		ffmpeg
		file
		fzf
		ghidra-bin
		gimp
		google-chrome
		libreoffice
		lunar-client
		obsidian
		obs-studio
		python314
		cargo
		spotify
		tree
		tmux
		vlc
		zig
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

	programs.yazi = {
		enable = true;
		enableFishIntegration = true;
	};

	# update this to 25.05 when it's released
	home.stateVersion = "24.11";
}
