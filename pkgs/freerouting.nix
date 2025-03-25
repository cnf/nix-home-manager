{stdenv
, lib
, fetchurl
, temurin-jre-bin
, makeWrapper
, ...}:
stdenv.mkDerivation rec {
  pname = "freerouting";
  version = "2.0.1";

  dontUnpack = true;
  src = fetchurl {
    url = "https://github.com/freerouting/freerouting/releases/download/v${version}/freerouting-${version}.jar";
    hash = "sha256-1/0PY/UubXSw+tZxX4fKnw/9cQnWaypYRjgAAnBZLs8=";
  };
  unpackPhase = "echo Not Unpacking";
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ temurin-jre-bin ];

  installPhase = ''
    mkdir -p $out/bin 
    echo $src
    ls $src
    install -Dm644 $src $out/share/freerouting-${version}/freerouting.jar
    makeWrapper ${temurin-jre-bin}/bin/java $out/bin/freerouting \
      --set JAVA_HOME ${temurin-jre-bin} \
      --set JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=gasp' \
      --add-flags "-jar $out/share/freerouting-${version}/freerouting.jar"
  '';
  meta = with lib; {
    description = "FreeRouting is an open-source, fully-automated PCB routing software designed for engineers, PCB designers, and hobbyists.";
    homepage = "https://www.freerouting.app/";
    changelog = "https://github.com/freerouting/freerouting/releases/tag/v${version}";
    license = licenses.gpl3;
    #maintainers = with maintainers; [ majiir ];
  };
}