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
        chromium
        google-chrome
        thunderbird
        zed-editor
        zathura
        keepassxc
      ];
    };
}
