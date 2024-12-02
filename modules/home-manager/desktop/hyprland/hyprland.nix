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
        # Variables
        "$terminal-emulator" = "foot";
        "$web-browser" = "firefox";
        "$app-launcher" = "tofi-drun";
        "$status-bar" = "waybar";

        "$group" = "CTRL+SHIFT";
        "$workspace" = "SUPER";
        "$workspace-hard" = "$workspace+CTRL";
        "$window" = "ALT";
        "$window-medium" = "$window+SHIFT";
        "$window-hard" = "$window+CTRL";
        "$window-harder" = "$window+SHIFT+CTRL";

        # Keywords
        monitor = ",1920x1080@99.93,0x0,1";
        env = [
          "XDG_SESSION_TYPE,wayland"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
        ];
        exec-once = [
          "$status-bar"
          "[workspace 1 silent] $web-browser"
          "[workspace 2 silent] $terminal-emulator"
          "[workspace 2 silent] $terminal-emulator"
          "[workspace 3 silent] $terminal-emulator"
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
          "$window, mouse:272, movewindow"
        ];

        binde = [
          "$window-medium, h, resizeactive, -24 0"
          "$window-medium, j, resizeactive, 0  24"
          "$window-medium, k, resizeactive, 0 -24"
          "$window-medium, l, resizeactive, 24 0"

          "$window-harder, h, moveactive, -24 0"
          "$window-harder, j, moveactive, 0 24"
          "$window-harder, k, moveactive, 0 -24"
          "$window-harder, l, moveactive, 24 0"
        ];

        bind = [
          ", Print, exec, hyprshot -m region -t 1000"
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 0.55 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          "$group, z, movegroupwindow, b"
          "$group, x, movegroupwindow, f"
          "$group, c, togglegroup"
          "$group, h, moveintogroup, l"
          "$group, j, moveintogroup, d"
          "$group, k, moveintogroup, u"
          "$group, l, moveintogroup, r"

          "$workspace, z, workspace, r-1"
          "$workspace, x, workspace, r+1"
          "$workspace, e, exec, hyprpicker -a -f hex"
          "$workspace, s, exec, hyprshot -m output -m active -t 2000"
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

          "$workspace-hard, z, movetoworkspace, r-1"
          "$workspace-hard, x, movetoworkspace, r+1"
          "$workspace-hard, q, exit"

          "$window, z, changegroupactive, b"
          "$window, x, changegroupactive, f"
          "$window, c, lockactivegroup, toggle"
          "$window, a, exec, pkill $app-launcher || $app-launcher"
          "$window, d, moveoutofgroup, active"
          "$window, f, fullscreen, 0"
          "$window, h, layoutmsg, preselect l"
          "$window, j, layoutmsg, preselect d"
          "$window, k, layoutmsg, preselect u"
          "$window, l, layoutmsg, preselect r"
          "$window, q, killactive"
          "$window, w, exec, $web-browser"
          "$window, e, exec, $terminal-emulator"
          "$window, s, exec, hyprshot -m window -m active -t 2000"
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
          "$window, Tab, cyclenext"

          "$window-medium, z, layoutmsg, swapsplit"
          "$window-medium, x, layoutmsg, togglesplit"
          "$window-medium, c, centerwindow"
          "$window-medium, s, pseudo"
          "$window-medium, f, togglefloating"
          "$window-medium, p, pin"
          "$window-medium, Tab, cyclenext, prev"

          "$window-hard, h, movefocus, l"
          "$window-hard, j, movefocus, d"
          "$window-hard, k, movefocus, u"
          "$window-hard, l, movefocus, r"
          "$window-hard, s, exec, hyprshot -m region -t 1000"

          "$window-harder, h, swapwindow, l"
          "$window-harder, j, swapwindow, d"
          "$window-harder, k, swapwindow, u"
          "$window-harder, l, swapwindow, r"
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
          repeat_rate = 100;
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
