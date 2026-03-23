{ inputs, config, ... }: 
{
  flake.nixosConfigurations."ionixpbrlabpi5" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      inputs.disko.nixosModules.disko
      config.flake.nixosModules.ionixpbrlabpi5
      config.flake.nixosModules.ionixpbrlabpi5_hardware
      config.flake.nixosModules.ionixpbrlabpi5_disko
    ];
  };
}