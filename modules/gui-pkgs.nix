{
  flake.modules.homeManager.gui-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pavucontrol
        postman
        nautilus
        quickshell
        netflix
        google-chrome
        thunderbird
        zed-editor
        pgadmin4-desktopmode
        zathura
        libreoffice
      ];
    };
}
