{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.lf.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      home.packages = with pkgs; [
        file
        chafa
        python312Packages.pygments
        ansi
      ];
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        exec-once = [
          (lib.mkIf config.apps.desktop.foot.enable "[workspace 1 silent] uwsm app -- foot lf")
        ];
        bind = [
          (lib.mkIf config.apps.desktop.foot.enable "$window-easy, d, exec, uwsm app -- foot lf")
          (lib.mkIf config.apps.desktop.foot.enable "$window, d, exec, uwsm app -- foot sudo lf")
        ];
      };
      programs.lf = {
        enable = true;
        cmdKeybindings = {
          "\"<c-j>\"" = "cmd-history-next";
          "\"<c-k>\"" = "cmd-history-prev";
        };
        commands = {
          get-mime-type = "%xdg-mime query filetype \"$f\"";
          open = "$$OPENER $f";
        };
        previewer = {
          keybinding = "i";
          source = pkgs.writeShellScript "pv.sh" ''
            #!/bin/sh
            case "$(file -Lb --mime-type -- "$1")" in
            image/*) chafa -f sixel -s "$2x$3" --animate off --polite on "$1";exit 1;;
            esac
            formatter="16m"
            style="material"
            case "$1" in
            *.nix) pygmentize -l nix -f $formatter -O style=$style <"$1";;
            *.sh) pygmentize -l shell -f $formatter -O style=$style <"$1";;
            *.md) pygmentize -l md -f $formatter -O style=$style <"$1";;
            *.toml) pygmentize -l toml -f $formatter -O style=$style <"$1";;
            *.lock) pygmentize -l json -f $formatter -O style=$style <"$1";;
            *.txt) pygmentize -l text -f $formatter -O style=$style <"$1";;
            esac
          '';
        };
        settings = {
          anchorfind = false;
          autoquit = true;
          dircache = false;
          dircounts = false;
          dirfirst = true;
          dironly = false;
          dirpreviews = false;
          drawbox = true;
          hidden = true;
          history = true;
          icons = false;
          ignorecase = true;
          ignoredia = true;
          incsearch = true;
          incfilter = true;
          info = [
            "time"
          ];
          infotimefmtnew = "_2/1";
          infotimefmtold = "";
          mouse = false;
          number = false;
          preview = true;
          ratios = [
            2
            2
            7
            6
          ];
          reverse = false;
          roundbox = false;
          rulerfmt = "";
          showbinds = false;
          sixel = true;
          smartcase = true;
          smartdia = true;
          sortby = "ext";
          statfmt = "%S| %u| \\033[36m%p\\033[0m| -> %l";
          tabstop = 4;
          timefmt = "02-01-2006";
          truncatechar = "~";
          wrapscan = false;
          wrapscroll = false;
        };
        keybindings = {
          "z" = "$$SHELL";
          "x" = "delete";
          "c" = "clear";
          "v" = "toggle";
          "n" = "search-next";
          "m" = "mark-load";
          "s" = "mark-save";
          "d" = "cut";
          "f" = "filter";
          "h" = "updir";
          "j" = "down";
          "k" = "up";
          "l" = "open";
          "q" = "quit";
          "w" = "";
          "r" = "rename";
          "t" = null;
          "y" = "copy";
          "u" = "unselect";
          "i" = "invert";
          "p" = "paste";
          "gg" = "top";
          "N" = "search-prev";
          "M" = null;
          "F" = null;
          "G" = "bottom";
          "H" = null;
          "L" = null;
          "[" = null;
          "]" = null;
          "\",\"" = null;
          "\";\"" = null;
          "\":\"" = "read";
          "\"'\"" = null;
          "\"&\"" = null;
          "\"/\"" = "search";
          "\"?\"" = "search-back";
          "\"<space>\"" = "";
          "\"<enter>\"" = "open";
          "\"<c-b>\"" = null;
          "\"<c-d>\"" = "half-down";
          "\"<c-f>\"" = null;
          "\"<c-l>\"" = null;
          "\"<c-r>\"" = "reload";
          "\"<c-u>\"" = "half-up";
          "\"<c-y>\"" = null;
          "\"<left>\"" = null;
          "\"<down>\"" = null;
          "\"<right>\"" = null;
          "\"<up>\"" = null;
          "\"<pgdn>\"" = null;
          "\"<pgup>\"" = null;
        };
      };
    };
  };
}
