{inputs, outputs, pkgs, ...}: 
let
  homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
  username = "cnf";
in {
   #nixpkgs = {
    # You can add overlays here
   # overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
   #   outputs.overlays.additions
   #   outputs.overlays.modifications
   #   outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    #];
    # Configure your nixpkgs instance
    #config = {
    #  # Disable if you don't want unfree packages
    #  allowUnfree = true;
    #};
  #};
    home = {
      username = "${username}";
      homeDirectory = "${homeDirPrefix}/${username}";
      stateVersion = "24.11"; # To figure this out you can comment out the line and see what version it expected.
    };
    #programs.home-manager.enable = true;
}
