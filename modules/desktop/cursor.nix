{
  flake.modules.nixos.cursor =
    { pkgs, ... }:
    let
      cursorTheme = "macOS";
    in
    {
      environment.systemPackages = [ pkgs.apple-cursor ];
      environment.variables.XCURSOR_THEME = cursorTheme;
      environment.variables.XCURSOR_SIZE = "24";
    };
}
