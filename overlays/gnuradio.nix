final: prev: 
{
  gnuradioPackages = prev.gnuradioPackages.overrideScope (new: old: {
    gr-air-modes = old.callPackage ../pkgs/gr-air-modes.nix {};
    gr-ieee802-11 = old.callPackage ../pkgs/gr-ieee802-11.nix {};
    gr-adsb = old.callPackage ../pkgs/gr-adsb.nix {};
    gr-gsm = old.callPackage ../pkgs/gr-gsm.nix {};
  });
  #my-gnuradio = prev.gnuradio.overrideAttrs(old: new: {
  #  pkgs = old.pkgs // {
  #    gr-air-modes = prev.callPackage ../pkgs/gr-air-modes.nix {};
  #  };
  #});
}
