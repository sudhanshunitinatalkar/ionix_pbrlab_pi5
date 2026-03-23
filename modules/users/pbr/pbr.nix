{ inputs, config, lib, pkgs, ... }:
{
  flake.homeModules.pbr = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    # REQUIRED for standalone Home Manager
    home.username = "pbr";
    home.homeDirectory = "/home/pbr";
    home.stateVersion = "25.11";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      tree 
      util-linux 
      vim 
      wget 
      curl 
      git 
      gptfdisk 
      htop 
      fastfetch
      android-tools 
      sops 
      pciutils 
      mosquitto 
      cloudflared 
    ];  
  };
}