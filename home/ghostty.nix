{ ... }: {
	programs.ghostty = {
		enable = true;
		settings = {
			theme = "vesper";
			font-family = "UbuntuMono Nerd Font";
			font-size = 26;
			window-decoration = false;
			confirm-close-surface = false;
			background = "Black";
		};
		enableFishIntegration = true;
	};
}
