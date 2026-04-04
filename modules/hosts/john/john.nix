{
  inputs,
  self,
  ...
}:
let
  hostname = "john";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" hostname;

  flake.modules.nixos.${hostname} =
    { config, ... }:
    {
      networking = {
        hostName = hostname;
        custom.wireguard.peerIp = config.networking.custom.wireguard.peers.${hostname}.ip;
      };

      sops.defaultSopsFile = ../../../secrets/${hostname}.yaml;

      boot.kernelParams = [
        "amd_pstate=active"
        "amd_pstate.shared_mem=1"
        "nohibernate"

        # https://www.phoronix.com/news/Linux-Splitlock-Hurts-Gaming
        "split_lock_detect=off"
        "acpi_sleep=nonvs"
      ];

      hardware = {
        cpu.amd.updateMicrocode = true;
      };

      # On my motherboard (Gigabyte Technology Co., Ltd. X570S AORUS ELITE AX),
      # A sensor wrongly triggers after suspend, immediately causing the computer to
      # shut down. This service runs:
      # echo disabled > /sys/class/thermal/thermal_zone1/mode
      # at boot to disable this sensor and prevent this problem, since it's likely a
      # hardware issue on the motherboard.
      # Note that this may cause a failure to detect an actual overheating problem,
      # since we are disabling the sensor.
      # https://forum.manjaro.org/t/acpi-thermal-limit-triggers-thermal-shutdown-on-sleep/154502/16
      # Note: I tried using systemd.tmpfiles.rules instead but it didn't work because
      # something was overriding the value after the rule was being set, so instead I
      # use a systemd service file with the line: after = [ "multi-user.target" ] to
      # make sure it runs late enough.
      systemd.services.gigabyte-sensor-fix = {
        description = "Gigabyte X570 Platform Sensor Fix";
        wantedBy = [ "multi-user.target" ];
        after = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = ''/bin/sh -c "echo disabled > /sys/class/thermal/thermal_zone1/mode"'';
        };
      };

      imports = with self.modules.nixos; [
        desktop
        ./_hardware-configuration.nix
      ];

      system.stateVersion = "25.05";
    };
}
