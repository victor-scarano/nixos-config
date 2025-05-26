{ pkgs, inputs, ... }: {
	imports = [ inputs.neovim.homeModules.default ];

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
		shellAliases = {
			cls = "clear";
			ff = "fastfetch";
		};
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

	home.stateVersion = "25.05";
}
