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
    kernelParams = [
      "video=DP-1:1920x1080@144"
      "video=HDMI-A-1:1920x1080@60"
      "amd_pstate=passive"
    ];
    kernelModules = ["kvm-amd" "amd_pstate" "amdgpu" "i2c-dev" "i2c-piix"];
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xone.enable = true;
    opentabletdriver.enable = true;
  };
  powerManagement.cpuFreqGovernor = "performance";

  networking = {
    hostName = "garden";
    useDHCP = lib.mkDefault true;
    dhcpcd.wait = "background"; # -7s to login
  };

  fileSystems = let
    default = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "discard" "ssd"];
  in {
    "/" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = default ++ ["subvol=root"];
    };
    "/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat";
      options = ["rw" "noatime"];
    };
    "/home" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = default ++ ["subvol=home"];
    };
    "/nix" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = default ++ ["subvol=nix"];
    };
    "/swap" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = ["rw" "noatime" "subvol=swap" "discard" "ssd"];
    };
    "/mnt/storage" = {
      device = "/dev/sda";
      fsType = "btrfs";
      options = default ++ ["subvol=storage"];
    };
    "mnt/games" = {
      device = "/dev/sda";
      fsType = "btrfs";
      options = default ++ ["subvol=games"];
    };
  };
  swapDevices = [{device = "/swap/swapfile";}];
}
