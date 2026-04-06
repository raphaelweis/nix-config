{
  flake.modules.nixos.dconf =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        gnome-themes-extra
      ];

      programs.dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
              };
            };
          }
        ];
      };
    };
}
