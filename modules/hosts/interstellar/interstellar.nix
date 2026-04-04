{
  inputs,
  self,
  ...
}:
let
  hostname = "interstellar";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" hostname;

  flake.modules.nixos.${hostname} =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      networking = {
        hostName = hostname;
        custom.wireguard.peerIp = config.networking.custom.wireguard.peers.${hostname}.ip;
      };

      sops.defaultSopsFile = ../../../secrets/${hostname}.yaml;

      boot = {
        # Fix suspend (lenovo yoga slim 7 issue)
        # https://gitlab.freedesktop.org/drm/amd/-/issues/2812
        initrd.prepend = lib.mkOrder 0 [
          "${pkgs.fetchurl {
            url = "https://gitlab.freedesktop.org/drm/amd/uploads/9fe228c7aa403b78c61fb1e29b3b35e3/slim7-ssdt";
            sha256 = "sha256-Ef4QTxdjt33OJEPLAPEChvvSIXx3Wd/10RGvLfG5JUs=";
            name = "slim7-ssdt";
          }}"
        ];
        kernelParams = [
          "rtc_cmos.use_acpi_alarm=1"
          "amd_pstate=active"
          "amd_pstate.shared_mem=1"
          "nohibernate"

          # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
          "split_lock_detect=off"
          "acpi_sleep=nonvs"
        ];
      };

      services = {
        # tlp config on laptop to increase battery life.
        tlp = {
          enable = false;
          settings = {
            DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
          };
        };
        power-profiles-daemon.enable = false; # required for tlp to work.
      };

      hardware = {
        cpu.amd.updateMicrocode = true;

        # Fix for the speakers not working.
        # https://github.com/darinpp/yoga-slim-7
        firmware =
          let
            tas = pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/darinpp/yoga-slim-7/main/lib/firmware/TAS2XXX38BB.bin";
              sha256 = "sha256-qyZxBlnWEnrgbh0crgFf//pKZMTtCqh+CkA+pUNU/+E=";
              name = "TAS2XXX38BB.bin";
            };
            tia = pkgs.fetchurl {
              url = "https://raw.githubusercontent.com/darinpp/yoga-slim-7/main/lib/firmware/TIAS2781RCA4.bin";
              sha256 = "sha256-Zj7mwS8DsBinZ8BYvcySc753Aq/xid7vAeQOH/oir6Q=";
              name = "TIAS2781RCA4.bin";
            };
          in
          [
            (pkgs.runCommand "subwoofers" { } ''
              mkdir -p $out/lib/firmware/
              cp ${tas} $out/lib/firmware/TAS2XXX38BB.bin
              cp ${tia} $out/lib/firmware/TIAS2781RCA4.bin
            '')
            pkgs.wireless-regdb
          ];
      };

      imports = with self.modules.nixos; [
        desktop
        ./_hardware-configuration.nix
      ];

      system.stateVersion = "25.05";
    };
}
