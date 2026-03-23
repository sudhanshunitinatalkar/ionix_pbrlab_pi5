{ config, lib, pkgs, modulesPath, ... }:
{
  flake.nixosModules.ionixpbrlabpi5_hardware = {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    # Disko handles the fileSystems, so you can remove the hardcoded UUID ones.
    swapDevices = [ ];
    
    nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  };
}