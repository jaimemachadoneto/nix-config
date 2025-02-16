{ flake, pkgs, lib, config, hostSpec, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  inherit hostSpec;
  imports = [
    # ../../../modules/common/config.nix
    self.homeModules.default

  ];

  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  # TODO: Avoid setting `nix.package` in two places. Does https://github.com/juspay/nixos-unified-template/issues/93 help here?
  nix.package = lib.mkDefault pkgs.nix;
  home.packages = [
    config.nix.package
  ];

  home.username = config.hostSpec.username;
  # home.username = flake.config.hostSpec.username;
  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${config.hostSpec.username}";
  home.stateVersion = "24.11";
}
