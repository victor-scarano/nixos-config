{
	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases = {
			"cd.." = "cd ..";
			ls = "ls --color";
			lsa = "ls --color -a";
			ff = "fastfetch";
		};
	};
}
