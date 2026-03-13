{ config, lib, pkgs, ... }:

{
  # 🎨 HYPRLAND: Sovereign Modular Config (V3)
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # ── VARIABILE DE MEDIU (NVIDIA & Wayland) ─────────────────
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "WLR_NO_HARDWARE_CURSORS,1"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "NIXOS_OZONE_WL,1"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # ── GENERAL ───────────────────────────────────────────────
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(7aa2f7ee) rgba(bb9af7ee) 45deg"; # Tokyo Night Blue/Purple
        "col.inactive_border" = "rgba(1a1b26aa)";
        layout = "dwindle";
        resize_on_border = true;
      };

      # ── DECORATION ────────────────────────────────────────────
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
          vibrancy = 0.16;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      # ── ANIMATIONS (Omarchy Optimized) ────────────────────────
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "workspaces, 1, 6, default"
        ];
      };

      # ── KEYBINDINGS (Sovereign Set) ──────────────────────────
      "$mainMod" = "SUPER";
      
      # ── AUTOSTART ──────────────────────────────────────────────
      "exec-once" = [
        "waybar"
        "dunst"
        "nm-applet --indicator" # Iconița de rețea în bară
      ];

      # ── INPUT ──────────────────────────────────────────────────
      input = {
        kb_layout = "ro";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      bind = [
        # Essential
        "$mainMod, T, exec, ghostty"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, wofi --show drun"
        "$mainMod, F, fullscreen,"
        "$mainMod, ESCAPE, exec, hyprlock"

        # Focus
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to Workspaces
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
      ];

      # Multimedia Keys (Laptop Support)
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Misc
      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };
    };
  };
}
