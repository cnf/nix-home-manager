{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #hyprland.url = "github:hyprwm/Hyprland";
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.hyprland.follows = "hyprland";
    #};
    #hyprgrass = {
    #  url = "github:horriblename/hyprgrass";
    #  inputs.hyprland.follows = "hyprland"; # IMPORTANT
    #};
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
