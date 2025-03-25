# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'

{ stdenv
, lib
, fetchFromGitHub
, bash
, makeWrapper
, zip
, p7zip
, gnutar
, gzip
, zstd
, zenity
}:
  stdenv.mkDerivation rec {
    pname = "nautilus_archiver_tools";
    version = "v0.1";
    src = fetchFromGitHub {
      owner = "dr-mcarrere";
      repo = "NautilusArchiverTools";
      rev = version;
      hash = "sha256-wp/bBIufgRfLmDwESQwbhLNPQyRDUB3qMkN1Jl7LHdw=";
    };
    buildInputs = [ bash zip p7zip gnutar gzip zstd zenity ];
    nativeBuildInputs = [ makeWrapper ];
    installPhase = ''
      mkdir -p $out/{Compress,Extract}
      cp -rp Compress/* $out/Compress/
      cp -rp Extract/* $out/Extract/
      patchShebangs $out/{Compress,Extract}
      chmod 755 $out/{Compress,Extract}/*

      wrapProgram $out/Compress/CompressHereTo7z --prefix PATH : ${lib.makeBinPath [ bash p7zip ]}
      wrapProgram $out/Compress/CompressHereToTarGz --prefix PATH : ${lib.makeBinPath [ bash gnutar gzip ]}
      wrapProgram $out/Compress/CompressHereToTarZst --prefix PATH : ${lib.makeBinPath [ bash gnutar zstd ]}
      wrapProgram $out/Compress/CompressHereToZip --prefix PATH : ${lib.makeBinPath [ bash zip ]}
      wrapProgram $out/Compress/CompressTo --prefix PATH : ${lib.makeBinPath [ zenity bash p7zip gnutar gzip zstd zip ]}

      wrapProgram $out/Extract/ExtractHere --prefix PATH : ${lib.makeBinPath [ zenity bash p7zip gnutar gzip zstd zip ]} 
      wrapProgram $out/Extract/ExtractTo --prefix PATH : ${lib.makeBinPath [ zenity bash p7zip gnutar gzip zstd zip ]}
    '';
  }
