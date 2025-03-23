{ ... }: {
	# is there a better way to do any of this configuration here
	# TODO: enable hardware acceleration and disable framerate cap
	# TODO: enable password saving
	programs.firefox = {
		enable = true;
		policies = {
			DisableTelemetry = true;
			DisableFirefoxStudies = true;
			NewTabPage = false;
			Preferences = {
				"browser.fullscreen.autohide" = false;
				"browser.preferences.defaultPerformanceSettings.enabled" = false;
				"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
			};
			ExtensionSettings = {
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
