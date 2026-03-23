# ionix_pbrlab_pi5

## To enable conservation mode (write '1' to the file)

echo 1 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

## To disable it

echo 0 | sudo tee /sys/bus/platform/devices/VPC2004:00/conservation_mode

## github ssh key command

ssh-keygen -t ed25519 -C "<atalkarsudhanshu@proton.me>"

home-manager switch --flake github:sudhanshunitinatalkar/nixos#sudha
sudo nixos-rebuild switch --flake github:sudhanshunitinatalkar/nixos#cosmoslaptop
nix run github:nix-community/home-manager -- switch --flake github:sudhanshunitinatalkar/nixos#sudha
home-manager switch --flake .#sudha

## plasma-manager

nix run github:nix-community/plasma-manager

## command to print file content of this project

```bash
find . -type f -not -path '*/\.*' -not -name 'flake.lock' -not -name '*.jpg' -print0 \
  | while IFS= read -r -d '' file; do
      echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo "┃  $file"
      echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
      echo ""
      cat "$file"
      echo ""
      echo ""
    done
```
