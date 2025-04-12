# TODO: create a home manager module? (neovim.enable = true) (vimAlias = true)
# TODO: set binary as user's defualt editor ($EDITOR)
{
    description = "My Neovim Flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem (system: let
			pkgs = import nixpkgs { inherit system; };
			plugins = with pkgs.vimPlugins; [
				bamboo-nvim
				catppuccin-nvim
				cmp-nvim-lsp
				crates-nvim
				gitsigns-nvim
				indent-blankline-nvim # indent-blankline-nvim-lua
				lualine-nvim
				nvim-autopairs
				nvim-cmp
				nvim-lspconfig
				nvim-tree-lua
				nvim-treesitter
				nvim-treesitter-context
				nvim-ufo
				nvim-web-devicons
				telescope-nvim
				vscode-nvim
			];
			runtime = with pkgs; [
				clang-tools
				lua-language-server
				nixd
				pyright
				ripgrep
				rust-analyzer
				taplo
				vscode-langservers-extracted
				zls
			];
			config = pkgs.neovimUtils.makeNeovimConfig {
				# do these even work?
				# vimAlias = true;
				# wrapRc = false;
				luaRcContent = builtins.readFile ./init.lua;
				plugins = plugins;
			};
			wrapped = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped config;
		in {
			# is there an easier way to add runtime dependencies to the path?
			# https://github.com/mrcjkb/haskell-tools.nvim/blob/master/nix/haskell-tooling-overlay.nix
			packages.default = pkgs.stdenv.mkDerivation {
				name = "nvim";
				buildInputs = [ pkgs.makeWrapper ];
				dontUnpack = true;
				installPhase = ''
					mkdir -p $out/bin
					makeWrapper ${wrapped}/bin/nvim $out/bin/nvim --prefix PATH : "${pkgs.lib.makeBinPath runtime}"
				'';
			};
		});
}
