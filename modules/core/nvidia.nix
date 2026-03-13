{ config, pkgs, myLib, ... }:

{
  # ⚙️ KERNEL: Selecție automată via myLib
  boot.kernelPackages = myLib.myKernelPackages pkgs;

  # 🛡️ NVIDIA: Drivere și suport grafic
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modsetting este necesar pentru Wayland/Hyprland
    modesetting.enable = true;
    
    # Power management (Fine-tuning pentru laptop)
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Proprietar vs Open (Proprietar recomandat pentru legacy/laptop stabilitate)
    open = false;

    # Settings GUI
    nvidiaSettings = true;

    # Pachetul de drivere (Sincronizat cu versiunea de kernel aleasă)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # 🔓 Pachete non-free obligatorii pentru NVIDIA
  nixpkgs.config.allowUnfree = true;
}
