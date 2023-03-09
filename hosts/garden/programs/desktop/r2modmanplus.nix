{
  nixpkgs,
  pkgs,
  ...
}: {
  home.packages = let
    r2modmanplus = with pkgs;
      appimageTools.wrapType2 rec {
        name = "r2modmanplus";
        version = "3.1.39";
        src = fetchurl {
          url = "https://github.com/ebkr/r2modmanPlus/releases/download/v${version}/r2modman-${version}.AppImage";
          sha256 = "7uu2vRNXBYcyr0foWQffJq0OPupHCFYp1yz0QdHbNCg=";
        };
        extraInstallCommands = let
          contents = appimageTools.extract {inherit name version src;};
        in ''
          mv -v $out/bin/r2modmanplus $out/bin/r2modman
          install -m 444 -D ${contents}/r2modman.desktop -t $out/share/applications
          sed -i 's/Exec=AppRun\ --no-sandbox\ %U/Exec=r2modman/g' $out/share/applications/r2modman.desktop
          for i in 16 32 48 64 96 128 256 512 1024; do
            install -D ${contents}/r2modman.png $out/share/icons/hicolor/''${i}x$i/apps/r2modman.png
          done
        '';
        meta = with lib; {
          description = "r2modmanplus thunderstore modmanager";
          homepage = "https://github.com/ebkr/r2modmanPlus";
          license = [licenses.mit];
          platforms = ["x86_64-linux"];
          mainProgram = "r2modmanplus";
        };
      };
  in
    with pkgs; [
      r2modmanplus
    ];
}
