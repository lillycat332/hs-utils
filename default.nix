{ mkDerivation
, base
, lib
, optparse-applicative
, text
, pkgs
, ...
}:
mkDerivation {
  pname = "hs-utils";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base
    optparse-applicative
    text
  ];
  buildInputs = with pkgs; [
    clang
    zlib
    cabal-install
    ghc
  ];
  license = lib.licenses.bsd3;
}
