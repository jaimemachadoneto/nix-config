{ config, flake, ... }: {
  # sops.secrets.atuin_secret = {
  #   path = "/home/${flake.config.me.username}/.config/atuin/atuin_secret";
  # };


  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      auto_sync = true;
      sync_address = "https://atuin.machadoneto.win";
      sync_frequency = "5m";
      update_check = false;
      filter_mode = "global";
      dialect = "us";
      search_mode = "fuzzy";
      store_failed = true;
      secrets_filter = true;
      keymap_mode = "emacs";
      prefers_reduced_motion = true;
      style = "compact";
      inline_height = 10;
      # key_path = config.sops.secrets."keys/atuin".path; #"/run/secrets/atuin_secret";
      common_subcommands = [
        "apt"
        "cargo"
        "composer"
        "dnf"
        "docker"
        "git"
        "go"
        "ip"
        "kubectl"
        "nix"
        "nmcli"
        "npm"
        "pecl"
        "pnpm"
        "podman"
        "port"
        "systemctl"
        "tmux"
        "yarn"
        "nix"
      ];
    };
  };
  sops.secrets."keys/atuin" = {
    path = "${config.home.homeDirectory}/.local/share/atuin/key";
  };

}
