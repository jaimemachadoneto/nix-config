# default.nix
{ lib
, writeShellApplication
, fzf
, bat
}:

let
  package = writeShellApplication {
    name = "myfindin";
    runtimeInputs = [ fzf bat ];
    text = builtins.readFile ./myfindin;
  };
in
package // {
  meta = with lib; {
    description = "Simple file content search utility";
    licenses = licenses.mit;
    platforms = platforms.all;
  };
}
