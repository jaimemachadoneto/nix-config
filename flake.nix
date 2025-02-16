{
  description = "A home-manager template providing useful tools & settings for Nix-based development";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";

    # Software inputs
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";
    nixos-vscode-server.flake = false;
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";

    # Secrets management. See ./docs/secretsmgmt.md
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    # Devshell
    omnix.url = "github:juspay/omnix";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.flake = false;

    nix-secrets = {
      url = "git+ssh://git@github.com/jaimemachado/nix-secrets?shallow=1&ref=main";
      flake = false;
    };

  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs = inputs@{ self, home-manager, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      imports = (with builtins;
        map
          (fn: ./modules/flake-parts/${fn})
          (attrNames (readDir ./modules/flake-parts)));

      perSystem = { lib, system, ... }: {
        # Make our overlay available to the devShell
        # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument.""
        # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = lib.attrValues self.overlays;
          config.allowUnfree = true;
          hostname = builtins.getEnv "HOSTNAME";
        };
      };

      # https://omnix.page/om/ci.html
      flake.om.ci.default.ROOT = {
        dir = ".";
        steps.flake-check.enable = false; # Doesn't make sense to check nixos config on darwin!
        steps.custom = { };
      };
    };
}
