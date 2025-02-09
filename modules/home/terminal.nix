# Platform-independent terminal setup
{ flake, pkgs, ... }:

let
  inherit (flake) inputs;
in
{
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];
  home.packages = with pkgs; [
    # Unixy tools
    fd # Better find
    bc # Calculator
    bottom # System viewer (btm)
    eza # Better ls
    ripgrep # Better grep
    delta
    eza # Better ls
    ncdu # TUI disk usage
    htop # Better top
    nmap # Network scanner
    sd # sed alternative
    curl # Download files
    xh # HTTPie alternative
    television
    gnupg
    gnumake
    tree

    # Nix dev
    cachix
    nix-info
    nixpkgs-fmt
    gcc

    # On ubuntu, we need this less for `man home-configuration.nix`'s pager to
    # work.
    less

    #My Packages
    copy-md-as-html
    binocular-cli
    myfindin

  ];

  fonts.fontconfig.enable = true;

  home.shellAliases = {
    e = "nvim";
    g = "git";
    #TODOL Move some of the shell aliases to this central place
    # lg = "lazygit";
    # l = "ls";
    beep = "say 'beep'";
    "sctl" = "sudo systemctl";
    vim = "nvim";
    # cat = "ccat";
    # less = "cless";
    af = "alias | fzf";
    #ls
    # "l" = "ls -lha";
    "la" = "ls -A";
    "ll" = "ls -T";
    #cd
    ".." = "cd ..";
    "..." = "cd ../..";
    #use clipboard by default
    "xclip" = "xclip -selection c";
    #ssh with password auth
    "ssh-pw" = "ssh -o PreferredAuthentications=password";
    #gpg
    "gpg" = "gpg --expert";
    "gpg2" = "gpg2 --expert";
    #qrclip
    "qrclip" = "xclip -o | qr2";
    # avoid using nano, in favor of vim
    "sudo" = "sudo -E";
    "ls" = "eza --icons=always --long --git";
    "cd" = "z";
    "mytail" = "tail --retry -f";
    "myfzf" = "fzf --multi --bind shift-up:preview-page-up,shift-down:preview-page-down --preview='bat --decorations=always --color=always --theme=\"Dracula\" {}' --preview-window right:50%";
    "fvim" = "vim \`fzf --multi --bind shift-up:preview-page-up,shift-down:preview-page-down --preview='bat --decorations=always --color=always --theme=\"Dracula\" {}' --preview-window right:50%\`";
    # "lg" = "echo \"foo\" | gpg --sign -u jaime.machado@gmail.com > /dev/null; lazygit";
    "ffo" = "myfzf | head -1 | xargs nvim";
    "ffio" = "myfindin";
    "upgradeflakes" = "nix-channel --update && nix flake update && nix-env -u";
    "nixclean" = "nix-collect-garbage -d";
  };

  programs = {
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
    nix-index-database.comma.enable = true;
    # lsd = {
    #   enable = true;
    #   enableAliases = true;
    # };
    bat.enable = true;
    autojump.enable = false;
    zoxide.enable = true;
    fzf.enable = true;
    jq.enable = true;
    btop.enable = true;
    # Tmate terminal sharing.
    tmate = {
      enable = true;
      #host = ""; #In case you wish to use a server other than tmate.io
    };
  };
}
