{ config, pkgs, ... }:

{
  # 🎨 Desktop Environment Placeholder
  # This module will eventually house Hyprland/Waybar configs.

  # 🛡️ NVIDIA Environment Variables (for Home Manager injection)
  # These are applied via users/tiberiu/default.nix
  home-manager.users.tiberiu = {
    home.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
