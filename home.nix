{ config, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
	imports = [ (import "${home-manager}/nixos") ];

	home-manager.users.victor = {
		home = {
			stateVersion = "24.11";
			packages = with pkgs; [
				anyrun
				fastfetch
				oh-my-posh
				neovim
				zsh
			];
		};
		programs = {
			chromium.enable = true;
			firefox.enable = true;
			ghostty = {
				enable = true;
				settings = {
					theme = "vesper";
					font-family = "UbuntuMono Nerd Font";
					font-size = 23;
					shell-integration = "zsh";
					window-decoration = false;
					background-opacity = 0.7;
					mouse-hide-while-typing = true;
				};
			};
			gh = {
				enable = true;
				gitCredentialHelper.enable = true;
			};
			git = {
				enable = true;
				userName = "Victor Scarano";
				userEmail = "victorascarano@gmail.com";
			};
			kitty = {
				enable = true;
				font = {
					name = "UbuntuMono Nerd Font";
					size = 23;
				};
				settings = {
					window_padding_width = 0;
					# modify_font underline_position 2
					background_opacity = 0.7;
				};
			};
		};
	};
}
