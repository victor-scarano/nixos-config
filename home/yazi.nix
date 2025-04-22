{ ... }: {
	programs.yazi = {
		enable = true;
		enableFishIntegration = true;
		shellWrapperName = "yazi";
	};
}
