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
			keybind = [
				"alt+1=unbind"
				"alt+2=unbind"
				"alt+3=unbind"
				"alt+4=unbind"
				"alt+5=unbind"
				"alt+6=unbind"
				"alt+7=unbind"
				"alt+8=unbind"
				"alt+9=unbind"
				"alt+0=unbind"
				"ctrl+1=unbind"
				"ctrl+2=unbind"
				"ctrl+3=unbind"
				"ctrl+4=unbind"
				"ctrl+5=unbind"
				"ctrl+6=unbind"
				"ctrl+7=unbind"
				"ctrl+8=unbind"
				"ctrl+9=unbind"
				"ctrl+0=unbind"
			];
		};
		enableFishIntegration = true;
	};
}
