{ pkgs, ... }: {
	imports = [
		./anyrun.nix
		./fish.nix
		./ghostty.nix
		./git.nix
		./hyprland.nix
		./librewolf.nix
		./nixvim.nix
	];

	nix.package = pkgs.nix; # what does this do
	nixpkgs.config.allowUnfree = true;

	home = {
		enableNixpkgsReleaseCheck = false;
		username = "victor";
		homeDirectory = "/home/victor";
	};

	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		btop
		discord-canary
		fastfetch # configure with home manager
		fzf
		gimp
		google-chrome
		grim
		nautilus
		networkmanagerapplet
		obsidian
		ripgrep
		rustup
		slurp
		spotify
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
