{ config, pkgs, inputs, ... }:

{
  # 👤 User: tiberiu
  home.username = "tiberiu";
  home.homeDirectory = "/home/tiberiu";

  # 📦 User Packages
  home.packages = with pkgs; [
    # Terminal & UI
    ghostty
    wofi
    waybar
    dunst
    libnotify
    
    # Browsers & Apps
    firefox
    dolphin # File manager
    
    # Dev tools
    vscode
    nil # Nix LSP
    nixd # Nix LSP
  ];

  # 🚀 Imports: Modulele de utilizator
  imports = [
    ../../modules/desktop/default.nix # Hyprland config (Home Manager)
  ];

  # 🐚 Fish Shell (Configurație User)
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };

  # ── STATE VERSION ───────────────────────────────────────────
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
