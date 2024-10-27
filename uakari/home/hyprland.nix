{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Generic programs
      "$app-launcher" = "fuzzel";
      "$terminal-emulator" = "kitty";
      "$web-browser" = "firefox";

      general = {
        border_size = 0;
        gaps_in = 0;
        gaps_out = 0;
        gaps_workspaces = 0;
        layout = "master";
        no_focus_fallback = true;
        resize_on_border = false;
        allow_tearing = true;
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        drop_shadow = false;
        dim_inactive = true;
        dim_strength = 0.3;
        dim_special = 0.3;
        dim_around = 0.3;
        blur.enabled = false;
      };

      animations = {
        enabled = true;
        first_launch_animation = true;
      };

      bezier = ["custom, 0, 0.7, 0.7, 1"];

      animation = ["global, 1, 3, custom"];

      input = {
        kb_layout = "latam";
        numlock_by_default = false;
        repeat_rate = 60;
        repeat_delay = 160;
        force_no_accel = true;
        follow_mouse = "0";
        float_switch_override_focus = "0";
      };

      misc = {
        disable_hyprland_logo = false;
        disable_splash_rendering = true;
        font_family = "TeXGyreAdventor";
        force_default_wallpaper = "2";
        vfr = true;
        vrr = "0";
        layers_hog_keyboard_focus = false;
        enable_swallow = false;
        focus_on_activate = true;
        background_color = "rgb(282828)";
        new_window_takes_over_fullscreen = "1";
        initial_workspace_tracking = "0";
        middle_click_paste = false;
      };

      binds = {
        workspace_center_on = "1";
        focus_preferred_method = "1";
        movefocus_cycles_fullscreen = true;
        disable_keybind_grabbing = true;
        window_direction_monitor_fallback = false;
      };

      xwayland = {
        use_nearest_neighbor = false;
        force_zero_scaling = false;
      };

      opengl = {
        nvidia_anti_flicker = true;
        force_introspection = "1";
      };

      cursor = {
        no_hardware_cursors = true;
        no_break_fs_vrr = true;
        min_refresh_rate = 60;
        hotspot_padding = 0;
        inactive_timeout = 3;
        no_warps = true;
        persistent_warps = true;
        warp_on_change_workspace = true;
        enable_hyprcursor = true;
        hide_on_key_press = false;
      };

      # Keywords
      exec-once = "$terminal-emulator";
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,12"
      ];

      # Monitors
      monitor = ",1920x1080@60.00,auto,1";

      # Bind modes
      "$workspace" = "SHIFT";
      "$workspace-move" = "$workspace+CTRL";
      "$window" = "ALT";
      "$window-move" = "$window+CTRL";
      "$window-resize" = "$window+SHIFT";

      # Spam keybinds
      binde = [
        "$window, Left, movefocus, l"
        "$window, Right, movefocus, r"
        "$window, Up, movefocus, u"
        "$window, Down, movefocus, d"

        "$window-move, Left, moveactive, -15 0"
        "$window-move, Right, moveactive, 15 0"
        "$window-move, Up, moveactive, 0 -15"
        "$window-move, Down, moveactive, 0 15"

        "$window-resize, Left, resizeactive, -10 0"
        "$window-resize, Right, resizeactive, 10 0"
        "$window-resize, Up, resizeactive, 0 -10"
        "$window-resize, Down, resizeactive, 0 10"
      ];

      # One-shot keybinds
      bind = [
        ", Super_L, exec, pkill $app-launcher || $app-launcher"
        ", Super_R, exec, pkill $app-launcher || $app-launcher"
        ", Menu, exec, pkill $app-launcher || $app-launcher"

        "$workspace, Left, workspace, r-1"
        "$workspace, Right, workspace, r+1"

        "$workspace-move, Left, movetoworkspace, m-1"
        "$workspace-move, Right, movetoworkspace, m+1"
        "$workspace-move, Delete, exit"

        "$window, w, exec, $web-browser"
        "$window, e, exec, $terminal-emulator"
        "$window, q, killactive"
        "$window, f, fullscreen, 0"
        "$window, 1, togglefloating"
        "$window, 2, centerwindow"
        "$window, 3, pin"

        "$window-move, Left, swapwindow, l"
        "$window-move, Right, swapwindow, r"
        "$window-move, Up, swapwindow, u"
        "$window-move, Down, swapwindow, d"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      master = {
        allow_small_split = false;
        mfact = 0.1;
        new_status = "slave";
        new_on_top = false;
        orientation = "bottom";
        inherit_fullscreen = true;
      };
    };
  };
}
