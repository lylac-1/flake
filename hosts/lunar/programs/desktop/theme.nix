{
  pkgs,
  config,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.mojave-gtk-theme.override {
        buttonSizeVariants = ["small"];
        buttonVariants = ["standard"];
        colorVariants = ["dark"];
        opacityVariants = ["solid"];
        themeVariants = ["purple"];
      };
      name = "Mojave-Dark-solid-small-purple";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
