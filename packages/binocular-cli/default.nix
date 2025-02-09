{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "binocular-cli";
  version = "main";

  src = fetchFromGitHub {
    owner = "jpcrs";
    repo = pname;
    rev = version;
    hash = "sha256-e0LGj86FgWgermTXF7V19Ddi7Axlu4sMaB+Z2kf+bJc=";
  };

  cargoHash = "sha256-rdc+B/U43NGrOG+cHm0w37gLG23Kl2v2ttnDbqPuJ5g=";

  meta = {
    description = "Binocular-cli tool";
    homepage = "https://github.com/jpcrs/binocular-cli";
    license = lib.licenses.unlicense;
    maintainers = [ ];
  };
}
