{ config, pkgs, ... }:

{
  # Home Manager Baseline for tiberiu
  home.username = "tiberiu";
  home.homeDirectory = "/home/tiberiu";

  # 📦 Home Packages
  home.packages = with pkgs; [
    fastfetch
    htop
  ];

  # 🛠️ Program Configurations
  programs.git = {
    enable = true;
    # settings replaces extraConfig in newer home-manager
    settings = {
      user = {
        name = "Tiberiu";
        email = "tiberiu@example.com";
      };
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
