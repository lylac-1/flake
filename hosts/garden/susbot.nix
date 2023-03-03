with import <nixpkgs> {};
rustPlatform.buildRustPackage rec {
  name = "susbot";
  src = fetchFromGitea {
    domain = "tea.lylac.dev";
    owner = "Nixinova";
    repo = ;
    hash =;
  };
  cargoHash = "";
  meta = with lib; {
    description = "susbot...";
    homepage = "";
  }
}