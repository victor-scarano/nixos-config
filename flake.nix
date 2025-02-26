{
	description = "My NixOS Configuration.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2";
			# optional but recommended to limit the size of the system closure
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ { nixpkgs, home-manager, lanzaboote, ... }: {
		nixosConfigurations.victor-nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.victor = import ./home.nix;
					home-manager.extraSpecialArgs = { inherit inputs; };
					# optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
				}
				lanzaboote.nixosModules.lanzaboote
			];
		};
	};
}
