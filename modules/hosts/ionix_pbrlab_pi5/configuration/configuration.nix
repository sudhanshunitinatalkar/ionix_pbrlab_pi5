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
      mosquitto
      cloudflared
    ];

    time.timeZone = "Asia/Kolkata";

    services = {
      openssh.enable = true;
      mosquitto = 
        {
          enable = true;
    
          listeners = [
            {
              port = 3001;
              address = "127.0.0.1";
              settings = {
                protocol = "websockets";
              };
              
              # Users MUST be placed inside the listener they apply to
              users = {
                datalogger = {
                  acl = [ 
                    "readwrite /datalogger/#"
                    "read /datalogger_admin/#"
                  ];
                  hashedPasswordFile = "/var/lib/mosquitto/datalogger_passwd"; 
                };
                
                datalogger_admin = {
                  acl = [
                    "readwrite /datalogger_admin/#"
                    "readwrite /datalogger/#"
                  ];
                  hashedPasswordFile = "/var/lib/mosquitto/datalogger_admin_passwd"; 
                };
              };
            }
          ];
        };

        cloudflared = {
          enable = false;
          tunnels = {
            # mqtt
            "a051417b-c023-4dfb-a862-05eae605fbcf" = {
              credentialsFile = "/home/pbr/.cloudflared/a051417b-c023-4dfb-a862-05eae605fbcf.json";
              ingress = {
                "mqtt.eltros.in" = "http://localhost:3001";        
              };
              default = "http_status:404";
            };
          };
        };
    };

    environment.systemPackages = with pkgs; [
      tree util-linux vim wget curl git gptfdisk htop pciutils home-manager
    ];

    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = "us";
  };
}