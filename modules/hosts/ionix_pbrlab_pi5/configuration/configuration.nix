{
  flake.nixosModules.ionixpbrlabpi5 = { inputs, pkgs, ... }:
  {
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "sudha" ];
    };
    system.stateVersion = "25.11";
    nixpkgs.config.allowUnfree = true;

    boot = {
      # CHANGED: Use the aarch64 rpi4 kernel for the Pi 5
      kernelPackages = pkgs.linuxPackages_rpi4;
      
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = false; # Set to false for removable media/initial setup
        timeout = 0;
      };
    };

    hardware.bluetooth.enable = true;

    networking =
    {
      hostName = "ionixpbrlabpi5";
      networkmanager.enable = true;
      firewall.enable = false;
      # firewall.allowedTCPPorts = [ ];
      # firewall.allowedUDPPorts = [ ];
    };

    users.users.pbr = 
    {
      initialPassword = "pbr";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      
    };

    time = {
      timeZone = "Asia/Kolkata";
    };
    
    services =
    {
      printing.enable = true;
      openssh.enable = true;
    };

    environment.systemPackages = with pkgs;
    [
      tree
      util-linux
      vim
      wget
      curl
      git
      gptfdisk
      htop
      pciutils
      home-manager
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    console =
    {
      keyMap = "us";
    }; 

  };
}
