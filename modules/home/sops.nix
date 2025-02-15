{ flake, pkgs, user, config, ... }:

let
  inherit (flake) inputs;
  sopsFolder = (builtins.toString inputs.nix-secrets) + "/sops";
  homeDirectory = config.home.homeDirectory;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  home.packages = with pkgs; [
    sops
  ];

  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt"; # must have no password!
    # It's also possible to use a ssh key, but only when it has no password:
    #age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];
    # FIXME(starter-repo):
    #defaultSopsFile = "${secretsFilePath}";
    defaultSopsFile = "${sopsFolder}/${config.hostSpec.hostName}.yaml";
    validateSopsFiles = false;

    defaultSopsFormat = "yaml";

  };
}
