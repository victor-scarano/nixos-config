{ ... }: {
	programs.fish = {
		enable = true;
		interactiveShellInit = "set fish_greeting";
		shellAliases.ff = "fastfetch";
	};
}
