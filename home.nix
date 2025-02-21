{ config, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
	imports = [ (import "${home-manager}/nixos") ];

	home-manager.users.victor = {
		home = {
			stateVersion = "24.11";
			packages = with pkgs; [ ];
		};
		programs = {
			gh = {
				enable = true;
				gitCredentialHelper.enable = true;
			};
			git = {
				enable = true;
				userName = "Victor Scarano";
				userEmail = "victorascarano@gmail.com";
			};
		};
	};
}
