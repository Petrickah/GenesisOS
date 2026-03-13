{ pkgs, ... }:

{
  # 🌐 Essential Core Settings
  time.timeZone = "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";

  # 🛡️ Networking & SSH
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = true; # Set to false if using keys
  };

  # 👤 User Configuration
  users.users.tiberiu = {
    isNormalUser = true;
    description = "Arch Arhitect";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.zsh;
  };

  # 📦 System Packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    zsh
  ];

  # 🐚 Zsh Enable
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
