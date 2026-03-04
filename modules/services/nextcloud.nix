{
  flake.modules.nixos.nextcloud-server =
    { config, pkgs, ... }:
    {
      sops.secrets = {
        nextcloud_admin_pwd = {
          owner = "nextcloud";
          group = "nextcloud";
          mode = "0400";
        };
      };

      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud33;
        hostName = config.networkingConstants.serverWgIp;
        database.createLocally = true;
        config = {
          dbtype = "pgsql";
          adminpassFile = config.sops.secrets.nextcloud_admin_pwd.path;
        };
        settings = {
          maintenance_window_start = 1;
        };
        phpOptions = {
          "opcache.interned_strings_buffer" = "16";
        };
      };
    };

  flake.modules.homeManager.nextcloud =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ nextcloud-client ];
    };

}
