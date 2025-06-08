sudo -E git add .
sudo nix flake update
sudo nixos-rebuild switch --flake /etc/nixos --upgrade
nix-collect-garbage
nix-collect-garbage -d
sudo nix-collect-garbage
sudo nix-collect-garbage -d
