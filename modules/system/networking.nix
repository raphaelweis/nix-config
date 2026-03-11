let
  serverPublicIp = "195.154.105.239";
  wireguardPort = 51820;
  wireguardPeers = {
    nanorion = {
      ip = "10.100.0.1/24";
      publicKey = "QcVzCNTHYMU5p8VEAx6Jqr1GbRFFmoSr0XaHTdce7QY=";
    };
    interstellar = {
      ip = "10.100.0.2/32";
      publicKey = "w7fwgm+hQGEJ0Xcy4lBmhhs0zrcaN4L4pnFyUE7TQWs=";
    };
    ami = {
      ip = "10.100.0.3/32";
      publicKey = "8b019h4NXPc6oBFTun+pp6oq4Xv9paDsYkCMIUjTaRE=";
    };
    john = {
      ip = "10.100.0.4/32";
      publicKey = "qUSPkyMc5o8E/hzzjagVgRM88k2uWSFjGTuxE7ozIlY=";
    };
  };
in
{
  flake.modules.nixos.networking-shared =
    { lib, ... }:
    let
      mkPeerOptions =
        name:
        { ip, publicKey }:
        {
          ip = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
            default = ip;
            description = "The WireGuard IP address for the ${name} peer";
          };
          publicKey = lib.mkOption {
            type = lib.types.str;
            readOnly = true;
            default = publicKey;
            description = "The WireGuard public key for the ${name} peer";
          };
        };
    in
    {
      # custom shared options that are used to configure the wireguard network.
      # nixos hosts must explicitely set the peerIp option using the values in the
      # peers attribute, so that the networking module can use the correct IP when
      # writing the network manager connection file.
      options.networking.custom.wireguard = {
        peers = lib.mapAttrs mkPeerOptions wireguardPeers;
        peerIp = lib.mkOption {
          type = lib.types.str;
          description = "The Wireguard IP address for this machine (peer). Must be set by each host";
        };
      };
    };

  flake.modules.nixos.networking =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [ wireguard-tools ];

      networking.networkmanager.enable = true;

      sops.templates."wg0-nm-profile" = {
        path = "/etc/NetworkManager/system-connections/wg0.nmconnection";
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

            [wireguard-peer.${config.networking.custom.wireguard.peers.nanorion.publicKey}]
            endpoint=${serverPublicIp}:${toString wireguardPort}
            allowed-ips=10.100.0.0/24;

            [ipv4]
            address1=${config.networking.custom.wireguard.peerIp}
            method=manual

            [ipv6]
            addr-gen-mode=default
            method=disabled
          '';
      };

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
      config = {
        networking = {
          firewall = {
            enable = true;
            allowedUDPPorts = [ wireguardPort ];
            interfaces.wg0.allowedTCPPorts = [
              22
              80
              443
            ];
          };
          wireguard.interfaces.wg0 = {
            ips = [ config.networking.custom.wireguard.peers.nanorion.ip ];
            listenPort = wireguardPort;
            privateKeyFile = config.sops.secrets.wireguard_private_key.path;
            peers =
              let
                peers = config.networking.custom.wireguard.peers;
                clientPeers = removeAttrs peers [ "nanorion" ];
              in
              lib.mapAttrsToList (_name: peer: {
                publicKey = peer.publicKey;
                allowedIPs = [ peer.ip ];
              }) clientPeers;
          };
        };
      };
    };
}
