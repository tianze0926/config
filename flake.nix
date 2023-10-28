{
  description = "NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    inherit (self) outputs;
  in {
    overlays = import ./overlays { inherit inputs; };
    nixosConfigurations =
    (let
      opt.user = "leo";
      opt.hostName = "${opt.user}-server";
    in {
      "${opt.hostName}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs opt; };
        modules = [
          ./hosts/${opt.hostName}/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    }) //
    (let
      opt.user = "leo";
      opt.hostName = "${opt.user}-PC";
    in {
      "${opt.hostName}" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs opt; };
        modules = [
          ./hosts/${opt.hostName}/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    })
    ;
  };
}
