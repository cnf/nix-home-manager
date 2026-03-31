# cSpell: words kicad kikit tokyonight
{
  unstable,
  lib,
  config,
  ...
}:
let
  # Create custom packages3d library with no compression
  custom-packages3d = unstable.stdenv.mkDerivation {
    pname = "kicad-packages3d-no-compression";
    version = "stable";

    src = unstable.fetchFromGitLab {
      group = "kicad";
      owner = "libraries";
      repo = "kicad-packages3d";
      rev = "c25dce5aadce68076ac035edb0c792608f5f597c"; # from versions.nix stable
      sha256 = "1y7yhynrr87q80gcb8qlkyrdccz1sllsxqymrnghhxbfk4wbwwn8"; # from versions.nix stable
    };

    nativeBuildInputs = [ unstable.cmake ];

    # No postInstall step - this skips compression entirely
    postInstall = ''
      echo "Skipping STEP file compression - keeping original .step files"
    '';

    meta = {
      license = lib.licenses.cc-by-sa-40;
      platforms = lib.platforms.all;
    };
  };

  # Create custom footprints library that doesn't change .step to .stpZ references
  custom-footprints = unstable.stdenv.mkDerivation {
    pname = "kicad-footprints-no-compression-refs";
    version = "stable";

    src = unstable.fetchFromGitLab {
      group = "kicad";
      owner = "libraries";
      repo = "kicad-footprints";
      rev = "873e3e9dbad8371d664e57261efa516d42328161"; # from versions.nix stable
      sha256 = "179y7xmz7mwsfsv4dcw2dx689xfzqk8y38d21s69yiaalyxflhh1"; # from versions.nix stable
    };

    nativeBuildInputs = [ unstable.cmake ];

    # Skip the step that changes .step references to .stpZ
    postInstall = ''
      echo "Keeping .step references in footprints since files are uncompressed"
    '';

    meta = {
      license = lib.licenses.cc-by-sa-40;
      platforms = lib.platforms.all;
    };
  };

  # Override KiCad to use our custom packages3d and footprints
  kicad-fixed =
    (unstable.kicad.override {
      addons = with unstable.kicadAddons; [
        kikit
        # kikit-libraryo
      ];
    }).overrideAttrs
      (
        finalAttrs: prevAttrs: {
          # Change the pname to force Nix to recognize this as a different package
          pname = "kicad-uncompressed";

          # Override both passthru and the wrapper's makeWrapperArgs to use our custom libraries
          passthru = prevAttrs.passthru // {
            libraries = prevAttrs.passthru.libraries // {
              packages3d = custom-packages3d;
              footprints = custom-footprints;
            };
          };

          # Override the makeWrapperArgs to point to our custom libraries
          # Put our args FIRST so they take precedence over the original ones
          makeWrapperArgs = [
            "--set-default" "KICAD9_3DMODEL_DIR" "${custom-packages3d}/share/kicad/3dmodels"
            "--set-default" "KICAD9_FOOTPRINT_DIR" "${custom-footprints}/share/kicad/footprints"
          ] ++ (prevAttrs.makeWrapperArgs or [ ]);
        }
      );

in
{
  options = {
    my.engineering.kicad.enable = lib.mkEnableOption "Install KiCAD" // {
      default = true;
    };
  };
  config = lib.mkIf (config.my.engineering.enable && config.my.engineering.kicad.enable) {
    home.packages = [
      kicad-fixed
    ];
  };
  # add https://raw.githubusercontent.com/kevontheweb/tokyo-night-kicad-theme/refs/heads/main/colors/tokyonight.json
}
