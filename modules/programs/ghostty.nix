{
  flake.modules.homeManager.ghostty =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = if pkgs.stdenv.isLinux then pkgs.ghostty else null;
        settings = {
          background-opacity = 1;
          confirm-close-surface = true;
          theme = "Gruvbox Dark Hard";
          font-family = "monospace";
          font-size = 10;
          window-padding-x = 5;
          window-padding-y = 5;
          shell-integration-features = "no-cursor";
          cursor-style = "block";
          cursor-style-blink = false;
          cursor-invert-fg-bg = true;
          adjust-cursor-thickness = 1;
          gtk-titlebar-hide-when-maximized = true;
          gtk-single-instance = true;
          keybind = [
            "ctrl+enter=unbind"
            "performable:alt+c=copy_to_clipboard"
            "performable:alt+v=paste_from_clipboard"
          ];
        };
      };

    };
}
