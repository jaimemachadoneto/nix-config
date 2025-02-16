{ flake, hostSpec, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  # inherit hostSpec;
  imports = [
    ../../modules/common/config.nix
    ./jaime

  ];
  #  flake.config.hostSpec.hostName = "jaime-note";
  # home.username = flake.config.hostSpec.username;
  config.hostSpec.username = "jaime";
  config.hostSpec.hostName = "jaime-note";
  config.hostSpec.domain = inputs.nix-secrets.secrets.domain;
  config.hostSpec.userFullName = inputs.nix-secrets.secrets.userFullName;
  config.hostSpec.handle = inputs.nix-secrets.secrets.handle;
  config.hostSpec.email = inputs.nix-secrets.secrets.email;
  config.hostSpec.work.email = inputs.nix-secrets.secrets.email.work;

}
