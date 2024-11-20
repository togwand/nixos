to_menu() {
	refresh=true
	menu=$1
}

read_args() {
	read -rp "$1 " arguments
	if [ "$arguments" = '' ]
	then $1 
	else $1 "$arguments"
	fi
	
}

help() {
cat << EOF
DESCRIPTION
 My program for fast execution of shell commands and system management

USAGE
 Press a key to execute the displayed menu option (numbers) or a global keybind (letters)

GLOBAL KEYBINDINGS
 c, C
 		Change directories inside this program
 h, H
 		Read about the program usage in a pager screen
 q, Q
 		Go back to main menu.
		If already on main menu, exit the program instead.
EOF
}

status() {
cat << EOF
MANAGER MENU
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
EOF
}

system_menu() {
cat << EOF

SYSTEM MENU
 1) Collect garbage
 2) Optimise store
 3) Patch hardware configuration
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
 1) Diff
 2) Add
 3) Commit
 4) Push
EOF
}

other_menu() {
cat << EOF

OTHER MENU
 1) Burn iso image
EOF
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

test_device() {
	if test -b /dev/"$1"
	then
		if lsblk -ndo type /dev/"$1" | grep -qF part
		then
			echo -e "\nThis is a partition, not a disk"
			return
		fi
	else
		echo -e "\nThis is not a valid storage device"
		return
	fi
}

burn_iso() {
	echo -e "\nDISKS AND PARTITIONS"
	lsblk --noheadings
	read -rp "Device: " burnt
	read -rp "ISO path: " path
	path=${path:-result/iso/nixos-*.iso}
	if test_device "$burnt"
	then
		wipefs /dev/"$burnt"
		cp "$path" /dev/"$burnt"
		sync "/dev/$burnt"
	else return
	fi
}

o1() {
	case $menu in
		main) to_menu system;;
		system) read_args nix-collect-garbage;;
		flake) nix fmt update;;
		git) git diff|bat;;
		other) burn_iso;;
	esac
}

o2() {
	case $menu in
		main) to_menu flake;;
		system) nix store optimise;;
		flake) nix flake update;;
		git) git add -A;;
	esac
}

patch_hw() {
	nixos-generate-config
	sed -i $'/fsType = "ntfs3"/a\\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix
	rm /etc/nixos/configuration.nix
}

build_config() {
	read -rp "mode: " mode
	mode=${mode:-switch}
	read -rp "name: " name
	name=${name:-""}
	nixos-rebuild "$mode" --quiet --impure --flake ."$name"
}

o3() {
	case $menu in
		main) to_menu git;;
		system) patch_hw;;
		flake) build_config;;
		git) git commit;;
	esac
}

build_iso() {
	read -rp "name: " name
	name=${name:minimal}
	nix build .#nixosConfigurations."$name".config.system.build.isoImage
}

o4() {
	case $menu in
		main) to_menu other;;
		flake) build_iso;;
		git) read_args "git push";;
	esac
}

change_directory() {
	echo -e "\nDirectories here:"
	ls --group-directories-first -a1d -- */ 2> /dev/null
	echo
	read_args cd
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
		1) o1;;
		2) o2;;
		3) o3;;
		4) o4;;
		c|C) change_directory;;
		h|H) help|less;;
		q|Q) quit;;
	esac
done
