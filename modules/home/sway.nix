{ pkgs, ... }: {
	home.pointerCursor = {
		gtk.enable = true;
		name = "Breeze";
		size = 32;
		package = pkgs.kdePackages.breeze-icons;
	};

	# TODO: configure multiple monitor configuration
	# TODO: change application quit keybind
	# TODO: remove application title bar
	# TODO: configure screenshot keybind
	# TODO: configure file manager keybind
	# TODO: configure window blurring/transparency
	# TODO: configure gtk themes
	# TODO: configure cursor themes
	# TODO: configure mouse sensitivity
	# TODO: remove hyprland
	wayland.windowManager.sway = {
		enable = true;
		extraOptions = [ /* "--unsupported-gpu" */ ];
		checkConfig = true;
		swaynag.enable = true;
		systemd.enable = true;
		config = {
			modifier = "Mod4";
			terminal = "ghostty";
			menu = "anyrun";
			fonts = {
				names = [ "UbuntuMono Nerd Font" ];
				size = 14.0;
			};
			bars = [{
				fonts = {
					names = [ "UbuntuMono Nerd Font" ];
					size = 14.0;
				};
				statusCommand = "i3status";
			}];
		};
	};

	programs.i3status = {
		enable = true;
		enableDefault = false;
		general = {
			separator = " | ";
		};
		modules = {
			# TODO: configure battery
			# TODO: configure cpu usage
			# TODO: configure time
			# TODO: configure date
			# TODO: configure volume
			# TODO: configure application title
			"disk /" = {
				position = 0;
				settings.format = "Disk (/): %percentage_used"; # "Disk (/): %avail / %total (%percentage_used)"
			};
			"disk /home" = {
				position = 1;
				settings.format = "Disk (/home): %percentage_used"; # "Disk (/home): %avail / %total (%percentage_used)";
			};
		};
	};
}
