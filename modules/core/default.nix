{ pkgs, ... }:

{
  # 🌐 Essential Core Settings
  time.timeZone = "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";

  # 🛡️ Networking & SSH
  networking.networkmanager.enable = true;
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
  };

  # 🖥️ Display Manager (SDDM)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # ⌨️ Keyboard & Localization
  console.keyMap = "ro";
  services.xserver.xkb = {
    layout = "ro";
    variant = "";
  };

  # 🚀 Hyprland System-Level (Necesar pentru SDDM session entry)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # 🖱️ NVIDIA Cursor Fix (System level)
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # ⌨️ Input & Hardware
  services.libinput.enable = true; # Trackpad support
  hardware.enableRedistributableFirmware = true; # WiFi/Bluetooth Firmware

  # 👤 User Configuration
  users.users.tiberiu = {
    isNormalUser = true;
    description = "Arhitectul";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # 📦 System Packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    fish
  ];

  # 🐚 Shells
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # ❄️ Nix Settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # 🔗 Path Linking (Necesar pentru Home Manager + Portals)
  environment.pathsToLink = [ 
    "/share/applications" 
    "/share/xdg-desktop-portal"
  ];

  # ── BOOTLOADER (Standard UEFI) ──────────────────────────────
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # 🔓 Allow unfree packages (NVIDIA, etc.)
  nixpkgs.config.allowUnfree = true;
}
