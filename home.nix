{ pkgs, inputs, ... }:

{
	imports = [ inputs.nixvim.homeManagerModules.nixvim ];

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
		extraConfigLua = ''
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
				callback = function()
					if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
						vim.schedule(function()
							vim.cmd.nohlsearch()
						end)
					end
				end
			})
		'';
		colorschemes.catppuccin = {
			enable = true;
			settings.transparent_background = true;
		};
		globals.mapleader = " ";
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
			colorcolumn = [ 80 120 ];
			foldlevel = 99;
			foldlevelstart = 99;
			laststatus = 3;
			# signcolumn = ""
			autoindent = true;
			smartindent = true;
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
					window = {
						completion = {
							__raw = ''require("cmp").config.window.bordered({ border = "single" })'';
							scrollbar = false;
						};
						documentation.__raw = ''require("cmp").config.window.bordered({ border = "single" })'';
					};
					# TODO: maybe add some more sources (like cmdline or path)
				};
			};
			crates.enable = true;
			gitsigns.enable = true;
			indent-blankline = {
				enable = true;
				settings.indent.char = "│"; # alternate chars: '┃' and '▏'
				settings.scope.enabled = false;
			};
			lsp = {
				enable = true;
				# TODO: enable inlay hints and create keybind to toggle them
				servers = {
					clangd.enable = true;
					lua_ls.enable = true;
					marksman.enable = true;
					nixd.enable = true;
					rust_analyzer = {
						enable = true;
						installCargo = true;
						installRustc = true;
					};
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
				autoReloadOnWrite = true;
				disableNetrw = true;
				hijackNetrw = true;
				hijackDirectories = {
					enable = true;
					autoOpen = true;
				};
				openOnSetup = true;
			};
			nvim-ufo.enable = true;
			# add spider plugin for counting underscore as a word
			telescope = {
				enable = true;
				keymaps = {
					"<leader>f" = {
						action = "find_files";
						options = {
							desc = "List files using Telescope.";
							silent = true;
						};
					};
					"<leader>g" = {
						action = "live_grep";
						options = {
							desc = "Live grep files using Telescope.";
							silent = true;
						};
					};
					"<leader>b" = {
						action = "buffers";
						options = {
							desc = "List open buffers using Telescope.";
							silent = true;
						};
					};
				};
				settings.defaults = {
					border = {
						prompt = [ 1 1 1 1 ];
						results = [ 1 1 1 1 ];
						preview = [ 1 1 1 1 ];
					};
					borderchars = {
						prompt = [ " " " " "─" "│" "│" " " "─" "└" ];
						results = [ "─" " " " " "│" "┌" "─" " " "│" ];
						preview = [ "─" "│" "─" "│" "┬" "┐" "┘" "┴" ];
					};
				};
				# TODO: telescope-ui-select.nvim
			};
			treesitter = {
				enable = true;
				gccPackage = null;
				nixGrammars = true;
				settings = {
					auto_install = true;
					highlight.enable = true;
					indent.enable = true;
					sync_install = true;
				};
			};
			treesitter-context = {
				enable = true;
				settings.max_lines = 1;
			};
			web-devicons.enable = true;
			which-key = {
				enable = true;
				settings.delay = 1000;
			};
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
