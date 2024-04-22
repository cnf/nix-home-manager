{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...} @ inputs:
    let
      inherit (self) outputs;
      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      # Values you should modify
      system = "x86_64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      home = {
        username = "cnf"; # $USER
        stateVersion = "23.11";     # See https://nixos.org/manual/nixpkgs/stable for most recent
        homeDirectory = "/${homeDirPrefix}/${home.username}";
      };
      #pkgs = import nixpkgs {
      #  inherit system;
      #  config = {
      #    allowUnfree = true;
      #  };
      #};
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};


    in {
      homeConfigurations = {
        "cnf@OptiNix" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {home = home;}
            ./optinix.nix 
          ];
        };
        "cnf@surface" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {home = home;}
            ./surface.nix 
          ];
        };
	"cnf@ySL" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {home = home;}
            ./ysl.nix
          ];
        };
	"funshoot@OptiNix" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./funshoot.nix
          ];
        };
      };
    };
}
