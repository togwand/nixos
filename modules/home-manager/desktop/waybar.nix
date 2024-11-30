{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.waybar.enable {
    home-manager.users.${user}.programs.waybar = {
      enable = true;
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
          };
          "wlr/taskbar" = {
            all-outputs = false;
            format = "{icon}";
            icon-size = 16;
            sort-by-app-id = true;
            on-click = "activate";
          };
          modules-left = [
            "hyprland/workspaces"
            "wlr/taskbar"
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
            format = "{:%d-%m-%Y}";
            max-length = 25;
            tooltip = true;
            tooltip-format = "{:%H:%M}";
          };
          "bluetooth" = {
            on-click = "blueman-manager";
            format = "  Bluetooth";
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
            max-length = 10;
          };
          "memory" = {
            interval = 30;
            format = "  {used}G";
            max-length = 10;
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
        background-color: rgba (50, 50, 50, 0.4);
        color: #ffffff;
        transition-property: background-color;
        transition-duration: .5s;
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
        background-color: rgba (100, 100, 100, 0.5);
        }
        #workspaces button.urgent {
        background-color: #eb4d4b;
        }
        #taskbar button.active {
        background-color: rgba (100, 100, 100, 0.5);
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
        background-color: #2164d7;
        }
        #temperature,
        #temperature.critical,
        #cpu,
        #memory {
        background-color: #9b59b6;
        }
      '';
    };
  };
}
