{ inputs, pkgs, ... }: {
	/*
	nix.settings = {
		substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
	};

	home.pointerCursor = {
		gtk.enable = true;
		package = pkgs.kdePackages.breeze-icons;
		name = "Breeze";
		size = 32;
	};

	gtk = {
		enable = true;
		theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
		};
		iconTheme = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
		};
	};

	dconf = {
		enable = true;
		settings = {
			"org/gnome/desktop/interface" = {
				color-scheme = "prefer-dark";
			};
		};
	};
	*/

	wayland.windowManager.hyprland = {
		enable = true;
		# package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		# portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
		systemd.variables = ["--all"];
		settings = {
			env = [
				"XCURSOR_THEME, Breeze"
				"XCURSOR_SIZE, 32"
				"HYPRCURSOR_SIZE, 32"
			];
			monitor = [
				"DP-2, 2560x1440@240, 0x0, auto"
				"DP-3, 2560x1440@144, 2560x-430, auto, transform, 1"
			];
			general = {
				# border_size = 2;
				# gaps_in = 4.5;
				# gaps_out = 8;
				"col.active_border" = "rgb(ffffff)";
				"col.inactive_border" = "rgb(ffffff)";
				resize_on_border = true;
				allow_tearing = false;
				layout = "dwindle";
				snap.enabled = true;
			};
			decoration = {
				rounding = 0;
				blur = {
					enabled = true;
					size = 5;
					passes = 2;
					vibrancy = 1;
				};
			};
			animation = [
				"windowsIn, 1, 3, default, slide"
				"windowsOut, 1, 3, default, slide"
				"windowsMove, 1, 3, default, popin"
				"border, 1, 10, default"
				"borderangle, 1, 8, default"
				"fade, 1, 7, default"
				"workspaces, 1, 3, default, slidevert"
			];
			input = {
				kb_layout = "us";
				follow_mouse = 1;
				sensitivity = -0.75;
			};
			misc = {
				force_default_wallpaper = 0;
				disable_hyprland_logo = true;
			};
			bind = [
				"SUPER, RETURN, exec, ghostty"
				"SUPER, Q, killactive"
				"SUPER, E, exec, nautilus"
				"SUPER, V, togglefloating,"
				"SUPER, D, exec, anyrun"
				"SUPER, F, fullscreen"

				"SUPER, h, movefocus, l"
				"SUPER, j, movefocus, d"
				"SUPER, k, movefocus, u"
				"SUPER, l, movefocus, r"

				"SUPER, 1, workspace, 1"
				"SUPER, 2, workspace, 2"
				"SUPER, 3, workspace, 3"
				"SUPER, 4, workspace, 4"
				"SUPER, 5, workspace, 5"
				"SUPER, 6, workspace, 6"
				"SUPER, 7, workspace, 7"
				"SUPER, 8, workspace, 8"
				"SUPER, 9, workspace, 9"
				"SUPER, 0, workspace, 10"

				"SUPER SHIFT, 1, movetoworkspace, 1"
				"SUPER SHIFT, 2, movetoworkspace, 2"
				"SUPER SHIFT, 3, movetoworkspace, 3"
				"SUPER SHIFT, 4, movetoworkspace, 4"
				"SUPER SHIFT, 5, movetoworkspace, 5"
				"SUPER SHIFT, 6, movetoworkspace, 6"
				"SUPER SHIFT, 7, movetoworkspace, 7"
				"SUPER SHIFT, 8, movetoworkspace, 8"
				"SUPER SHIFT, 9, movetoworkspace, 9"
				"SUPER SHIFT, 0, movetoworkspace, 10"

				"SUPER, C, togglespecialworkspace, magic"
				"SUPER SHIFT, C, movetoworkspace, special:magic"

				"SUPER SHIFT, S, exec, grim -g $(slurp -d) - | wl-copy"

			];
			bindm = [ "SUPER, mouse:272, movewindow" ];
		};
	};
}
