{
  programs.zsh.zplug = {
    enable = true;

    plugins = [
      # {
      #   name = "spaceship-prompt/spaceship-prompt";
      #   tags = ["use:spaceship.zsh" "from:github" "as:theme"];
      # }
      { name = "zsh-users/zsh-autosuggestions"; }
      { name = "zsh-users/zsh-syntax-highlighting"; }
      { name = "zsh-users/zsh-completions"; }
      {
        name = "plugins/history";
        tags = [ "from:oh-my-zsh" ];
      }
      {
        name = "plugins/colored-man-pages";
        tags = [ "from:oh-my-zsh" ];
      }
      {
        name = "plugins/command-not-found";
        tags = [ "from:oh-my-zsh" ];
      }
      {
        name = "plugins/alias-finder";
        tags = [ "from:oh-my-zsh" ];
      }
      {
        name = "plugins/fancy-ctrl-z";
        tags = [ "from:oh-my-zsh" ];
      }
      {
        name = "dracula/zsh";
        tags = [ "use:dracula.zsh-theme" "from:github" "as:theme" ];
      }
      {
        name = "wfxr/forgit";
        tags = [ "from:github" ];
      }
      {
        name = "joshskidmore/zsh-fzf-history-search";
        tags = [ "use:zsh-fzf-history-search.plugin.zsh" "from:github" "as:plugin" ];
      }
      {
        name = "nix-community/nix-zsh-completions";
        tags = [ "use:nix-zsh-completions" "from:github" "as:plugin" ];
      }
      # {
      #   name = "plugins/git";
      #   tags = [ "from:oh-my-zsh" "if:\"(( $+commands[git] ))\"" ];
      # }
      {
        name = "plugins/golang";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[go] ))\"" ];
      }
      # {
      #   name = "plugins/svn";
      #   tags = ["from:oh-my-zsh" "if:\"(( $+commands[svn] ))\""];
      # }
      {
        name = "plugins/node";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[node] ))\"" ];
      }
      {
        name = "plugins/npm";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[npm] ))\"" ];
      }
      # {
      #   name = "plugins/bundler";
      #   tags = ["from:oh-my-zsh" "if:\"(( $+commands[bundler] ))\""];
      # }
      # {
      #   name = "plugins/gem";
      #   tags = ["from:oh-my-zsh" "if:\"(( $+commands[gem] ))\""];
      # }
      # {
      #   name = "plugins/rbenv";
      #   tags = ["from:oh-my-zsh" "if:\"(( $+commands[rbenv] ))\""];
      # }
      # {
      #   name = "plugins/rvm";
      #   tags = ["from:oh-my-zsh" "if:\"(( $+commands[rvm] ))\""];
      # }
      {
        name = "plugins/pip";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[pip] ))\"" ];
      }
      {
        name = "plugins/sudo";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[sudo] ))\"" ];
      }
      {
        name = "plugins/gpg-agent";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[gpg-agent] ))\"" ];
      }
      {
        name = "plugins/systemd";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[systemctl] ))\"" ];
      }
      {
        name = "plugins/docker";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[docker] ))\"" ];
      }
      {
        name = "plugins/docker-compose";
        tags = [ "from:oh-my-zsh" "if:\"(( $+commands[docker-compose] ))\"" ];
      }
    ];
  };
}
