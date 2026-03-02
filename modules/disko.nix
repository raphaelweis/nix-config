{ inputs, ... }:
{
  flake.modules.nixos.disko-server = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices = {
      disk = {
        sda = {
          device = "/dev/sda";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                name = "boot";
                size = "1M";
                type = "EF02";
              };
              ESP = {
                type = "EF00";
                size = "512M";
                label = "boot";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                label = "nixos";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
              swap = {
                label = "swap";
                size = "1G";
                content = {
                  type = "swap";
                };
              };
            };
          };
        };
      };
    };
  };
}
