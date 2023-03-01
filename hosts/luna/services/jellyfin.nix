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
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel.override { enableHybridCodec = true;}
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };
  ###############
  # add fs bind #
  ###############
}