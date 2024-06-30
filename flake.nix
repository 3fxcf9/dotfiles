{
  description = "NixOS configuration flake";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = ["https://cache.nixos.org/"];
    extra-substituters = ["https://nix-community.cachix.org" "https://hyprland.cachix.org"];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window manager
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    home-manager,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    configLib = import ./lib {inherit lib;};
    specialArgs = {inherit inputs outputs configLib nixpkgs;};
  in {
    formatter.x86_64-linux =
      nixpkgs.legacyPackages.x86_64-linux.nixfmt-classic;
    nixosConfigurations = {
      alpha = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = specialArgs;}
          ./hosts/alpha
        ];
      };
      beta = lib.nixosSystem {
        inherit specialArgs;
        modules = [
          home-manager.nixosModules.home-manager
          {home-manager.extraSpecialArgs = specialArgs;}
          ./hosts/beta
        ];
      };
    };
    # nixosConfigurations.stdmain = inputs.nixpkgs.lib.nixosSystem {
    #  system = "x86_64-linux";
    #  modules = [
    #    disko.nixosModules.disko
    #    ./system/disk-config.nix
    #    ./system/configuration.nix
    #    hyprland.nixosModules.default
    #    { programs.hyprland.enable = true; }
    #    home-manager.nixosModules.home-manager
    #    {
    #      home-manager.backupFileExtension = "backup";
    #      home-manager.useGlobalPkgs = true;
    #      home-manager.useUserPackages = true;
    #      home-manager.users.moi = import ./home;
    #    }
    #  ];
    #};
  };
}
