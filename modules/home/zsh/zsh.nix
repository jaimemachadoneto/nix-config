{ pkgs, lib, config, ... }:

{
  home.sessionPath = lib.mkIf pkgs.stdenv.isDarwin [
    "/etc/profiles/per-user/$USER/bin"
    "/nix/var/nix/profiles/system/sw/bin"
    "/usr/local/bin"
  ];
  programs.zsh = {
    enable = true;

    zprof.enable = false;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };

    autosuggestion = {
      enable = true;
    };

    history = {
      size = 10000;
      save = 10000;
      share = true;
    };

    shellAliases =
      config.home.shellAliases // {
        # Our shell aliases are pretty simple
        "sd" = "cd ./\$(find-directory)";
        "sdu" = "traverse-upwards";
      };



    envExtra = lib.mkIf pkgs.stdenv.isDarwin ''
      # Because, adding it in .ssh/config is not enough.
      # cf. https://developer.1password.com/docs/ssh/get-started#step-4-configure-your-ssh-or-git-client
      export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
    '';

    initExtraFirst = ''

      update() {
        nixos-rebuild --flake .#$(echo $USER)@$(cat /etc/hostname)-x86_64 switch
      }
      # -- Use fd instead of fzf --

      export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

      # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
      # - The first argument to the function ($1) is the base path to start traversal
      # - See the source code (completion.{bash,zsh}) for the details.
      _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
      }

      # Use fd to generate the list for directory completion
      _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
      }

      show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

      export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
      export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
      export FZF_CTRL_R_OPTS="
        --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
        --color header:italic
        --header 'Press CTRL-Y to copy command into clipboard'"

      # Advanced customization of fzf options via _fzf_comprun function
      # - The first argument to the function is the name of the command.
      # - You should make sure to pass the rest of the arguments to fzf.
      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          export|unset) fzf --preview "eval 'echo $\{}'"         "$@" ;;
          ssh)          fzf --preview 'dig {}'                   "$@" ;;
          *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
      }

      loginKey()
      {
      read -rs 'pw?Password: ' </dev/tty
      echo "$pw"
      echo -n "$pw" | gnome-keyring-daemon --login
      unset pw
      }

      batf() {
          tail --retry -f "$1"| bat --paging=never -l log;
      }

      mylog() {
          tail -n +100 "$1" | lnav;
      }


      gpg-reload(){
            gpgconf --kill all
            #pkill scdaemon
            #pkill gpg-agent
            gpg-connect-agent /bye >/dev/null 2>&1
            gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
            gpgconf --reload gpg-agent

      }

      my_git_set_gpg() {
          git config --local credential.helper "netrc -f ~/.netrc.gpg -v"
      }

      my_git_enable_sign() {
          git config --local commit.gpgSign true
          git config --local tag.gpgSign true
          git config --local user.signingKey $1
      }

      my_git_decrypt() {
          gpg --output ~/.netrc --decrypt ~/.netrc.gpg
      }

      my_git_decrypt_clean() {
          rm ~/.netrc
      }

      traverse-upwards() {
        local dir=$(
          [ $# = 1 ] && [ -d "$1" ] && cd "$1"
          while true; do
            find "$PWD" -mindepth 1 -maxdepth 1 -type d -not -iwholename '*.git*'
            echo "$PWD"
            [ $PWD = / ] && break
            cd ..
          done | fzf --tiebreak=end --height 50% --reverse --preview 'tree -C {} | head -200'
        ) && cd "$dir"
      }

      find-directory() {
        find . -type d -not -iwholename '*.git*' | fzf --tiebreak=end --height 50% --reverse --preview 'tree -C {} | head -200'

      }

      1pass_signin() {
          eval $(op signin)
      }
      zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
      zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
      zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
      zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default
      zstyle ':completion:*' menu select=0 search

      _myfindin() {
        BUFFER="myfindin $(pwd)"
        zle accept-line
      }
      zle -N _myfindin

      zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"

      # Zsh reverse auto-completion
      zmodload zsh/complist
      bindkey '^[[Z' reverse-menu-complete
      # To get new binaries into PATH
      zstyle ':completion:*' rehash true

      #zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' file-sort date
      zstyle ':completion:*' menu yes=long select

      # Disable prompt disappearing on multi-lines
      export COMPLETION_WAITING_DOTS="false"

      bindkey -e
      bindkey  "^[[3~"  delete-char
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^F"     _myfindin

      export TERM=xterm-256color
      export COLORTERM="truecolor"
    '';
  };
}
