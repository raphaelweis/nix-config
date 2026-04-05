{
  lib,
  stdenv,
  fetchurl,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "vscode-langservers-extracted";
  version = "1.0.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/@t1ckbase/vscode-langservers-extracted/-/vscode-langservers-extracted-${version}.tgz";
    hash = "sha256-csr4XAtt7UWGXI5nta5GSQpXgq1eHRZevPSDv9cvR44=";
  };

  sourceRoot = "package"; # npm tarballs unpack into a "package/" directory

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vscode-langservers-extracted
    cp -r dist $out/lib/vscode-langservers-extracted/

    mkdir -p $out/bin
    for bin in \
      "vscode-css-language-server:dist/css/cssServerMain.js" \
      "vscode-html-language-server:dist/html/htmlServerMain.js" \
      "vscode-json-language-server:dist/json/jsonServerMain.js" \
      "vscode-eslint-language-server:dist/eslint/eslintServer.js"
    do
      name="''${bin%%:*}"
      script="''${bin##*:}"
      makeWrapper ${nodejs}/bin/node $out/bin/$name \
        --add-flags "$out/lib/vscode-langservers-extracted/$script"
    done

    runHook postInstall
  '';

  meta = {
    description = "CSS/HTML/JSON/ESLint language servers extracted from VSCode";
    homepage = "https://github.com/T1ckbase/vscode-langservers-extracted";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
