{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  fileSystems."/var/lib/jellyfin" = {
    fsType = "none";
    device = "/mnt/storage/volumes/jellyfin";
    options = ["bind"];
  };
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };
}
