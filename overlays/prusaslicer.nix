final: prev: let
  patch = final.fetchpatch {
    url = "https://github.com/prusa3d/PrusaSlicer/commit/cdc3db58f9002778a0ca74517865527f50ade4c3.patch";
    hash = "sha256-zgpGg1jtdnCBaWjR6oUcHo5sGuZx5oEzpux3dpRdMAM=";
  };
in {
  prusa-slicer-overlay = prev.prusa-slicer.overrideAttrs (prevAttrs: {
    patches = (prevAttrs.patches or []) ++ [patch];
  });
}
# https://github.com/NixOS/nixpkgs/issues/246261 [2025-01-19]
