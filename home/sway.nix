{ lib, config, pkgs, ... }: {
	home.packages = with pkgs; [ grim slurp wl-clipboard ];

	home.pointerCursor = {
		# NOTE: <package>/share/icons/<theme>/cursors
		name = "Breeze_Light"; # breeze_cursors or Breeze_Light
		package = pkgs.kdePackages.breeze;
		size = 32;
		sway.enable = true;
		gtk.enable = true; # does kdePackages.breeze-icons work if this is enabled?
	};

	gtk = {
		enable = true;
		theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
		};
	};

	wayland.windowManager.sway = {
		# TODO: swap h/l resize keybinds
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
				DP-2 = { mode = "2560x1440@240Hz"; pos = "0 1440"; };
				DP-3 = { mode = "2560x1440@144Hz"; pos = "0 0"; };
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
				"${mod}+Shift+s" = "exec grim -g \"$(slurp -d)\" - | wl-copy";
			};
			window.titlebar = false;
			input."type:pointer" = {
				accel_profile = "flat";
				pointer_accel = "0.35";
			};
		};
	};

	programs.i3status = {
		# i3blocks?
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
