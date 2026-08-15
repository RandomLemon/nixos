{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  lib,
  callPackage,
  unzip,
  ...
}@args:

stdenv.mkDerivation rec {
  pname = "easierconnect";
  version = "TestBuild14";
  src = fetchurl {
    url = "https://github.com/lyc8503/EasierConnect/releases/download/TestBuild14/EasierConnect-linux-amd64.zip";
    hash = "sha256-mmhsOGGgQTLOexT9JAVQ6I9g4rD11PwRhlGaqb0nNbo=";
  };

  nativeBuildInputs = [
    unzip
    makeWrapper
  ];

  unpackPhase = ''
    unzip ${src}
  '';

  installPhase = ''
    mkdir -p $out
    mkdir -p $out/lib
    mv EasierConnect $out/lib/EasierConnect

    mkdir -p $out/bin
    makeWrapper $out/lib/EasierConnect $out/bin/easierconnect \
      --argv0 "EasierConnect"

    # mkdir -p $out/share/applications $out/share/pixmaps
    # mv usr/share/applications/EasyConnect.desktop $out/share/applications/EasyConnect.desktop
    # mv usr/share/pixmaps/EasyConnect.png $out/share/pixmaps/EasyConnect.png
  '';

}
