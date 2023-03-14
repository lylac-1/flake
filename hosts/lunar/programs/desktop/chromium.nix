{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.chromium = {
    enable = true;
    #package = pkgs.chromium.override {ungoogled = true;}; # currently doesnt build :spiral_eyes:
    extensions = [
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsor block
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "dmghijelimhndkbmpgbldicpogfkceaj";} # extra dark
      {id = "fihnjjcciajhdojfnbdddfaoknhalnja";} # i dont care about
      {id = "jghecgabfgfdldnmbfkhmffcabddioke";} # volume master
    ];
  };
}
