{ ... }: {
	programs.waybar = {
		enable = false;
		systemd.enable = false;
		settings = {
			mainBar = {
				layer = "top";
				position = "bottom";
				height = null; # set to null for dynamic value
				reload_style_on_change = true;

				modules-left = [ "hyprland/workspaces" ];
				"hyprland/workspaces".all-outputs = true;

				modules-center = [ "hyprland/window" ];

				modules-right = [
					# "backlight/slider"
					# "battery"
					# "bluetooth"
					# "cpu"
					# "clock"
					# "disk"
					# "idle_inhibitor"
					# "memory"
					# "network"
					# "pulseaudio/slider"
					"tray"

					# configure groups
					# maybe taskbar
					# maybe privacy?
					# configure a custom button that activates anyrun
				];
				"hyprland/window".format = "{class}";
			};
		};
		style = ./style.css;
	};
}
