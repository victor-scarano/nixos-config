{ pkgs, inputs, ... }: {
	imports = [ inputs.neovim.homeModules.default ];

	home.packages = with pkgs; [
		audacity
		cloc
		discord-canary
		fzf
		gimp3
		google-chrome
		nemo
		obs-studio
		spotify
		vlc
		unzip
		wireplumber
		zoom-us
	];

	programs.git = {
		enable = true;
		userName = "Victor Scarano";
		userEmail = "victorascarano@gmail.com";
	};
	
	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases = {
			cls = "clear";
			ff = "fastfetch";
			rm = "rm -i";
		};
		functions = {
			fish_prompt = ''
				# This is a modified version of the Astronaut prompt preset.

				set -l last_status $status
				set -l normal (set_color normal)
				set -l status_color (set_color brgreen)
				set -l cwd_color (set_color $fish_color_cwd)
				set -l vcs_color (set_color brpurple)
				set -l prompt_status ""

				# Since we display the prompt on a new line allow the directory names to be longer.
				set -q fish_prompt_pwd_dir_length
				or set -lx fish_prompt_pwd_dir_length 0

				# Color the prompt differently when we're root
				set -l suffix '$'
				if functions -q fish_is_root_user; and fish_is_root_user
					if set -q fish_color_cwd_root
						set cwd_color (set_color $fish_color_cwd_root)
					end
					set suffix '#'
				end

				# Color the prompt in red on error
				if test $last_status -ne 0
					set status_color (set_color $fish_color_error)
					set prompt_status $status_color "[" $last_status "]" $normal
				end

				echo
				echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
				echo -n -s $status_color $suffix ' ' $normal
			'';
		};
	};

	neovim = {
		enable = true;
		defaultEditor = true;
		languages = {
			c.enable = true;
			lua.enable = true;
			markdown.enable = true;
			nix.enable = true;
			python.enable = true;
			rust.enable = true;
			toml.enable = true;
			zig.enable = true;
		};
	};

	programs.fastfetch = {
		enable = true;
		settings = {
			logo = {
				source = "nixos";
				padding.right = 2;
			};
			modules = [
				"title"
				"break"
				"os"
				"kernel"
				"packages"
				"uptime"
				"shell"
				"wm"
				"terminal"
				"cpu"
				"gpu"
				"memory"
				"disk"
				"break"
				"colors"
			];
		};
	};

	home.stateVersion = "25.05";
}
