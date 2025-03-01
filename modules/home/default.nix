{ pkgs, ... }:

{
	imports = [
		./neovim.nix
		# inputs.nixvim.homeManagerModules.nixvim
	];

	home.username = "victor";
	home.homeDirectory = "/home/victor";

	home.packages = with pkgs; [
		anyrun
		btop
		discord-canary
		fastfetch
		file
		firefox
		fzf
		gh
		gimp
		github-desktop
		gnupg
		google-chrome
		grim
		nautilus
		networkmanagerapplet
		obsidian
		ripgrep
		rustup
		slurp
		spotify
		stow
		swww
		tree
		unzip
		vlc
		waypaper
		which
		wl-clipboard
		zig
		zip
		zls
	];

	programs.ghostty = {
		enable = true;
		settings = {
			theme = "vesper";
			font-family = "UbuntuMono Nerd Font";
			font-size = 26;
			window-decoration = false;
			mouse-hide-while-typing = true;
			confirm-close-surface = false;
			background = "Black";
			# background-opacity = 0.7;
		};
		enableFishIntegration = true;
	};

	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases = {
			# clear = "clear && printf '\033[3J";
			# cls = "clear && printf '\033[3J";
			"cd.." = "cd ..";
			ls = "ls --color";
			lsa = "ls --color -a";
			ff = "fastfetch";
		};
	};

	programs.git = {
		enable = true;
		userName = "Victor Scarano";
		userEmail = "victorascarano@gmail.com";
	};
	
	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	# This value determines the home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new home Manager release introduces backwards
	# incompatible changes.
	# You can update home Manager without changing this value. See
	# the home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "24.11";

	# let home Manager install and manage itself.
	programs.home-manager.enable = true;
}
