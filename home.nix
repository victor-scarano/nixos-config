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
		httrack
		kitty
		lynx
		nautilus
		# neovim; must not be installed for nixvim to work correctly
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
		colorschemes.catppuccin = {
			enable = true;
			settings.transparent_background = true;
		};
		globals = {
			mapleader = " ";
			loaded_netrw = 1; # is this working?
			loaded_netrwPlugin = 1; # is this working?
		};
		keymaps = [
			{
				key = "<leader>q";
				action = "<CMD>bd<CR>";
				options = {
					desc = "Deletes the current buffer.";
					silent = true;
				};
			}
			{
				key = "<leader>h";
				action = "<CMD>lua vim.lsp.buf.hover()<CR>";
				options = {
					desc = "Displays information about symbol under cursor.";
					silent = true;
				};
			}
			{
				key = "<leader>d";
				action = "<CMD>lua vim.lsp.buf.definition()<CR>";
				options = {
					desc = "Goes to definition of symbol under cursor.";
					silent = true;
				};
			}
			{
				key = "<leader>a";
				action = "<CMD>lua vim.lsp.buf.code_action()<CR>";
				options = {
					desc = "Lists possible code actions under cursor.";
					silent = true;
				};
			}
			{
				key = "<leader><tab>";
				action = "<CMD>NvimTreeToggle<CR>";
				options = {
					desc = "Toggles the directory tree.";
					silent = true;
				};
			}
		];
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
		plugins = {
			cmp = {
				enable = true;
				autoEnableSources = true;
				settings = {
					sources = [
						{ name = "nvim_lsp"; }
						{ name = "buffer"; }
						{ name = "path"; }
					];
					mapping.__raw = ''cmp.mapping.preset.insert({ ["<Tab>"] = cmp.mapping.confirm({ select = true }) })'';
					# TODO: window single border config
					# TODO: maybe add some more sources (like cmdline or path)
					# vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
					# vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
				};
			};
			crates.enable = true;
			gitsigns.enable = true;
			indent-blankline = {
				enable = true;
				settings.indent.char = "│"; # alternate chars: '┃' and '▏'
				# TODO: disable scope?
			};
			lsp = {
				enable = true;
				servers = {
					clangd.enable = true;
					lua_ls.enable = true;
					marksman.enable = true;
					nixd.enable = true;
					rust_analyzer.enable = true;
					taplo.enable = true;
					zls.enable = true;
				};
			};
			lualine = {
				enable = true;
				settings = {
					options = {
						theme = "catppuccin";
						section_separators = { left = ""; right = ""; };
						component_separators = { left = ""; right = ""; };
						globalstatus = true;
						refresh.statusline = 1;
					};
					# TODO: sections config
					# TODO: mode text config
				};
			};
			nvim-autopairs.enable = true;
			nvim-tree = {
				enable = true;
				# openOnSetupFile = true;
				# autoReloadOnWrite = true;
			};
			nvim-ufo.enable = true;
			# add spider plugin for counting underscore as a word
			treesitter = {
				enable = true;
				gccPackage = null;
				nixGrammars = true;
				settings = {
					highlight.enable = true;
					indent.enable = true;
				};
			};
			treesitter-context.enable = true;
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
