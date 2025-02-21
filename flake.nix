{
	description = "A simple NixOS flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		lanzaboote = {
			url = "github:nix-community/lanzaboote/v0.4.2";
			# Optional but recommended to limit the size of your system closure.
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, lanzaboote, ... } @ inputs: {
		nixosConfigurations.victor-nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				lanzaboote.nixosModules.lanzaboote
			];
		};
	};
}
