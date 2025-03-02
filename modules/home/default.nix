{ pkgs, ... }: {
	imports = [ ./fish.nix ./ghostty.nix ./git.nix ./hyprland.nix ./neovim.nix ];

	home.username = "victor";
	home.homeDirectory = "/home/victor";

	programs.home-manager.enable = true;

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

	home.stateVersion = "24.11";
}
