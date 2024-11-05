{...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$app-launcher" = "fuzzel";
      "$terminal-emulator" = "foot";
      "$web-browser" = "firefox";

      general = {
        border_size = 0;
        gaps_in = 0;
        gaps_out = 0;
        gaps_workspaces = 0;
        layout = "dwindle";
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
        kb_options = "caps:swapescape";
        numlock_by_default = false;
        repeat_rate = 60;
        repeat_delay = 160;
        force_no_accel = true;
        follow_mouse = "0";
        focus_on_close = "0";
        float_switch_override_focus = "0";
        off_window_axis_events = "3";
        emulate_discrete_scroll = "0";
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
        focus_on_activate = false;
        background_color = "rgb(282828)";
        new_window_takes_over_fullscreen = "1";
        exit_window_retains_fullscreen = true;
        initial_workspace_tracking = "0";
        middle_click_paste = false;
        render_unfocused_fps = 1;
      };

      binds = {
        workspace_center_on = "0";
        focus_preferred_method = "1";
        movefocus_cycles_fullscreen = true;
        disable_keybind_grabbing = true;
        window_direction_monitor_fallback = false;
      };

      xwayland = {
        enabled = true;
        use_nearest_neighbor = false;
        force_zero_scaling = false;
      };

      opengl = {
        nvidia_anti_flicker = false;
        force_introspection = "1";
      };

      render = {
        explicit_sync = "1";
        explicit_sync_kms = "1";
        direct_scanout = false;
      };

      cursor = {
        sync_gsettings_theme = true;
        no_hardware_cursors = "1";
        no_break_fs_vrr = true;
        min_refresh_rate = 60;
        hotspot_padding = 0;
        inactive_timeout = 0;
        no_warps = true;
        persistent_warps = false;
        warp_on_change_workspace = false;
        enable_hyprcursor = true;
        hide_on_key_press = false;
      };

      exec-once = "$terminal-emulator";
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,12"
      ];

      monitor = ",1920x1080@60.00,auto,1";

      "$workspace" = "SUPER";
      "$window" = "ALT";
      "$window-focus" = "$window+CTRL";
      "$window-resize" = "$window+SHIFT";
      "$window-move" = "$window+CTRL+SHIFT";

      bind = [
        "$workspace, Delete, exit"
        "$workspace, Left, workspace, r-1"
        "$workspace, Right, workspace, r+1"
        "$workspace, 1, movetoworkspace, r-1"
        "$workspace, 2, movetoworkspace, r+1"

        "$window, w, exec, $web-browser"
        "$window, e, exec, $terminal-emulator"
        "$window, a, exec, pkill $app-launcher || $app-launcher"
        "$window, q, killactive"
        "$window, f, fullscreen, 0"
        "$window, t, togglefloating"
        "$window, c, centerwindow"
        "$window, p, pin"
        "$window, 1, layoutmsg, swapsplit"
        "$window, 2, layoutmsg, togglesplit"
        "$window, 3, pseudo"

        "$window, Left, layoutmsg, preselect l"
        "$window, Right, layoutmsg, preselect r"
        "$window, Up, layoutmsg, preselect u"
        "$window, Down, layoutmsg, preselect d"

        "$window-move, Left, swapwindow, l"
        "$window-move, Right, swapwindow, r"
        "$window-move, Up, swapwindow, u"
        "$window-move, Down, swapwindow, d"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      binde = [
        "$window, Tab, cyclenext"

        "$window-resize, Left, resizeactive, -24 0"
        "$window-resize, Right, resizeactive, 24 0"
        "$window-resize, Up, resizeactive, 0 -24"
        "$window-resize, Down, resizeactive, 0  24"

        "$window-focus, Left, movefocus, l"
        "$window-focus, Right, movefocus, r"
        "$window-focus, Up, movefocus, u"
        "$window-focus, Down, movefocus, d"

        "$window-move, Left, moveactive, -24 0"
        "$window-move, Right, moveactive, 24 0"
        "$window-move, Up, moveactive, 0 -24"
        "$window-move, Down, moveactive, 0 24"
      ];

      dwindle = {
        force_split = "2";
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
        permanent_direction_override = true;
        use_active_for_splits = true;
      };
    };
  };
}
