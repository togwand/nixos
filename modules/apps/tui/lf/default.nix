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
        poppler_utils
        python312Packages.pygments
        tree
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
          cadoras = "$cadoras";
          open = "$$OPENER $f";
          touch = "$touch newfile";
          mkdir = "$mkdir newdir";
        };
        previewer = {
          keybinding = null;
          source = pkgs.writeShellScript "pv.sh" ''
            #!/bin/sh
            case "$(file -Lb --mime-type -- "$1")" in
            inode/directory) tree -CL 2 --filelimit=30 --dirsfirst --noreport "$1";exit 0;;
            image/*) chafa -f sixel -s "$2x$3" --animate off --polite on "$1";exit 0;;
            esac

            formatter="16m"
            style="nord"
            case "$1" in
            *.nix) pygmentize -l nix -f $formatter -O style=$style <"$1";exit 0;;
            *.sh) pygmentize -l shell -f $formatter -O style=$style <"$1";exit 0;;
            *.md) pygmentize -l md -f $formatter -O style=$style <"$1";exit 0;;
            *.lock) pygmentize -l json -f $formatter -O style=$style <"$1";exit 0;;
            *.txt) pygmentize -l text -f $formatter -O style=$style <"$1";exit 0;;
            *.toml) pygmentize -l toml -f $formatter -O style=$style <"$1";exit 0;;
            *.pdf) 
            pdf_base=$(basename "$1" .pdf)
            pdftocairo -jpeg -singlefile "$1" "/tmp/$pdf_base"
            chafa -f sixel -s "$2x$3" --animate off --polite on "/tmp/$pdf_base.jpg"
            exit 0;;
            esac

            case "$(file -Lb --mime-type -- "$1")" in
            text/plain) cat "$1";;
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
          dirpreviews = true;
          drawbox = true;
          hidden = false;
          history = true;
          icons = false;
          ignorecase = true;
          ignoredia = true;
          incsearch = true;
          incfilter = true;
          info = [
            "size"
          ];
          mouse = false;
          number = false;
          preview = true;
          ratios = [
            2
            3
          ];
          reverse = false;
          roundbox = false;
          rulerfmt = "";
          selmode = "dir";
          showbinds = false;
          sixel = true;
          smartcase = true;
          smartdia = true;
          sortby = "ext";
          statfmt = "%t| %u| \\033[36m%p\\033[0m| -> %l";
          tabstop = 4;
          timefmt = "02-01-2006";
          truncatechar = "~";
          wrapscan = false;
          wrapscroll = false;
        };
        keybindings = {
          "z" = "$$SHELL";
          "x" = "delete; reload";
          "c" = "clear";
          "v" = "toggle";
          "n" = "mkdir; reload";
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
          "t" = "touch; reload";
          "y" = "copy";
          "u" = "unselect";
          "i" = null;
          "p" = "paste; reload";
          "gg" = "top";
          "V" = "invert";
          "N" = null;
          "M" = null;
          "F" = null;
          "G" = "bottom";
          "H" = "set hidden!";
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
          "\"<space>\"" = "tag-toggle";
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
