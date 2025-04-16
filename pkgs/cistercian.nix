{
  lib,
  pkgs,
  stdenvNoCC,
  #patchShebangs,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation {
  pname = "cistercian";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "ctrlcctrlv";
    repo = "FRBCistercian";
    rev = "a350317aa96f041a0cf775544f583fa24d30963e";
    hash = "sha256-Y1hAV+ekB9DgEbost2TN1UiS6XjV73OfRHOJxOGAeJw=";
  };
  
  buildInputs = [
    pkgs.fontforge
    pkgs.imagemagick
    pkgs.woff2
    pkgs.ghostscript_headless
  ];

  #preInstallPhase = ''
  #  patchShebangs 
  #'';

  installPhase = ''
    runHook preInstall
  
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/fonts/woff2
    ls
    cp dist/*.otf $out/share/fonts/opentype/
    cp dist/*.woff2 $out/share/fonts/woff2/
  
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/ctrlcctrlv/FRBCistercian";
    description = "FRB Cistercian is an OpenType font for the medeival number system known as the Cistercian numerals";
    license = licenses.ofl;
    platforms = platforms.all;
    #maintainers = with maintainers; [ demize ];
  };
}

