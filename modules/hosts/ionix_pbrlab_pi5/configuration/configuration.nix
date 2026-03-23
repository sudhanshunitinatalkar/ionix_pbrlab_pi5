{
  flake.nixosModules.ionixpbrlabpi5 = { inputs, pkgs, ... }:
  {
    # ADDED: Import the Pi 5 specific configuration modules
    imports = with inputs.nixos-raspberrypi.nixosModules; [
      raspberry-pi-5.base
      raspberry-pi-5.bluetooth
    ];

    system.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;

    # Notice how the whole `boot = { ... }` block is gone now! The base module handles it.

    networking = {
      hostName = "ionixpbrlabpi5";
      networkmanager.enable = true;
      firewall.enable = false;
    };

    users.users.pbr = {
      initialPassword = "pbr";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    time.timeZone = "Asia/Kolkata";

    services = {
      printing.enable = true;
      openssh.enable = true;
    };

    environment.systemPackages = with pkgs; [
      tree util-linux vim wget curl git gptfdisk htop pciutils home-manager
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = "us";
  };
}