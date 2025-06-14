{ ... }: {
	programs.ghostty = {
		enable = true;
		settings = {
			theme = "vesper";
			font-family = "UbuntuMono Nerd Font";
			font-size = 26;
			window-decoration = false;
			confirm-close-surface = false;
			# background = "Black";
			keybind = [
				"alt+t=new_tab"
				"alt+1=goto_tab:1"
				"alt+2=goto_tab:2"
				"alt+3=goto_tab:3"
				"alt+4=goto_tab:4"
				"alt+5=goto_tab:5"
				"alt+6=goto_tab:6"
				"alt+7=goto_tab:7"
				"alt+8=goto_tab:8"
				"alt+9=goto_tab:9"
				"alt+0=goto_tab:10"
			];
		};
		enableFishIntegration = true;
	};
}
