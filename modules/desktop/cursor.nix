{
  flake.modules.homeManager.cursor =
    { pkgs, ... }:
    let
      cursorTheme = "macOS";
    in
    {
      home.pointerCursor = {
        enable = true;
        package = pkgs.apple-cursor;
        name = cursorTheme;
        size = 24;
      };
      dconf = {
        enable = true;
        settings."org/gnome/desktop/interface" = {
          cursor-theme = cursorTheme;
        };
      };
    };
}
