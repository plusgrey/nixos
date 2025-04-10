{
  description = "My NixOS configuration with Flakes and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.nixos-jh = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        (self + "/system/configuration.nix")
        home-manager.nixosModules.home-manager

        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = pkgs-unstable;
            })
          ];
        }

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jh = import (self + "/home/jh.nix");
        }
      ];
    };

    # 方便 nix build 默认 build 系统配置
    defaultPackage.x86_64-linux =
      self.nixosConfigurations.nixos-jh.config.system.build.toplevel;
  };
}
