{
  lib,
  appimageTools,
  fetchurl,
  widevine-cdm,
}:
appimageTools.wrapType2 rec {
  version = "0.11.3.2";
  pname = "helium";

  src = fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    hash = "sha256-5gdyKg12ZV2hpf0RL+eoJnawuW/J8NobiG+zEA0IOHA=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };

  extraPkgs = pkgs: [ widevine-cdm ];

  # Set up widevine for helium using widevine-cdm
  # see: https://github.com/imputnet/helium/issues/116#issuecomment-3668370766
  profile = ''
    HELIUM_CONFIG_DIR="''${XDG_CONFIG_HOME:-''${HOME}/.config}/net.imput.helium/WidevineCdm"
    mkdir -p "$HELIUM_CONFIG_DIR"
    echo -n '{"Path":"${widevine-cdm}/share/google/chrome/WidevineCdm"}' > "$HELIUM_CONFIG_DIR/latest-component-updated-widevine-cdm"
  '';

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/${pname}.desktop -t $out/share/applications/
    install -Dm444 ${appimageContents}/${pname}.png -t $out/share/icons/hicolor/256x256/apps/
  '';

  meta = with lib; {
    description = "The Chromium-based web browser made for people, with love.";
    homepage = "https://helium.computer";
    downloadPage = "https://helium.computer";
    license = licenses.gpl3;
    sourceProvidence = with sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
}
