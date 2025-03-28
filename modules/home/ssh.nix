{ pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;

    addKeysToAgent = "yes";

    # Note: More defined in juspay.nix
    matchBlocks = {
      "*" = {
        setEnv = {
          # https://ghostty.org/docs/help/terminfo#configure-ssh-to-fall-back-to-a-known-terminfo-entry
          TERM = "xterm-256color";
        };
      };
      pureintent = {
        forwardAgent = true;
      };
    };
  };

  programs.openssh = {
    enable = true;
    forwardAgent = true;
  };

  services.ssh-agent = lib.mkIf pkgs.stdenv.isLinux { enable = true; };
}
