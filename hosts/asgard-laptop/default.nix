{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
  ];

  # 🛠️ KERNEL ARTIFICIU (ZFS/NVIDIA Compatibility)
  boot.kernelPackages = pkgs.lib.mkDefault pkgs.linuxPackages_latest;

  # 🛡️ NVIDIA Drivers Support
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Proprietary drivers often more stable on older/specific mobile GPUs
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Hostname
  networking.hostName = "asgard-laptop";

  # Nix Settings (Flakes)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11"; # Baseline version
}
