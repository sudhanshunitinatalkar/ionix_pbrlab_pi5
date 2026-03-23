{ inputs, config, ... }: 
{
  # CHANGED: Use the custom system builder from the raspberrypi flake
  flake.nixosConfigurations."ionixpbrlabpi5" = inputs.nixos-raspberrypi.lib.nixosSystem {
    system = "aarch64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      config.flake.nixosModules.ionixpbrlabpi5
      config.flake.nixosModules.ionixpbrlabpi5_hardware
    ];
  };
}