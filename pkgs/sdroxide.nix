{ pkgs, rustPlatform, ... }:
let
  # 1. Fetch the model separately
 deepFilterModel = pkgs.fetchurl {
    url = "https://github.com/Rikorose/DeepFilterNet/raw/refs/tags/v0.5.6/models/DeepFilterNet3_onnx.tar.gz"; # Replace with the correct release URL
    hash = "sha256-yU2R9wkRAByUbg+rtKqa3DcEX0WgO1YAjLDIJEy2NhY="; 
  };
in
rustPlatform.buildRustPackage rec{
    pname = "sdroxide";
    version = "v1.6.0";

    src = pkgs.fetchFromGitHub {
      owner = "dividebysandwich";
      repo = "sdroxide";
      rev = "${version}";
      sha256 = "";
    };

    cargoHash = "sha256-DoVDGbnKF65sRrhoeHrcD8c46EigQa2Vx6YJ7ESmKic=";
    nativeBuildInputs = [
      pkgs.rustPlatform.bindgenHook
      pkgs.pkg-config
    ];
    
    buildInputs = [
      pkgs.alsa-lib
    ];
    
    preBuild = ''
      echo "Spliced model into /build/sdroxide-${version}-vendor/source-git-0/models/"
      mkdir /build/sdroxide-${version}-vendor/source-git-0/models
      cp ${deepFilterModel} /build/sdroxide-${version}-vendor/source-git-0/models/DeepFilterNet3_onnx.tar.gz
    '';

}
