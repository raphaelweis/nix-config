let
  # Wireguard public keys
  laptopPublicWgKey = "w7fwgm+hQGEJ0Xcy4lBmhhs0zrcaN4L4pnFyUE7TQWs=";
  serverPublicWgKey = "QcVzCNTHYMU5p8VEAx6Jqr1GbRFFmoSr0XaHTdce7QY=";
  phonePublicWgKey = "8b019h4NXPc6oBFTun+pp6oq4Xv9paDsYkCMIUjTaRE=";

  # Wireguard config values
  serverPublicIp = "195.154.105.239";
  serverWgIp = "10.100.0.1";
  wireguardPort = 51820;
in
{
  flake.modules.nixos.networking =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [ wireguard-tools ];

      # I use networkmanager for desktops because it's the default on most desktop
      # environments. NetworkManager is kind of not ideal to configure declaratively
      # with NixOS. We could use networkmanager.profiles option to configure the
      # wireguard connection, but it would write our private key to the nix store,
      # which is insecure. To circumvent this, we write a regular network manager
      # connection file using a sops template, and we then load this connection
      # using a oneshot systemd service.
      # Persistent keepalive is not needed since the server has a static public IP
      # and we always initiate connections from the laptop.
      networking.networkmanager.enable = true;

      sops.templates."wg0-nm-profile" = {
        path = "/etc/NetworkManager/system-connections/wg0.nmconnection";

        # make file readable only by root
        mode = "0600";
        content = # ini
          ''
            [connection]
            id=WireGuard
            uuid=cc702871-f19a-45a7-9808-a808b139b43d
            type=wireguard
            interface-name=wg0

            [wireguard]
            private-key=${config.sops.placeholder.wireguard_private_key}

            [wireguard-peer.${serverPublicWgKey}]
            endpoint=${serverPublicIp}:${toString wireguardPort}
            allowed-ips=10.100.0.0/24;

            [ipv4]
            address1=10.100.0.2/24
            method=manual

            [ipv6]
            addr-gen-mode=default
            method=disabled
          '';
      };

      # oneshot systemd service that refires if the connection file contents changes
      systemd.services.nm-reload-wg0 = {
        description = "Reload NetworkManager wg0 wireguard profile";
        wantedBy = [ "multi-user.target" ];
        after = [ "NetworkManager.service" ];
        restartTriggers = [ config.sops.templates."wg0-nm-profile".content ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${lib.getExe' pkgs.networkmanager "nmcli"} connection load /etc/NetworkManager/system-connections/wg0.nmconnection";
          RemainAfterExit = true;
        };
      };
    };

  flake.modules.nixos.networking-server =
    { config, lib, ... }:
    {
      # Define constants here, they may be accessed by other modules using the
      # config attribute
      options.networkingConstants = {
        serverWgIp = lib.mkOption {
          type = lib.types.str;
          description = "The WireGuard IP address of the server";
        };
      };
      config = {
        networkingConstants = {
          inherit serverWgIp;
        };
        networking = {
          firewall = {
            enable = true;
            allowedUDPPorts = [ wireguardPort ];

            # Only open ports through wireguard network interface
            interfaces.wg0.allowedTCPPorts = [
              22
              80
              443
            ];
          };
          wireguard.interfaces.wg0 = {
            ips = [ "${serverWgIp}/24" ];
            listenPort = wireguardPort;
            privateKeyFile = config.sops.secrets.wireguard_private_key.path;
            peers = [
              {
                publicKey = laptopPublicWgKey;
                allowedIPs = [ "10.100.0.2/32" ];
              }
              {
                publicKey = phonePublicWgKey;
                allowedIPs = [ "10.100.0.3/32" ];
              }
            ];
          };
        };
      };
    };
}
