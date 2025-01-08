{
  description = "Home Manager configuration";

  inputs = {
    cachix.url = "github:cachix/cachix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #waybar.url = "github:Alexays/Waybar";
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
      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      system = "x86_64-linux";  # x86_64-linux, aarch64-multiplatform, etc.
      home = {
        username = "cnf"; # $USER
        stateVersion = "24.11";     # See https://nixos.org/manual/nixpkgs/stable for most recent
        homeDirectory = "${homeDirPrefix}/${home.username}";
      };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      #pkgs = nixpkgs.legacyPackages.${system};
      unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
      #unstable = nixpkgs-unstable.legacyPackages.${system};
      #unstable.config.allowUnfree = true;


    in {
      homeConfigurations = {
        "cnf@hydra" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs;inherit unstable;};
          inherit pkgs;
          modules = [
            {home = home;}
            ./programs
            ./hydra.nix 
          ];
        };
        "cnf@OptiNix" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {inherit inputs;inherit unstable;};
          inherit pkgs;
          modules = [
            {home = home;}
            ./programs
            ./optinix.nix 
          ];
        };
        "cnf@surface" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {home = home;}
            ./programs
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
	  extraSpecialArgs = {
	    inherit unstable;
	  };
          modules = [
            ./funshoot.nix
          ];
        };
      };
      homeManagerModules.default = ./programs;
    };
}
