{ inputs, ... }:
{
  flake.modules.nixos.gui-pkgs =
    { pkgs, ... }:
    {
      environment.systemPackages =
        with pkgs;
        [
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
          modrinth-app

        ]
        ++ [
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
    };
}
