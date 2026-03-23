{
  flake.nixosModules.ionixpbrlabpi5_disko = { lib, ... }: {
    disko.devices = {
      disk = {
        sdcard = {
          # WARNING: Change this to your actual SD card device path on your laptop (e.g., /dev/mmcblk0 or /dev/sdb)
          # You can find it by running `lsblk`
          device = lib.mkDefault "/dev/mmcblk0";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                name = "ESP";
                start = "1M";
                end = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}