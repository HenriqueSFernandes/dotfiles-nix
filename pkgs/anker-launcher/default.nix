{
  lib,
  fetchurl,
  appimageTools,
  makeWrapper,
}:

let
  pname = "anker-launcher";
  version = "0.1.26";

  src = fetchurl {
    url = "https://github.com/zororver/anker-launcher/releases/download/v${version}/AnkerLauncher-${version}-x86_64.AppImage";
    hash = "sha256-P1saqKwi+3TXSoVrQdVN+POX3b03pTYez0t4c175HDw=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in

appimageTools.wrapType2 {
  inherit pname version src;

  nativeBuildInputs = [ makeWrapper ];

  extraPkgs = pkgs: with pkgs; [
    libgpg-error
  ];

  extraInstallCommands = ''
    install -Dm444 "${appimageContents}/Anker Launcher.desktop" \
      "$out/share/applications/anker-launcher.desktop"

    cp -r "${appimageContents}/usr/share/icons" "$out/share/"

    substituteInPlace "$out/share/applications/anker-launcher.desktop" \
      --replace-fail "Exec=anker-launcher" "Exec=${pname}"

    # The host's GIO modules are often built against a newer glib/gnutls than
    # the libraries bundled in the AppImage, causing undefined-symbol warnings
    # or TLS version mismatches. Clear them so the AppImage uses its own libs.
    mv "$out/bin/${pname}" "$out/bin/.${pname}-wrapped"
    makeWrapper "$out/bin/.${pname}-wrapped" "$out/bin/${pname}" \
      --unset GIO_EXTRA_MODULES \
      --unset GIO_MODULE_DIR
  '';

  meta = {
    description = "Anker Launcher — desktop client for AnkerGames";
    homepage = "https://ankergames.net/launcher";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "anker-launcher";
  };
}
