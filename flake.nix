{
  description = "NixOS configuration flake";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = ["https://cache.nixos.org/" "https://wezterm.cachix.org"];
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:wez/wezterm?dir=nix";

    # Nixvim
    nixvim.url = "github:3fxcf9/nixvim";

    # Custom latex class
    custom-latex-course-class = {
      url = "git+ssh://git@github.com/3fxcf9/LaTeX-course-class.git?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window manager
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret management
    sops-nix.url = "github:Mic92/sops-nix";

    # Private secret repo
    nix-secrets = {
      url = "git+ssh://git@github.com/3fxcf9/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    # Nixos hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    unstable = import nixpkgs-unstable {inherit system;};
  in {
    formatter.x86_64-linux =
      nixpkgs.legacyPackages.x86_64-linux.nixfmt-classic;

    nixosConfigurations = {
      alpha = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          # inherit unstable;
        };

        modules = [
          inputs.nixos-hardware.nixosModules.dell-inspiron-7405
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
                inherit unstable;
              };
              useGlobalPkgs = true;
            };
          }
          ./hosts/alpha
        ];
      };

      beta = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs.inputs = inputs;
        modules = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = {inherit inputs;};
              useGlobalPkgs = true;
            };
          }
          ./hosts/beta
        ];
      };
    };
  };
}
