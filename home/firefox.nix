{ pkgs, ... }: {
	# is there a better way to do any of this configuration here?
	# TODO: enable hardware acceleration and disable framerate cap
	programs.firefox = {
		enable = true;
		package = pkgs.firefox-wayland;
		policies = {

			DisableTelemetry = true;
			DisableFirefoxStudies = true;
			EnableTrackingProtection = {
				Value = true;
				Locked = true;
				Cryptomining = true;
				Fingerprinting = true;
			};
			DisablePocket = true;
			DisableFirefoxAccounts = true;
			DisableAppUpdate = true;
			OverrideFirstRunPage = "";
			OverridePostUpdatePage = "";
			DontCheckDefaultBrowser = true;
			DisplayBookmarksToolbar = "never";
			NewTabPage = false;
			Preferences = {
				"browser.fullscreen.autohide" = false;
				"browser.preferences.defaultPerformanceSettings.enabled" = false;
				"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
			};
			ExtensionSettings = {
				"*".installation_mode = "blocked"; # blocks all addons except the ones specified
				"@testpilot-containers" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/file/4494279/multi_account_containers-8.3.0.xpi";
					installation_mode = "force_installed";
				};
				"uBlock0@raymondhill.net" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
					installation_mode = "force_installed";
				};
				"{c4b582ec-4343-438c-bda2-2f691c16c262}" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/file/4443148/600_sound_volume-2.0.2.xpi";
					installation_mode = "force_installed";
				};
				"addon@darkreader.org" = {
					install_url = "https://addons.mozilla.org/firefox/downloads/file/4439735/darkreader-4.9.103.xpi";
					installation_mode = "force_installed";
				};
			};
		};
	};
}
