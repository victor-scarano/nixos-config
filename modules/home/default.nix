{ pkgs, ... }: {
	imports = [
		./fish.nix
		./ghostty.nix
		./git.nix
		./hyprland.nix
		./librewolf.nix
		./neovim.nix
	];

	# home-manager.useGlobalPkgs = true;
	# home-manager.useUserPkgs = true;
	nix.package = pkgs.nix;
	nixpkgs.config.allowUnfree = true;

	home.username = "victor";
	home.homeDirectory = "/home/victor";

	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		anyrun
		btop
		discord-canary
		fastfetch
		# file
		# fzf
		gh
		gimp
		github-desktop
		# gnupg
		google-chrome
		grim
		nautilus
		networkmanagerapplet
		obsidian
		ripgrep
		rustdesk
		rustup
		slurp
		spotify
		# stow
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

	home.stateVersion = "24.11";
}
