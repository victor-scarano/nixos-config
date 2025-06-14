sudo -E git add .
sudo nix flake update
sudo nixos-rebuild switch --flake /etc/nixos --upgrade
nix-collect-garbage 2> /dev/null
nix-collect-garbage -d 2> /dev/null
sudo nix-collect-garbage 2> /dev/null
sudo nix-collect-garbage -d 2> /dev/null
