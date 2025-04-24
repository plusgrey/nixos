{
  description = "My NixOS configuration with Flakes and Home Manager";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        (self + "/system/configuration.nix")
        home-manager.nixosModules.home-manager

        {
          nixpkgs.overlays = [
            (final: prev: {
              stable = pkgs-stable;
            })
          ];
        }

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jh = import (self + "/home/user.nix");
        }
      ];
    };

    # 方便 nix build 默认 build 系统配置
    defaultPackage.x86_64-linux =
      self.nixosConfigurations.nixos-jh.config.system.build.toplevel;
  };
}
