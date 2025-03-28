{inputs, lib, outputs, pkgs, nixpkgs, ...}: 
let
  homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
  username = "cnf";
  system = pkgs.stdenv.hostPlatform.system;
  allowUnfree = map lib.getName [
    "discord"
    "spotify"
  ];
in {
    nixpkgs = {
      config = {
        allowUnfree = true;
        #allowUnfreePredicate = (_: true);
        allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) allowUnfree;
      };
    };
    _module.args.unstable = import inputs.nixpkgs-unstable {
       inherit system;
       config = {
         allowUnfree = true;
         allowUnfreePredicate = (_: true);
        };
        overlays = [
          (import ./pkgs)
            # (self: super: {my-freerouting = super.callPackage ./pkgs/freerouting.nix { };})
            # (self: super: {local = super.callPackage ./pkgs {};})
        ] ++ (import ./overlays);
    };

    home = {
      username = "${username}";
      homeDirectory = "${homeDirPrefix}/${username}";
      stateVersion = "24.11"; # To figure this out you can comment out the line and see what version it expected.
    };
    #programs.home-manager.enable = true;
}
