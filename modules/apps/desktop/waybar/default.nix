{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.waybar.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        exec-once = [ "uwsm app -- waybar" ];
      };
      programs.waybar = {
        enable = true;
        systemd.enable = false;
        settings = {
          mainBar = {
            output = [
              "DP-1"
            ];
            layer = "top";
            position = "top";
            height = 24;
            width = 0;
            spacing = 0;
            exclusive = true;
            reload_style_on_change = true;
            "hyprland/workspaces" = {
              active-only = false;
              all-outputs = true;
              disable-scroll = true;
              format = " {icon}  {windows} ";
              format-window-separator = " ";
              window-rewrite-default = "";
              window-rewrite = {
                "foot" = "";
                "class<firefox>" = "";
                "title<.*youtube.*>" = "";
              };
            };
            modules-left = [
              "hyprland/workspaces"
            ];
            "hyprland/window" = {
              format = "{title}";
              icon = true;
              icon-size = 24;
              max-length = 70;
              rewrite = {
                "(.*) — Mozilla Firefox" = "$1";
              };
            };
            modules-center = [
              "hyprland/window"
            ];
            "clock" = {
              interval = 60;
              format = "  {:%H:%M}";
              tooltip-format = "{:%d-%m-%Y}";
            };
            "bluetooth" = {
              on-click = "blueman-manager";
              format = " Bluetooth";
              format-connected = " {device_alias}";
              format-connected-battery = " {device_alias} ({device_battery_percentage}%)";
              format-device-preference = [
                "Galaxy Buds FE"
              ];
              tooltip-format = "";
              tooltip-format-connected = "{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}";
              tooltip-format-enumerate-connected-battery = "{device_alias} ({device_battery_percentage}%)";
            };
            "wireplumber" = {
              max-volume = 55.0;
              scroll-step = 5.0;
              on-click = "pavucontrol";
              format = "{icon}  {volume}%";
              format-icons = [
                ""
                ""
                ""
              ];
            };
            "temperature" = {
              thermal-zone = 2;
              format = " {temperatureC} °C";
              tooltip = false;
            };
            "cpu" = {
              interval = 10;
              format = "  {usage}%";
            };
            "memory" = {
              interval = 30;
              format = "  {used}G";
              tooltip = false;
            };
            "group/hardware" = {
              orientation = "horizontal";
              modules = [
                "temperature"
                "cpu"
                "memory"
              ];
            };
            modules-right = [
              "clock"
              "bluetooth"
              "wireplumber"
              "group/hardware"
            ];
          };
        };
        style = ''
          * {
          font-family: Comfortaa;
          font-size: 14px;
          min-height: 0;
          }
          window#waybar {
          background-color: transparent;
          color: #ffffff;
          }
          window#waybar.hidden {
          opacity: 0.2;
          }
          button {
          border: none;
          border-radius: 0;
          }
          button:hover {
          background: inherit;
          }
          #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
          }
          #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          }
          #workspaces button.active {
          background-color: rgba (0, 187, 233, 0.7);
          }
          #workspaces button.urgent {
          background-color: #eb4d4b;
          }
          #mode {
          background-color: #64727d;
          }
          .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
          }
          .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
          }
          @keyframes blink {
          to {
          background-color: #ffffff;
          color: #000000;
          }
          }
          label:focus {
          background-color: #000000;
          }
          #window,
          #workspaces {
          margin: 0 4px;
          }
          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #wireplumber,
          #custom-media,
          #tray,
          #mode,
          #idle_inhibitor,
          #scratchpad,
          #power-profiles-daemon,
          #bluetooth,
          #mpd {
          padding: 0 10px;
          color: #ffffff;
          }
          #clock,
          #bluetooth,
          #wireplumber,
          #wireplumber.muted {
          background-color: rgba (33, 100, 215, 0.5);
          }
          #temperature,
          #temperature.critical,
          #cpu,
          #memory {
          background-color: rgba (155, 89, 182, 0.5);
          }
        '';
      };
    };
  };
}
