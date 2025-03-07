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
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpolkitagent = {
      url = "github:hyprwm/hyprpolkitagent";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprswitch = {
      url = "github:h3rmt/hyprswitch/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #};
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprsysteminfo = {
      url = "github:hyprwm/hyprsysteminfo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-binds = {
      url = "github:gvolpe/hypr-binds";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dmenu-usbguard.url = "github:Armoken/dmenu-usbguard";
    nix-inspect.url = "github:bluskript/nix-inspect";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = { nixpkgs, home-manager, ...} @ inputs:
    let
      #inherit (self) outputs;
      system = "x86_64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      pkgs = nixpkgs.legacyPackages.${system};
      vscode-extensions = inputs.nix-vscode-extensions.extensions.${system};
    in {
      nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"]; # for nixd
      # packages.x86_64-linux.freerouting = pkgs.callPackage ./pkgs/freerouting.nix {};
      # call it with  inputs.self.packages.x86_64-linux.freerouting in my files
      homeConfigurations = {
        "cnf@hydra" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs system vscode-extensions;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./hydra.nix 
          ];
        };
        "cnf@OptiNix" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs system;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./optinix.nix 
          ];
        };
        "cnf@surface" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs system;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./surface.nix 
          ];
        };
        "cnf@dionysus" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs system;};
          inherit pkgs;
          modules = [
            ./home.nix
            ./programs
            ./dionysus.nix 
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
