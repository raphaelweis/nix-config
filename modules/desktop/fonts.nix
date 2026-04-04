{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        dejavu_fonts
        inter
        noto-fonts
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
        (pkgs.stdenvNoCC.mkDerivation {
          pname = "custom-fonts";
          version = "1.0";
          src = ../../assets/fonts;
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp *.ttf $out/share/fonts/truetype/ 2>/dev/null || true
          '';
        })
      ];
      fonts = {
        enableDefaultPackages = true;
        fontconfig = {
          defaultFonts = {
            serif = [ "DejaVu Serif" ];
            sansSerif = [ "DejaVu Sans" ];
            monospace = [ "JetBrainsMonoNL Nerd Font" ];
          };
        };
      };
    };
}
