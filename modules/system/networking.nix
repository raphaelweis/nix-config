let
  # Wireguard public keys
  laptopPublicWgKey = "w7fwgm+hQGEJ0Xcy4lBmhhs0zrcaN4L4pnFyUE7TQWs=";
  serverPublicWgKey = "QcVzCNTHYMU5p8VEAx6Jqr1GbRFFmoSr0XaHTdce7QY=";

  # Wireguard config values
  serverIp = "195.154.105.239";
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
      networking.networkmanager.enable = true;

      sops.templates."wg0-nm-profile" = {
        # This is the standard path for NetworkManager connections
        path = "/etc/NetworkManager/system-connections/wg0.nmconnection";

        # make file read only by root
        mode = "0600";
        content = # ini
          ''
            [connection]
            # This will show up as the connection name in gnome VPN settings
            id=WireGuard

            # random UUID, can be anything, required for nmcli to load the file
            uuid=cc702871-f19a-45a7-9808-a808b139b43d

            type=wireguard
            interface-name=wg0

            [wireguard]
            private-key=${config.sops.placeholder.wireguard_private_key}

            [wireguard-peer.${serverPublicWgKey}]
            endpoint=${serverIp}:${toString wireguardPort}
            allowed-ips=10.100.0.0/24;

            # Uncomment if the server needs to initiate connections to the laptop.
            # Without this, the laptop's NAT mapping may expire when idle, making
            # it unreachable from the server side.
            # persistentKeepalive = 25;

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
    { config, ... }:
    {
      networking = {
        firewall = {
          enable = true;
          allowedUDPPorts = [ wireguardPort ];

          # Only open ssh port through wireguard network interface
          interfaces.wg0.allowedTCPPorts = [ 22 ];
        };
        wireguard.interfaces.wg0 = {
          ips = [ "10.100.0.1/24" ];
          listenPort = wireguardPort;
          privateKeyFile = config.sops.secrets.wireguard_private_key.path;
          peers = [
            {
              publicKey = laptopPublicWgKey;
              allowedIPs = [ "10.100.0.2/32" ];
            }
          ];
        };
      };
    };
}
