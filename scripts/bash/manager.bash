bin_name="${0##*/}"


documentation() {
cat << EOF
[ DOCUMENTATION ]
* Inputting anything besides nothing or an option gets you here
* To quickly abort the program or any running option just do 'CTRL+C'

Instructions
* Input an array of separated options and press enter to confirm execution order
* Example: 2 1 3 q

Troubleshooting
* Potential issues listed here are documented per option
* Some options will need elevated permissions (i.e. sudo $bin_name)
* Other options may work one way or another depending on the permissions
* If running with root privileges, a message will appear above the general options


[ GENERAL ]

d) Documentation
* Opens this documentation with the 'less' pager

q) Quit Menu
* Exits the active menu (or the program if it's the main menu)

Q) Quit Program
* Exits the program successfully using 'exit 0'

r) Reboot
* Restarts the computer


[ MAIN MENU ]

1) Configuration
* Manage the current system NixOS configuration

2) Nix store
* Manage the current system nix store

3) Flakes
* Manage a local flake directory

4) Git
* Manage a local git repository

5) ISO images
* Options for easy building and burning of ISO images


[ CONFIGURATION MENU ]

1) Patch hardware file - REQUIRES ELEVATED PERMISSIONS
* Generates NixOS hardware configuration
* Patches the write permissions of UID 1000 for mounted ntfs3 partitions
* Discards configuration.nix

2) Build flake configuration - REQUIRES ELEVATED PERMISSIONS
* Asks user for a flake path/uri, and the build mode
* To use the default values don't input anything when asked
* The defaults are the current path on switch mode
* It outputs a preview from the inputs
* User needs to confirm by entering "yes" (or nothing) to confirm
* Any other input will return the user to the configuration menu


[ STORE MENU ]

1) Delete unreachable files - WORKS DIFFERENTLY WITH AND WITHOUT ROOT PERMISSIONS
* Prompts to delete old generations along garbage files, or just the files
* This option reads the current user profile, and deletes the files of that profile

2) Replace identical with links
* 'nix store optimise'


[ FLAKES MENU ]

1) Format files (.nix)
* 'nix fmt' on the current directory

2) Update .lock file
* 'nix flake update' on the current directory


[ GIT MENU ]

1) Check diff
* 'git diff' on the current directory

2) Add
* 'git add' on the current directory

3) Commit
* 'git add -A' on the current directory
* 'git commit' on the current directory

4) Push
* 'git push' on the current directory


[ ISO IMAGES MENU ]

1) Build from flake
* Asks user for a flake path and config name. Uses defaults without input
* Displays preview of the path and asks for confirmation
* Builds an iso with nix build into the current path (result directory)

2) Burn into disk
* Lists devices to help the user input one
* Asks for device without /dev/ and for an iso path
* Tests the device validity as a disk before continuing
* Prepares the iso the copied into the device, copies and syncs afterwards


EOF
}


new_menu() {
	local txt=$1
	local is_open=true
	while [ "$is_open" = true ]
	do
		echo -e "\n* Path: $PWD"
		if [ $EUID = 0 ]
		then
			echo -e "* Running with root privileges"
		fi
		echo -e "\nGeneral"
		echo -e "d) Documentation"
		echo -e "q) Quit Menu"
		echo -e "Q) Quit Program"
		echo -e "r) Reboot"
		echo -e "$txt"
		IFS=' ' read -rp "Input: " -a input
		for option in "${input[@]}"
		do
			case "$option" in
				d) documentation|less;;q) is_open=false;;Q) exit 0;;r) systemctl reboot;;
				1)$2;;2)$3;;3)$4;;4)$5;;5)$6;;6)$7;;7)$8;;8)$9;;9)${10};;10)${11};;
				?) documentation|less;;
				*) documentation|less
			esac
		done
	done
}


confirm_execution() {
	local loop=true
	while $loop
	do
		local confirmation=""
		read -rsN 1 confirmation
		if [ "${confirmation,,}" = "y" ]
		then
			loop=false
			$1
		else
			if [ "${confirmation,,}" = "n" ]
			then
				loop=false
			else continue
			fi
		fi
	done
}


patch_hw() {
	nixos-generate-config
	sed -i $'/fsType = "ntfs3"/a\\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix
	rm /etc/nixos/configuration.nix
}


build_flake() {
	read -rp "Path: " path
	path=${path:-$1}
	read -rp "Mode: " mode
	mode=${mode:-$2}
	echo -e "\nBuild will use flake path [$path] and [$mode] mode. Confirm? (y/n)"
	confirm_execution "nixos-rebuild $mode --quiet --impure --flake $path"
}


config_menu() {
local default_path="." default_mode="switch"
new_menu "
Configuration Menu
1) Patch hardware file
2) Build flake configuration
" patch_hw "build_flake $default_path $default_mode"
}


delete_unreachable() {
	echo -e "Do you want to delete generations? (y/n)"
	if ! confirm_execution "nix-collect-garbage -d"
	then nix-collect-garbage
	fi
}


store_menu() {
new_menu "
Store Menu
1) Delete unreachable files
2) Replace identical with links
" "delete_unreachable" "nix store optimise"
}


flakes_menu() {
new_menu "
Flakes Menus
1) Format files (.nix)
2) Update .lock file
" "nix fmt" "nix flake update"
}


git_menu() {
new_menu "
Git Menu
1) Check diff
2) Add
3) Commit
4) Push
" "git diff" "git add -A" "git commit" "git push"
}


build_iso() {
	read -rp "Path: " path
	path=${path:-$1}
	read -rp "Config: " config
	config=${config:-$2}
	echo -e "\nBuild will use flake path [$path] and [$config] config. Confirm? (y/n)"
	confirm_execution "nix build $path#nixosConfigurations.$config.config.system.build.isoImage"
}


list_devices() {
	echo -e "\nDISKS AND PARTITIONS"
	lsblk --noheadings
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
	list_devices
	read -rp "Device: " burnt
	read -rp "ISO path: " path
	path=${path:-$1}
	if test_device "$burnt"
	then
		wipefs /dev/"$burnt"
		echo "Are you sure you want to burn the iso on $path into /dev/$burnt? (y/n)"
		confirm_execution "cp $path /dev/$burnt"
		sync "/dev/$burnt"
	else
		return
	fi
}


iso_menu() {
local default_path="." default_config="minimal" default_iso_path="result/iso/nixos-*.iso"
new_menu "
ISO images Menu
1) Build from flake
2) Burn into disk
" "build_iso $default_path $default_config" "burn_iso $default_iso_path"
}


main_menu() {
new_menu "
Main Menu
1) Configuration
2) Nix store
3) Flakes
4) Git
5) ISO images
" "config_menu" "store_menu" "flakes_menu" "git_menu" "iso_menu"
}


# SCRIPT START POINT
main_menu
