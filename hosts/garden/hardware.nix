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
      #"initcall_blacklist=acpi_cpufreq_init"
    ];
    kernelModules = ["kvm-amd" "amd_pstate" "amdgpu"];
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;

    xone.enable = true;
    opentabletdriver.enable = true;
  };
  powerManagement.cpuFreqGovernor = "schedutil";

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  networking = {
    hostName = "garden";
    useDHCP = lib.mkDefault true;
    dhcpcd.wait = "background"; # otherwise +5-7s to login
  };

  fileSystems = {
    "/mnt/boot" = {
      device = "/dev/nvme1n1p1";
      fsType = "vfat"; # wonder if can make btrfs
    };
    "/" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "subvol=root" "discard" "ssd"];
    };
    "/home" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "subvol=home" "discard" "ssd"];
    };
    "/nix" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "subvol=nix" "discard" "ssd"];
    };
    "/swap" = {
      device = "/dev/nvme1n1p2";
      fsType = "btrfs";
      options = ["rw" "noatime" "subvol=swap" "discard" "ssd"];
    };
    "/mnt/storage" = {
      device = "/dev/sda";
      fsType = "btrfs";
      options = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "subvol=storage" "discard" "ssd"];
    };
    "mnt/games" = {
      device = "/dev/sda";
      fsType = "btrfs";
      options = ["rw" "compress=zstd:9" "thread_pool=16" "space_cache=v2" "noatime" "subvol=games" "discard" "ssd"];
    };
    swapDevices = [
      {
        device = "/swap/swapfile";
      }
    ];
  };
}
