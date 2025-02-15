{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
self: super: {
  copy-md-as-html = self.callPackage "${packages}/copy-md-as-html.nix" { };
  myfindin = self.callPackage "${packages}/myfindin" { };
  binocular-cli = self.callPackage "${packages}/binocular-cli" { };
  omnix = inputs.omnix.packages.${self.system}.default;
  zsh-term-title = self.callPackage "${packages}/zsh-term-title" { };
  zhooks = self.callPackage "${packages}/zhooks" { };
  fex = self.callPackage "${packages}/fex" { };
}
