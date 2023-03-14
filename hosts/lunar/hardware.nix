{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    };
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  powerManagement.cpuFreqGovernor = "powerbalance";

  networking = {
    hostName = "lunar";
    useDHCP = lib.mkDefault true;
  };

  fileSystems = let
    default = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "discard" "ssd"];
  in {
    "/" = {
      device = "/dev/sda6";
      fsType = "btrfs";
      options = default ++ ["subvol=root"];
    };
    "/boot" = {
      device = "/dev/sda5";
      fsType = "vfat";
      options = ["rw" "noatime"];
    };
    "/home" = {
      device = "/dev/sda6";
      fsType = "btrfs";
      options = default ++ ["subvol=home"];
    };
    "/nix" = {
      device = "/dev/sda6";
      fsType = "btrfs";
      options = default ++ ["subvol=nix"];
    };
    "/swap" = {
      device = "/dev/sda6";
      fsType = "btrfs";
      options = ["rw" "noatime" "subvol=swap" "discard" "ssd"];
    };
  };
  swapDevices = [{device = "/swap/file";}];
}
