{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core/nvidia.nix # Importăm modulul core de NVIDIA
  ];

  # 🌐 Rețea
  networking.hostName = "asgard-laptop";

  # ⚙️ Versiunea State (Baseline)
  system.stateVersion = "24.11";
}
