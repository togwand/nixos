{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.hyprland.enable {
    home-manager.users.${user}.wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        "$app-launcher" = "tofi-drun";
        "$terminal-emulator" = "foot";
        "$web-browser" = "firefox";

        general = {
          border_size = 0;
          no_border_on_floating = true;
          gaps_in = "8,8,8,8";
          gaps_out = "16,16,16,16";
          gaps_workspaces = 0;
          layout = "dwindle";
          no_focus_fallback = true;
          resize_on_border = true;
          extend_border_grab_area = 32;
          hover_icon_on_border = true;
          allow_tearing = true;
          resize_corner = 0;
          snap = {
            enabled = false;
          };
        };

        decoration = {
          rounding = 0;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;
          dim_inactive = false;
          dim_strength = 0.0;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            ignore_opacity = false;
            new_optimizations = true;
            xray = true;
            noise = 0.0;
            contrast = 2.0;
            brightness = 1.0;
            vibrancy = 0.5;
            vibrancy_darkness = 0.15;
            special = false;
            popups = false;
          };
          shadow = {
            enabled = true;
            range = 24;
            render_power = 3;
            sharp = false;
            ignore_window = true;
            color = "rgba(2D48B9dd)";
            color_inactive = "rgba(333333aa)";
            scale = 1.0;
          };
        };

        animations = {
          enabled = true;
          first_launch_animation = true;
        };

        bezier = [ "custom, 0, 0.7, 0.7, 1" ];
        animation = [
          "global, 1, 2, custom"
          "workspaces, 1, 2, custom, slidefadevert 15%"
          "windows, 1, 2, custom, popin 55%"
          "layers, 1, 1, custom, fade"
          "fadeIn, 0"
          "fadeShadow, 1, 7, custom"
        ];

        input = {
          kb_layout = "latam";
          kb_options = "caps:swapescape";
          numlock_by_default = false;
          resolve_binds_by_sym = false;
          repeat_rate = 60;
          repeat_delay = 160;
          force_no_accel = true;
          natural_scroll = false;
          follow_mouse = "0";
          focus_on_close = "0";
          mouse_refocus = false;
          float_switch_override_focus = "0";
          special_fallthrough = false;
          off_window_axis_events = "3";
          emulate_discrete_scroll = "0";
        };

        group = {
          auto_group = false;
          groupbar = {
            enabled = false;
          };
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          font_family = "monospace";
          vfr = true;
          vrr = "0"; # Adaptive Sync
          always_follow_on_dnd = false;
          layers_hog_keyboard_focus = true;
          animate_manual_resizes = true;
          animate_mouse_windowdragging = false;
          disable_autoreload = true;
          enable_swallow = false;
          focus_on_activate = true;
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
          inactive_timeout = 10;
          no_warps = true;
          persistent_warps = false;
          warp_on_change_workspace = false;
          enable_hyprcursor = true;
          hide_on_key_press = false;
        };

        exec-once = "waybar";
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,12"
        ];

        monitor = ",1920x1080@60.00,0x0,1";
        "$workspace" = "SUPER";
        "$window" = "ALT";
        "$window-focus" = "$window+CTRL";
        "$window-resize" = "$window+SHIFT";
        "$window-move" = "$window+CTRL+SHIFT";

        bind = [
          "$workspace, Delete, exit"
          "$workspace, q, movetoworkspace, r-1"
          "$workspace, e, movetoworkspace, r+1"
          "$workspace, 1, workspace, 1"
          "$workspace, 2, workspace, 2"
          "$workspace, 3, workspace, 3"
          "$workspace, 4, workspace, 4"
          "$workspace, 5, workspace, 5"
          "$workspace, 6, workspace, 6"
          "$workspace, 7, workspace, 7"
          "$workspace, 8, workspace, 8"
          "$workspace, 9, workspace, 9"
          "$workspace, 0, workspace, 10"

          "$window, w, exec, $web-browser"
          "$window, e, exec, $terminal-emulator"
          "$window, a, exec, pkill $app-launcher || $app-launcher"
          "$window, q, killactive"
          "$window, f, fullscreen, 0"
          "$window, 1, layoutmsg, swapsplit"
          "$window, 2, layoutmsg, togglesplit"
          "$window, 3, pseudo"
          "$window, 4, togglefloating"
          "$window, 5, centerwindow"
          "$window, 6, pin"

          "$window, h, layoutmsg, preselect l"
          "$window, j, layoutmsg, preselect d"
          "$window, k, layoutmsg, preselect u"
          "$window, l, layoutmsg, preselect r"

          "$window-move, h, swapwindow, l"
          "$window-move, j, swapwindow, d"
          "$window-move, k, swapwindow, u"
          "$window-move, l, swapwindow, r"

          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];

        binde = [
          "$workspace, k, workspace, r-1"
          "$workspace, j, workspace, r+1"

          "$window, Tab, cyclenext"

          "$window-resize, h, resizeactive, -24 0"
          "$window-resize, j, resizeactive, 0  24"
          "$window-resize, k, resizeactive, 0 -24"
          "$window-resize, l, resizeactive, 24 0"

          "$window-focus, h, movefocus, l"
          "$window-focus, j, movefocus, d"
          "$window-focus, k, movefocus, u"
          "$window-focus, l, movefocus, r"

          "$window-move, h, moveactive, -24 0"
          "$window-move, j, moveactive, 0 24"
          "$window-move, k, moveactive, 0 -24"
          "$window-move, l, moveactive, 24 0"
        ];

        bindl = [
          ", Print, exec, hyprshot -m region -t 1000"
          "$workspace , c, exec, hyprpicker -a -f hex"
          "$workspace , p, exec, hyprshot -m output -m active -t 2000"
          "$window , p, exec, hyprshot -m window -m active -t 2000"
        ];

        bindm = [
          "$window, mouse:272, movewindow"
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
  };
}
