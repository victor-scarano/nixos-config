{ lib, config, pkgs, ... }: {
	home.pointerCursor = {
		gtk.enable = true;
		name = "Breeze";
		size = 32;
		package = pkgs.kdePackages.breeze-icons; # is there a way to use the plasma 5 theme?
	};

	home.packages = with pkgs; [ grim slurp swaybg wl-clipboard ];

	# TODO: configure gtk themes
	# TODO: configure cursor themes
	# TODO: swap h/l resize keybinds
	wayland.windowManager.sway = {
		enable = true;
		extraOptions = [ "--unsupported-gpu" ];
		checkConfig = true;
		swaynag.enable = true;
		systemd.enable = true;
		config = {
			modifier = "Mod4";
			terminal = "ghostty";
			menu = "anyrun";
			output = {
				DP-2 = {
					mode = "2560x1440@240Hz";
					pos = "0 1440";
					bg = "${config.home.path}/share/backgrounds/sway/Sway_Wallpaper_Blue_2048x1536.png fill";
				};
				DP-3 = {
					mode = "2560x1440@144Hz";
					pos = "0 0";
					bg = "${config.home.path}/share/backgrounds/sway/Sway_Wallpaper_Blue_2048x1536.png fill";
				};
			};
			workspaceOutputAssign = [
				{ output = "DP-2"; workspace = "1"; }
				{ output = "DP-3"; workspace = "4"; }
			];
			fonts = { names = [ "UbuntuMono Nerd Font" ]; size = 14.0; };
			bars = [
				{
					fonts = { names = [ "UbuntuMono Nerd Font" ]; size = 14.0; };
					statusCommand = "i3status";
				}
			];
			keybindings = let mod = config.wayland.windowManager.sway.config.modifier; in lib.mkOptionDefault {
				"${mod}+q" = "kill";
				"${mod}+Shift+s" = "exec grim -g \"$(slurp -d)\" - | wl-copy";
			};
			window.titlebar = false;
			input."type:pointer" = {
				accel_profile = "flat";
				pointer_accel = "0.35";
			};
		};
	};

	# should i be using i3status-rust?
	programs.i3status = {
		enable = true;
		enableDefault = false;
		general.separator = " | "; # TODO: fix the missing spaces
		modules = {
			# TODO: configure battery
			# TODO: configure volume https://www.reddit.com/r/i3wm/comments/pbpyo2/i_wrote_a_pipewire_volume_block_for_i3blocks
			# TODO: add power/login button
			time = {
				position = 1; # starts at 0
				settings.format = "%b %-d %-I:%M %p";
			};
		};
	};
}
