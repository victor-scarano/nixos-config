{ config, pkgs, inputs, ... }:

{
	imports = [ inputs.nixvim.homeManagerModules.nixvim ];

	home.username = "victor";
	home.homeDirectory = "/home/victor";

	# link the configuration file in current directory to the specified location in home directory
	# home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

	# link all files in `./scripts` to `~/.config/i3/scripts`
	# home.file.".config/i3/scripts" = {
	#   source = ./scripts;
	#   recursive = true;   # link recursively
	#   executable = true;  # make all files executable
	# };

	# encode the file content in nix configuration file directly
	# home.file.".xxx".text = ''
	#     xxx
	# '';

	# Packages that should be installed to the user profile.
	home.packages = with pkgs; [
		anyrun
		btop
		discord-canary
		fastfetch
		file
		firefox
		fzf
		gh
		ghostty
		gimp
		github-desktop
		gnupg
		google-chrome
		grim
		kitty
		nautilus
		neovim
		networkmanagerapplet
		obsidian
		oh-my-posh
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

	programs.nixvim = {
		enable = true;
		enableMan = true;
		colorschemes.catpuccin.enable = true;
		globals = {
			mapleader = " ";
			loaded_netrw = 1;
			loaded_netrwPlugin = 1;
		};
		opts = {
			number = true;
			relativenumber = true;
			showmode = false;
			# clipboard = "unnamedplus";
			tabstop = 4;
			expandtab = false;
			shiftwidth = 4;
			wrap = true;
			termguicolors = true;
			# colorcolumn = { 80, 120 };
			foldlevel = 99;
			foldlevelstart = 99;
			laststatus = 3;
			# signcolumn = ""
			autoindent = true;
			smartindent = true;
			# iskeyword:remove("_")
			# iskeyword:append("_")
		};
		viAlias = true;
		vimAlias = true;
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
