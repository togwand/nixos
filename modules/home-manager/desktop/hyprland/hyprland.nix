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
      systemd.enable = false;
      settings = {
        # Variables
        "$terminal-emulator" = "foot";
        "$web-browser" = "firefox";
        "$app-launcher" = "tofi-drun";

        "$workspace-easy" = "SUPER";
        "$workspace" = "$workspace-easy+SHIFT";
        "$window-easy" = "ALT";
        "$window" = "$window-easy+SHIFT";
        "$window-medium" = "$window-easy+CTRL";
        "$window-hard" = "$window-easy+CTRL+SHIFT";
        "$window-harder" = "$window-easy+CTRL+SUPER";
        "$window-hardest" = "$window-easy+CTRL+SHIFT+SUPER";

        # Keywords
        monitor = ", preferred, auto, 1";
        exec-once = [
          "systemctl --user enable --now waybar.service"
          "systemctl --user enable --now hyprpaper.service"
          "[workspace 1 silent] uwsm app -- $web-browser"
          "[workspace 2 silent] uwsm app -- $terminal-emulator"
        ];

        bezier = [ "custom, 0, 0.7, 0.7, 1" ];
        animation = [
          "global, 1, 2, custom"
          "windows, 1, 2, custom, popin 55%"
          "layers, 1, 1, custom, fade"
          "fadeIn, 0"
          "border, 1, 7, custom"
          "borderangle, 0"
          "workspaces, 1, 2, custom, slidefadevert 15%"
        ];

        bindm = [
          "$window-easy, mouse:272, movewindow"
        ];

        binde = [
          "$workspace-easy, j, workspace, r+1"
          "$workspace-easy, k, workspace, r-1"

          "$workspace, j, movetoworkspace, r+1"
          "$workspace, k, movetoworkspace, r-1"

          "$window-easy, Tab, cyclenext"

          "$window, j, changegroupactive, b"
          "$window, k, changegroupactive, f"
          "$window, q, movegroupwindow, b"
          "$window, e, movegroupwindow, f"
          "$window, Tab, cyclenext, prev"

          "$window-medium, h, movefocus, l"
          "$window-medium, j, movefocus, d"
          "$window-medium, k, movefocus, u"
          "$window-medium, l, movefocus, r"

          "$window-hard, h, moveactive, -24 0"
          "$window-hard, j, moveactive, 0 24"
          "$window-hard, k, moveactive, 0 -24"
          "$window-hard, l, moveactive, 24 0"

          "$window-harder, h, resizeactive, -24 0"
          "$window-harder, j, resizeactive, 0  24"
          "$window-harder, k, resizeactive, 0 -24"
          "$window-harder, l, resizeactive, 24 0"
        ];

        bind = [
          ", Print, exec, uwsm app -- hyprshot -m region -t 1000"
          ", XF86AudioRaiseVolume, exec, uwsm app -- wpctl set-volume -l 0.5 @DEFAULT_AUDIO_SINK@ 2%+"
          ", XF86AudioLowerVolume, exec, uwsm app -- wpctl set-volume -l 0.5 @DEFAULT_AUDIO_SINK@ 2%-"
          ", XF86AudioMute, exec, uwsm app -- wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          "$workspace-easy, s, exec, uwsm app -- hyprshot -m output -m active -t 2000"
          "$workspace-easy, e, exec, uwsm app -- hyprpicker -a -f rgb"
          "$workspace-easy, 1, workspace, 1"
          "$workspace-easy, 2, workspace, 2"
          "$workspace-easy, 3, workspace, 3"
          "$workspace-easy, 4, workspace, 4"
          "$workspace-easy, 5, workspace, 5"
          "$workspace-easy, 6, workspace, 6"
          "$workspace-easy, 7, workspace, 7"
          "$workspace-easy, 8, workspace, 8"
          "$workspace-easy, 9, workspace, 9"
          "$workspace-easy, 0, workspace, 10"

          "$workspace, s, exec, uwsm app -- hyprshot -m region -t 1000"
          "$workspace, e, exec, uwsm app -- hyprpicker -a -f hex"
          "$workspace, Delete, exec, uwsm stop"

          "$window-easy, a, exec, uwsm app -- pkill $app-launcher || uwsm app -- $app-launcher"
          "$window-easy, s, exec, uwsm app -- hyprshot -m window -m active -t 2000"
          "$window-easy, f, fullscreen, 0"
          "$window-easy, h, layoutmsg, preselect l"
          "$window-easy, j, layoutmsg, preselect d"
          "$window-easy, k, layoutmsg, preselect u"
          "$window-easy, l, layoutmsg, preselect r"
          "$window-easy, q, killactive"
          "$window-easy, w, exec, uwsm app -- $web-browser"
          "$window-easy, e, exec, uwsm app -- $terminal-emulator"

          "$window, x, lockactivegroup, toggle"
          "$window, f, togglegroup"
          "$window, 1, changegroupactive, 1"
          "$window, 2, changegroupactive, 2"
          "$window, 3, changegroupactive, 3"
          "$window, 4, changegroupactive, 4"
          "$window, 5, changegroupactive, 5"
          "$window, 6, changegroupactive, 6"
          "$window, 7, changegroupactive, 7"
          "$window, 8, changegroupactive, 8"
          "$window, 9, changegroupactive, 9"
          "$window, 0, changegroupactive, 10"

          "$window-medium, x, pin"
          "$window-medium, c, centerwindow"
          "$window-medium, s, pseudo"
          "$window-medium, f, togglefloating"
          "$window-medium, q, layoutmsg, swapsplit"
          "$window-medium, e, layoutmsg, togglesplit"

          "$window-hard, h, swapwindow, l"
          "$window-hard, j, swapwindow, d"
          "$window-hard, k, swapwindow, u"
          "$window-hard, l, swapwindow, r"

          "$window-hardest, h, movewindoworgroup, l"
          "$window-hardest, j, movewindoworgroup, d"
          "$window-hardest, k, movewindoworgroup, u"
          "$window-hardest, l, movewindoworgroup, r"
        ];

        # Options
        dwindle = {
          force_split = "2";
          preserve_split = true;
          smart_split = false;
          smart_resizing = false;
          permanent_direction_override = true;
          use_active_for_splits = true;
        };

        general = {
          border_size = 2;
          no_border_on_floating = false;
          gaps_in = "8,8,8,8";
          gaps_out = "16,16,16,16";
          gaps_workspaces = 0;
          "col.active_border" = "rgba(333333aa) rgba(333333aa) rgba(333333aa) rgba(2D48B9dd) 19deg";
          "col.inactive_border" = "rgba(333333aa)";
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
          rounding = 12;
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
            enabled = false;
          };
        };

        animations = {
          enabled = true;
          first_launch_animation = true;
        };

        input = {
          kb_layout = "latam";
          kb_options = "caps:swapescape";
          numlock_by_default = false;
          resolve_binds_by_sym = false;
          repeat_rate = 120;
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
          auto_group = true;
          insert_after_current = true;
          focus_removed_window = false;
          drag_into_group = true;
          merge_groups_on_drag = true;
          merge_groups_on_groupbar = true;
          merge_floated_into_tiled_on_groupbar = true;
          group_on_movetoworkspace = false;
          "col.border_active" = "rgba(333333aa) rgba(333333aa) rgba(333333aa) rgba(9B59B6dd) 19deg";
          "col.border_inactive" = "rgba(333333aa)";
          "col.border_locked_active" = "rgba(333333aa) rgba(333333aa) rgba(333333aa) rgba(B6596Bdd) 19deg";
          "col.border_locked_inactive" = "rgba(333333aa)";
          groupbar = {
            enabled = true;
            font_family = "sans";
            font_size = 9;
            gradients = true;
            height = 12;
            stacked = false;
            render_titles = true;
            scrolling = true;
            text_color = "rgb(ffffff)";
            "col.active" = "rgba(9B59B699)";
            "col.inactive" = "rgba(00000000)";
            "col.locked_active" = "rgba(B6596B99)";
            "col.locked_inactive" = "rgba(00000000)";
          };
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          font_family = "monospace";
          vfr = true;
          vrr = "0"; # Adaptive Sync
          always_follow_on_dnd = true;
          layers_hog_keyboard_focus = true;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          disable_autoreload = true;
          enable_swallow = false;
          focus_on_activate = true;
          new_window_takes_over_fullscreen = "1";
          exit_window_retains_fullscreen = true;
          initial_workspace_tracking = "0";
          middle_click_paste = false;
          render_unfocused_fps = 1;
        };

        binds = {
          pass_mouse_when_bound = false;
          scroll_event_delay = 160;
          workspace_back_and_forth = false;
          allow_workspace_cycles = false;
          workspace_center_on = "1";
          focus_preferred_method = "0";
          movefocus_cycles_fullscreen = false;
          disable_keybind_grabbing = false;
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
          expand_undersized_textures = true;
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
          enable_hyprcursor = false;
          hide_on_key_press = false;
        };
      };
    };
  };
}
