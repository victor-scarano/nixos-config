{ pkgs, inputs, ... }: {
	imports = [ inputs.neovim.homeModules.default ];

	home.packages = with pkgs; [
		audacity
		cloc
		discord-canary
		fzf
		gimp3
		google-chrome
		nemo
		obs-studio
		p7zip
		spotify
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

	neovim = {
		enable = true;
		defaultEditor = true;
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

	programs.fastfetch = {
		enable = true;
		settings = {
			logo = {
				source = "nixos";
				padding.right = 2;
			};
			modules = [
				"title" "break" "os" "kernel" "packages" "uptime" "shell" "wm"
				"terminal" "cpu" "gpu" "memory" "disk" "break" "colors"
			];
		};
	};

	home.stateVersion = "25.05";
}
