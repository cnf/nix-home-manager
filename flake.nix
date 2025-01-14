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
    dmenu-usbguard.url = "github:Armoken/dmenu-usbguard";
    nix-inspect.url = "github:bluskript/nix-inspect";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ...} @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.x86_64-linux.freerouting = pkgs.callPackage ./pkgs/freerouting.nix {};
      # call it with  inputs.self.packages.x86_64-linux.freerouting in my files
      homeConfigurations = {
        "cnf@hydra" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs system;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./hydra.nix 
          ];
        };
        "cnf@OptiNix" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs;};
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
	        extraSpecialArgs = {inherit inputs;};
          modules = [
            ./funshoot.nix
          ];
        };
      };
      #homeManagerModules.default = ./programs;
    };
}
