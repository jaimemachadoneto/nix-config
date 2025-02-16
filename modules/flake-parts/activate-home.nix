{
  perSystem = { self', pkgs, lib, ... }: {
    # Enables 'nix run' to activate home-manager config.
    apps.default = {
      inherit (self'.packages.activate) meta;
      program = pkgs.writeShellApplication {
        name = "activate-home";
        text = ''
          # Try to get hostname from multiple sources
          if [ -f /etc/hostname ]; then
            HOST=$(cat /etc/hostname)
          elif [ -n "$HOSTNAME" ]; then
            HOST=$HOSTNAME
          else
            HOST=$(hostname)
          fi

          set -x
          ${lib.getExe self'.packages.activate} "$HOST"@
        '';
      };
    };
  };
}
