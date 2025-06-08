{ inputs, pkgs, ... }: {
	nix.settings = {
		builders-use-substitutes = true;
		extra-substituters = [ "https://anyrun.cachix.org" ];
		extra-trusted-public-keys = [ "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s=" ];
	};

	programs.anyrun = {
		enable = true;
		config = {
			x = { fraction = 0.5; };
			y = { absolute = 16; };
			width = { fraction = 0.1; };
			height = { absolute = 0; };
			hideIcons = false;
			ignoreExclusiveZones = false;
			layer = "overlay";
			hidePluginInfo = true;
			showResultsImmediately = true;
			maxEntries = null;
			plugins = [ inputs.anyrun.packages.${pkgs.system}.applications ];
		};
		extraCss = ''
			#window {
				background-color: rgba(0, 0, 0, 0);
			}

			box#main {
				border-radius: 10px;
				background-color: @theme_bg_color;
			}

			list#main {
				background-color: rgba(0, 0, 0, 0);
				border-radius: 10px;
			}

			list#plugin {
				background-color: rgba(0, 0, 0, 0);
			}

			label#match-desc {
				font-size: 10px;
			}

			label#plugin {
				font-size: 14px;
			}
		'';
		extraConfigFiles."applications.ron".text = ''
			Config(
				desktop_actions: false,
				max_entries: 10,
				// A command to preprocess the command from the desktop file. The commands should take arguments in this order:
				// command_name <term|no-term> <command>
				// preprocess_exec_script: Some("/home/user/.local/share/anyrun/preprocess_application_command.sh")
				terminal: Some(Terminal(
					command: "ghostty",
					args: "-e {}",
				)),
			)
		'';
	};
}
