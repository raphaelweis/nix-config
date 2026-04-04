{
  flake.modules.nixos.excalidraw =
    { pkgs, ... }:
    let
      excalidraw = pkgs.makeDesktopItem {
        name = "excalidraw";
        desktopName = "Excalidraw";
        exec = "chromium --app=https://excalidraw.com";
        icon = ../../assets/excalidraw.svg;
        categories = [ "Graphics" "Network" "WebBrowser" ];
      };
    in
    {
      environment.systemPackages = [ excalidraw ];
    };
}
