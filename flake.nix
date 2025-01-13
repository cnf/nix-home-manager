{
  description = "Home Manager configuration";

  inputs = {
    cachix.url = "github:cachix/cachix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
    };
    hyprsysteminfo = {
      url = "github:hyprwm/hyprsysteminfo";
    };
    hypr-binds = {
      url = "github:gvolpe/hypr-binds";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...} @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";  # x86_64-linux, aarch64-multiplatform, etc.

      # Supported systems for your flake packages, shell, etc.
      # supportedSystems = [
      #   #"aarch64-linux"
      #   #"i686-linux"
      #   "x86_64-linux"
      #   #"aarch64-darwin"
      #   #"x86_64-darwin"
      # ];
      pkgs = import nixpkgs {
       inherit system;
       config = {
        #  allowUnfree = true;
        #  allowUnfreePredicate = (_: true);
       };
      };
      # pkgs = nixpkgs.legacyPackages.${system};
      unstable = import nixpkgs-unstable {
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
      # unstable = nixpkgs-unstable.legacyPackages.${system};
      #unstable.config.allowUnfree = true;

      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      # forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in {
      homeConfigurations = {
        "cnf@hydra" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs outputs unstable;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./hydra.nix 
          ];
        };
        "cnf@OptiNix" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs outputs;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./optinix.nix 
          ];
        };
        "cnf@surface" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./surface.nix 
          ];
        };
        "cnf@ySL" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./ysl.nix
          ];
        };
        "funshoot@OptiNix" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
	        extraSpecialArgs = {inherit unstable;};
          modules = [
            ./funshoot.nix
          ];
        };
      };
      #homeManagerModules.default = ./programs;
    };
}
