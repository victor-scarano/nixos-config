{
	description = "My NixOS Configuration.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/nix-community/lanzaboote
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		anyrun = {
			url = "github:anyrun-org/anyrun";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		neovim.url = "path:./../../modules/neovim";
	};

	outputs = inputs @ { nixpkgs, home-manager, lanzaboote, ... }: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				lanzaboote.nixosModules.lanzaboote
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs; };
					# for some reason this can't be shorthanded to ../../modules/home
					home-manager.users.victor = import ./../../modules/home;
				}
			];
		};
	};
}
