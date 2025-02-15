{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports =
    if flake.config.hostSpec.isMinimal then [
      self.homeModules.all
    ] else if flake.config.hostSpec.isServer then [
      self.homeModules.all
    ] else if flake.config.hostSpec.isProduction then [
      self.homeModules.all
    ] else if flake.config.hostSpec.isWork then [
      self.homeModules.all
    ] else [
      self.homeModules.all
    ];

  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  # TODO: Avoid setting `nix.package` in two places. Does https://github.com/juspay/nixos-unified-template/issues/93 help here?
  nix.package = lib.mkDefault pkgs.nix;
  home.packages = [
    config.nix.package
  ];

}
