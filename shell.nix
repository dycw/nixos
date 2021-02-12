with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "dotfiles";
  buildInputs = [ python39 pipenv ];
}
