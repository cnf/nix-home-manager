{ pkgs, unstable, lib, config, inputs, ... }:
{
  #options = {
  #  my.slicers.enable = lib.mkEnableOption "Install engineering stuff";
  #};
  config = lib.mkIf config.my.engineering.enable {

    nixpkgs.overlays = [
      (final: prev: {
        boost = prev.boost183;
        prusa-slicer = prev.prusa-slicer.overrideAttrs (finalAttrs: prevAttrs: {
          version = "2.9.0";
          src = prev.fetchFromGitHub {
            owner = "prusa3d";
            repo = "PrusaSlicer";
            hash = "sha256-6BrmTNIiu6oI/CbKPKoFQIh1aHEVfJPIkxomQou0xKk=";
            rev = "version_${finalAttrs.version}";
          };
          patches = [
            (prev.fetchpatch {
              url = "https://raw.githubusercontent.com/gentoo/gentoo/master/media-gfx/prusaslicer/files/prusaslicer-2.9.0-arrange-static.patch";
              hash = "sha256-Ebq0Sd19+oMSJv6cpDoroH+QtTmxl+lh+mY3zqXsWu4=";
            })
            (prev.fetchpatch {
              url = "https://raw.githubusercontent.com/gentoo/gentoo/master/media-gfx/prusaslicer/files/prusaslicer-2.9.0-missing-includes.patch";
              hash = "sha256-B/lOLITNqgU7thMtfCMleai1pTS9LEVJXoyG2/u8e7g=";
            })
          ];
        });
    #    serial-studio = prev.serial-studio.overrideAttrs (finalAttr: prevAttr: {
    #      version = "3.0.6";
    #      src = prev.fetchFromGitHub {
    #        owner = "Serial-Studio";
    #        repo = "Serial-Studio";
    #        rev = "v3.0.6";
    #        hash = "sha256-q3RWy3HRs5NG0skFb7PSv8jK5pI5rtbccP8j38l8kjM=";
    #        fetchSubmodules = true;
    #      };
    #    });
      }
      )
    ];

    home.packages = with pkgs; [
      prusa-slicer
    ];
  };
}
