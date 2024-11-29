help() {
cat << EOF
DESCRIPTION
 My program for fast execution of shell commands and system management

USAGE
 Press a key to execute a keybind or the displayed menu option

GLOBAL KEYBINDINGS
 c, C
 		Change directories inside this program
 h, H
 		Read about the program usage in a pager screen
 q, Q
 		Go back to main menu
		If already on main menu, exit the program instead

KNOWN ISSUES
 You can "queue" options before the current one ends
EOF
}

status() {
cat << EOF
SHELL MANAGER
 Press 'h' for help

STATUS
 Location: $PWD
EOF
if [ $EUID = 0 ]
then cat << EOF
 Running as root
EOF
fi
}
main_menu() {
cat << EOF

MAIN MENU
 1) System
 2) Flake
 3) Git
 4) Other
EOF
}

system_menu() {
cat << EOF

SYSTEM MENU
 1) Collect garbage
 2) Optimise store
EOF
}

flake_menu() {
cat << EOF

FLAKE MENU
 1) Format
 2) Update
 3) Build NixOS config
 4) Build ISO
EOF
}

git_menu() {
cat << EOF

GIT MENU
 1) Full diff
 2) Send changes
 3) Switch branch and merge with current
 4) Custom args
EOF
}

other_menu() {
cat << EOF

OTHER MENU
 1) Burn iso image
EOF
}

to_menu() {
	refresh=true
	menu=$1
}

cmd_args() {
	local cmd=$1 defaults=$2
	read -rep "$cmd " -i "$defaults" arguments
	local full="$cmd $arguments"
	if [ "${arguments}" = "" ]
	then $cmd
	else $full
	fi
}

burn_iso() {
	lsblk
	read -re -p "device: " burnt
	wipefs /dev/"$burnt"
	cp result/iso/nixos-*.iso /dev/"$burnt"
	sync "/dev/$burnt"
}

o1() {
	case $menu in
		main) to_menu system;;
		system) cmd_args "nix-collect-garbage" "-d --quiet";;
		flake) nix fmt;;
		git) git add --all && git diff HEAD|bat;;
		other) burn_iso;;
	esac
}

send_changes() {
	git add --all
	git commit
	git push
}

o2() {
	case $menu in
		main) to_menu flake;;
		system) nix store optimise;;
		flake) nix flake update;;
		git) send_changes;;
	esac
}

build_config() {
	read -rei "test" -p "mode: " mode
	read -rei "$HOSTNAME" -p "name: " name
	nixos-rebuild "$mode" --quiet --flake ."#$name"
}

switch_merge() {
	local current_branch
	current_branch="$(git branch --show-current)"
	echo "[BRANCHES]"
	git branch
	read -rei "base" -p "switch to: " next_branch
	git switch "$next_branch"
	git merge "$current_branch"
	echo "switched to $next_branch and merged with $current_branch"
}

o3() {
	case $menu in
		main) to_menu git;;
		flake) build_config;;
		git) switch_merge;;
	esac
}

build_iso() {
	read -rei "github:togwand/nixos-config" -p "flake uri: " flake_uri
	read -rei "minimal_iso" -p "name: " config_name
	nix build "$flake_uri"#nixosConfigurations."$config_name".config.system.build.isoImage
}

o4() {
	case $menu in
		main) to_menu other;;
		flake) build_iso;;
		git) cmd_args "git" "";;
	esac
}

show_interface() {
	if $refresh
	then 
		refresh=false
		clear
		status
		case $menu in
			main) main_menu;;
			system) system_menu;;
			flake) flake_menu;;
			git) git_menu;;
			other) other_menu;;
		esac
	fi
}

nicer_bind() {
	local alias="$1"
	case $1 in
		o1) alias="#1";;o2) alias="#2";;o3) alias="#3";;
		o4) alias="#4";;
		change_directory) alias="directory change";;
	esac
	if $1
	then echo "$alias ended, next!"
	else echo "$alias ended with an error"
	fi
}

change_directory() {
	echo "directories here:"
	ls --group-directories-first -a1d -- */ 2> /dev/null
	cmd_args "cd" ""
	refresh=true
}

quit() {
	if [ "$menu" = "main" ]
	then exit
	else
		to_menu main
	fi
}

menu="main"
refresh=true
while true
do
	show_interface
	read -rsn 1 key
	case $key in
		1) nicer_bind o1;;2) nicer_bind o2;;3) nicer_bind o3;;
		4) nicer_bind o4;;
		c|C) nicer_bind change_directory;;
		h|H) help|less;;
		q|Q) clear && quit;;
	esac
done
