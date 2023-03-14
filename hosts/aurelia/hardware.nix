{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "sd_mod"];
    };
    kernelModules = ["kvm-intel"];
  };
  networking = {
    hostName = "aurelia";
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 8080 25565];
    };
    useDHCP = lib.mkDefault true;
  };
  fileSystems = {
    # should get around to refactoring the storage setup here, note: buy new disks lol
    "/" = {
      device = "/dev/disk/by-uuid/7fe6290c-ca79-4810-b91e-0bbf756a7902";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/1F55-CD98";
      fsType = "vfat";
    };
    "/mnt/storage" = {
      device = "/dev/disk/by-uuid/5e0e375a-dcc4-4718-bee2-532f18b47824";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-uuid/d0bbdbd6-2fe7-4e0b-9389-da70d0a3a58f";}];
}
