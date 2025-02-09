{ pkgs, ... }:
{
  programs.bash = {
    # FIXME: doesn't work (macos)
    initExtra = ''
      complete -F _task -o bashdefault -o default t
    '';
  };

  home.shellAliases.t = "task";
  home.packages = with pkgs; [ go-task ];
}
