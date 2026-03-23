{ inputs, config, ... }:

{
  flake.homeConfigurations.pbr = inputs.home-manager.lib.homeManagerConfiguration {
    # Use legacyPackages from the current system (impure, but works fine for local switch)
    # Fallback to x86_64-linux if evaluation is pure / no currentSystem
    pkgs = inputs.nixpkgs.legacyPackages.${builtins.currentSystem or "x86_64-linux"};

    extraSpecialArgs = { inherit inputs; };

    modules = [
      config.flake.homeModules.pbr
    ];
  };
}