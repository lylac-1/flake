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
      "initcall_blacklist=acpi_cpufreq_init"
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
    # nixos specific
    "/" = {
      device = "/dev/disk/by-uuid/d79da673-e349-41fb-93fd-c84964a1730a";
      fsType = "btrfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BEA0-2D3C";
      fsType = "vfat";
    };
    # main storage disks
    "/mnt/storage" = {
      device = "/dev/disk/by-uuid/b5b70a59-deca-4b7f-8589-757baa0812a3";
      fsType = "btrfs";
    };
    "/mnt/games" = {
      device = "/dev/disk/by-uuid/5636a88d-6a73-41d2-a47f-f096624c525f";
      fsType = "btrfs";
    };
    # other systems.
    "/mnt/gentoo" = {
      device = "/dev/disk/by-uuid/724570fa-3229-406f-857d-4275e63f1116";
      fsType = "btrfs";
    };
    # bizare mounting issues, doesnt matter, dont care.
    #"/mnt/windows" = {
    #  device = "/dev/disk/by-uuid/8898B8A398B89164";
    #  fsType = "ntfs3";
    #};
  };
}
