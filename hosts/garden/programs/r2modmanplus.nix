with import <nixpkgs> {};
  appimageTools.wrapType2 rec {
    name = "r2modmanplus";
    src = fetchurl {
      url = "https://github.com/ebkr/r2modmanPlus/releases/download/v3.1.39/r2modman-3.1.39.AppImage";
      sha256 = "7uu2vRNXBYcyr0foWQffJq0OPupHCFYp1yz0QdHbNCg=";
    };
  }
