{ pkgs, inputs, ... }: {
	imports = [ inputs.neovim.homeModules.default ];

	home.packages = with pkgs; [
		audacity
		cloc
		discord-canary
		fastfetch
		fzf
		gimp3
		google-chrome
		nemo
		obs-studio
		spotify
		tmux
		vlc
		unzip
		wireplumber
		zoom-us
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
			c.enable = true;
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
