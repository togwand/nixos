run() {
  if ! eval "$1"
  then
    echo -e "\n$1 ended with an error. Press any key to continue"
    read -rsn 1
    return
  fi
  if [ "$2" = "wait" ]
  then
    echo -e "\n$1 completed. Press any key to continue"
    read -rsn 1
  fi
}

confirm() {
  echo -e "\nConfirm command: $1"
  while true
  do
    read -reN 1 key 2> /dev/null
    case $key in
      "$(printf '\r')") run "$@" && break ;;
      *) break ;;
    esac
  done
}

cmd-args() {
  local cmd=$1 defaults=$2
  read -rep "$cmd " -i "$defaults" arguments
  local full="$cmd $arguments"
  if [ "${arguments}" = "" ]
  then $cmd
  else $full
  fi
}

header() { cat << EOF
SHELL MANAGER
 Press 'h' for help

STATUS
 User: $user
 Location: $PWD

EOF
}

system-menu() {
  cat << EOF
SYSTEM MENU
 1) Collect garbage
 2) Optimise store
EOF
  o1() {
    collect-garbage() {
      cmd-args "sudo -u $user nix-collect-garbage" "-d"
    }
    confirm "collect-garbage"
  }
  o2() {
    optimise-store() {
      sudo -u "$user" nix store optimise
    }
    confirm "optimise-store"
  }
}

flake-menu() {
  cat << EOF
FLAKE MENU
 1) Format
 2) Update
 3) Build NixOS config
 4) Build ISO
EOF
  o1() {
    format-flake() {
      sudo -u "$user" nix fmt
    }
    confirm "format-flake" wait
  }
  o2() {
    update-flake() {
      sudo -u "$user" nix flake update
    }
    confirm "update-flake"
  }
  o3() {
    build-config() {
      read -rei "switch" -p "mode: " mode
      read -rei "github:togwand/nixos-config/experimental" -p "uri: " flake_uri
      read -rei "$HOSTNAME" -p "name: " name
      nixos-rebuild "$mode" --flake "$flake_uri#$name"
    }
    confirm "build-config" wait
  }
  o4() {
    build-iso() {
      read -rei "github:togwand/nixos-config/experimental" -p "uri: " flake_uri
      read -rei "minimal_iso" -p "name: " config_name
      nix build "$flake_uri"#nixosConfigurations."$config_name".config.system.build.isoImage
    }
    confirm "build-iso" wait
  }
}

git-menu() {
  cat << EOF
GIT MENU
 1) Full diff
 2) Send changes
 3) Switch branch and merge with current
 4) Custom args
EOF
  o1() {
    full-diff() {
      sudo -u "$user" git add --all
      sudo -u "$user" git diff HEAD|sudo -u "$user" bat
    }
    confirm "full-diff"
  }
  o2() {
    send-changes() {
      sudo -u "$user" git add --all
      sudo -u "$user" git commit
      su -c git push
    }
    confirm "send-changes" wait
  }
  o3() {
    switch-merge() {
      local current_branch
      current_branch="$(git branch --show-current)"
      sudo -u "$user" echo "[BRANCHES]"
      sudo -u "$user" git branch
      read -rei "base" -p "switch to: " next_branch
      sudo -u "$user" git switch "$next_branch"
      sudo -u "$user" git merge "$current_branch"
      sudo -u "$user" echo "switched to $next_branch and merged with $current_branch"
    }
    confirm "switch-merge" wait
  }
  o4() {
    git-custom() {
      cmd-args "sudo -u $user git" ""
    }
    confirm "git-custom" wait
  }
}

misc-menu() {
  cat << EOF
MISC MENU
 1) Burn iso image
EOF
  o1() {
    burn-iso() {
      sudo -u "$user" lsblk
      read -re -p "device: " burnt
      sudo -u "$user" wipefs -a /dev/"$burnt"
      read -rei "result/iso" -p "path to iso: " iso_path
      sudo -u "$user" cp "$iso_path/nixos-*.iso" "/dev/$burnt"
      sudo -u "$user" sync "/dev/$burnt"
    }
    confirm "burn-iso" wait
  }
}

switch-user() {
  echo -e "\nUSERS"
  passwd -Sa | grep P | grep -Eo '^[^ ]+'
  echo -e "\nWhich user do you want to run this program with?"
  read -re user
}

change-directory() {
  echo "directories here:"
  ls --group-directories-first -a1d -- */ 2> /dev/null
  cmd-args "cd" ""
}

help() {
  cat << EOF
DESCRIPTION
 My program for fast execution of shell commands and system management

USAGE
 Use the keybinds below to execute an option

TIPS
 If asked for confirmation, press Enter (all other keys abort execution)
 You can abort some ongoing commands with CTRL+C

KEYBINDS
 digit
 		Execute the currently displayed menu option by its number (0 equals 10)
 s, S
 		Changes the active menu to the system menu
 f, F
 		Changes the active menu to the flake menu
 g, G
 		Changes the active menu to the git menu
 m, M
 		Changes the active menu to the misc menu, which contains ungrouped commands
 u, U
 		Change the user to execute commands with when they don't use root permissions
 c, C
 		Change the program directory
 h, H
 		Read about the program usage in a pager screen
 q, Q
		Exit the program
EOF
}

if [ $EUID != 0 ]
then
  echo "Not running as root, restart with elevated permissions"
  exit
fi

stty -echoctl
trap " " SIGINT
user=$USER
menu="system"

while true
do
  o1() { return
  }
  o2() { return
  }
  o3() { return
  }
  o4() { return
  }
  o5() { return
  }
  o6() { return
  }
  o7() { return
  }
  o8() { return
  }
  o9() { return
  }
  o10() { return
  }
  clear
  header
  case $menu in
    system) system-menu ;;
    flake) flake-menu ;;
    git) git-menu ;;
    misc) misc-menu ;;
  esac
  read -rsn 1 key
  case $key in
    1) o1 ;;
    2) o2 ;;
    3) o3 ;;
    4) o4 ;;
    5) o5 ;;
    6) o6 ;;
    7) o7 ;;
    8) o8 ;;
    9) o9 ;;
    10) o10 ;;
    s|S) menu="system" ;;
    f|F) menu="flake" ;;
    g|G) menu="git" ;;
    m|M) menu="misc" ;;
    u|U) run "switch-user" ;;
    c|C) run "change-directory" ;;
    h|H) run "help|less" ;;
    q|Q) clear && exit ;;
  esac
done
