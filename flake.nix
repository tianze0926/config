{
  description = "NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
      "https://tianze0926.cachix.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-substituters = [
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "tianze0926.cachix.org-1:vA+L4R+TywN/M6haoQfJsk9UzMCgPIiu5ZuNTH+lnVI="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    myRepo.url = "github:tianze0926/nur-packages";
    hyprland.url = "github:hyprwm/Hyprland";
    # plasma-manager = {
    #   url = "github:pjones/plasma-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations =
    (let
      opt.user = "leo";
      opt.hostName = "${opt.user}-server";
      opt.system = "x86_64-linux";
    in {
      "${opt.hostName}" = nixpkgs.lib.nixosSystem {
        inherit (opt) system;
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
      opt.system = "x86_64-linux";
    in {
      "${opt.hostName}" = nixpkgs.lib.nixosSystem {
        inherit (opt) system;
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
