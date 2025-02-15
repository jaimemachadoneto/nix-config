# IMPORTANT: This is used by NixOS and nix-darwin so options must exist in both!
{ inputs
, outputs
, config
, lib
, pkgs
, isDarwin
, ...
}:
let
  platform = if pkgs.stdenv.isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    # inputs.home-manager.${platformModules}.home-manager
    # inputs.sops-nix.${platformModules}.sops
    ./ssh.nix


  ];

}
