{ flake, config, pkgs, lib, ... }:

{
  home.username = flake.config.hostSpec.username;
  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/jaime";
  home.stateVersion = "24.11";

}
