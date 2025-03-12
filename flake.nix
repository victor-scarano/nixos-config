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
			# optional but recommended to limit the size of the system closure
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprland.url = "github:hyprwm/Hyprland";

		anyrun = {
			url = "github:anyrun-org/anyrun";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ { nixpkgs, home-manager, lanzaboote, anyrun, nixvim, ... }: {
		nixosConfigurations = {
			victor-nixos = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs; };
				modules = [
					./modules/nixos/default.nix
					lanzaboote.nixosModules.lanzaboote
				];
			};
		};
		homeConfigurations = {
			"victor@victor-nixos" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit inputs; };
				modules = [
					./modules/home/default.nix
					anyrun.homeManagerModules.default
					nixvim.homeManagerModules.default
				];
			};
		};
	};
}
