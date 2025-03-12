{
	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases = {
			ls = "ls --color";
			lsa = "ls --color -a";
			ff = "fastfetch";
		};
	};
}
