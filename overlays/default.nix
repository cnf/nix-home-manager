# # This file defines overlays
# {...}: {
#   # This one brings our custom packages from the 'pkgs' directory
#   # additions = final: _prev: import ../pkgs final.pkgs;

#   # This one contains whatever you want to overlay
#   # You can change versions, add patches, set compilation flags, anything really.
#   # https://nixos.wiki/wiki/Overlays
#   modifications = final: prev: {
#     # example = prev.example.overrideAttrs (oldAttrs: rec {
#     # ...
#     # });
#   };

#   # When applied, the unstable nixpkgs set (declared in the flake inputs) will
#   # be accessible through 'pkgs.unstable'
#   # unstable-packages = final: _prev: {
#   #   unstable = import inputs.nixpkgs-unstable {
#   #     system = final.system;
#   #     config.allowUnfree = true;
#   #   };
#   # };
# }

# args:
# execute and import all overlay files in the current
# directory with the given args
builtins.map
  # execute and import the overlay file
  (f: (import (./. + "/${f}")))
  # find all overlay files in the current directory
  (builtins.filter
    (f: f != "default.nix")
    (builtins.attrNames (builtins.readDir ./.)))