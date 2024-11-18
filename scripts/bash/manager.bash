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
* Runs "nix store optimise"


[ FLAKES MENU ]

1) Format files (.nix)
* Asks for a flake path, using the current directory as the default
* Formats all the nix files on the displayed path

2) Update .lock file
* Asks for a flake path, using the current directory as the default
* Updates inputs of the displayed path flake


[ GIT MENU ]

1) Check diff
* Asks for a path, using the current directory as the default
* 'git diff' the inputted (or default) path

2) Commit and push
* Asks for a path, using the current directory as the default
* Adds all the files of the path
* Commits the working tree
* Pushes commited changes to the remote branch with the same name


EOF
}


new_menu() {
	local txt=$1
	local is_open=true
	while [ "$is_open" = true ]
	do
		echo -e "\n * Path: $PWD"
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
				return 1
			else continue
			fi
		fi
	done
}


patch_hw() {
	if 
		nixos-generate-config
		sed -i $'/fsType = "ntfs3"/a\\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix
		rm /etc/nixos/configuration.nix
	then echo "Hardware configuration file patched!"
	else echo "Hardware configuration file wasn't patched..."
	fi
}


build_flake() {
	if
		read -rp "Path: " path
		path=${path:-$1}
		read -rp "Mode: " mode
		mode=${mode:-$2}
		echo -e "\nBuild will use flake path [$path] and [$mode] mode. Confirm? (y/n)"
		confirm_execution "nixos-rebuild $mode --quiet --impure --flake $path"
	then echo "Flake configuration built! Path = \"$path\" Mode = \"$mode\""
	else echo "Flake configuration wasn't built..."
	fi
}


config_menu() {
local default_mode="switch" default_path="."
new_menu "
Configuration Menu
1) Patch hardware file
2) Build flake configuration
" patch_hw "build_flake $default_path $default_mode"
}


delete_unreachable() {
	echo -e "Do you want to delete generations? (y/n)"
	if ! confirm_execution "nix-collect-garbage -d"
	then 
		nix-collect-garbage
		echo "Deleted unreachable files of user ID '$EUID'!"
		return 0
	else echo "Deleted unreachable files and old generations of user ID '$EUID'!"
	fi
}


store_menu() {
new_menu "
Store Menu
1) Delete unreachable files
2) Replace identical with links
" "delete_unreachable" "nix store optimise"
}


format_flake() {
	if
		read -rp "Path: " path
		path=${path:-$1}
		echo -e "\nFormat will use flake path [$path]. Confirm? (y/n)"
		confirm_execution "nix fmt $path"
	then echo "Flake files formatted! Path = \"$path\""
	else echo "Flake files weren't formatted..."
	fi
}


update_flake() {
	if
		read -rp "Path: " path
		path=${path:-$1}
		echo -e "\nUpdate will use path [$path]. Confirm? (y/n)"
		confirm_execution "nix flake update --flake $path"
	then echo "Flake .lock file updated! Path = \"$path\""
	else echo "Flake .lock file wasn't updated..."
	fi
}


flakes_menu() {
local default_path="."
new_menu "
Flakes Menus
1) Format files (.nix)
2) Update .lock file
" "format_flake $default_path" "update_flake $default_path"
}


check_diff(){
	read -rp "Path: " path
	path=${path:-$1}
	echo -e "\nDiff will use path [$path]. Confirm? (y/n)"
	confirm_execution "git diff $path"
}


commit_push(){
	read -rp "Path: " path
	path=${path:-$1}
	git add -A "$path"
	echo -e "\nCommit will use path [$path]. Confirm? (y/n)"
	confirm_execution "git commit $path"
	echo -e "\nPush will use path [$path]. Confirm? (y/n)"
	confirm_execution "git push $path"
}


git_menu() {
local default_path="."
new_menu "
Git Menu
1) Check diff
2) Commit and push
" "check_diff $default_path" "commit_push $default_path"
}


build_iso() {
echo asd
# # 	flake_uri=""
# # 	flake_cfg=""
# # 	nix build "$flake_uri"#nixosConfigurations."$flake_cfg".config.system.build.isoImage
}


burn_iso() {
echo asd
# #           # lsblk --noheadings --nodeps
# #           # read "dev?Enter the removable device path without /dev (e.g. sdc): "
# #           # read -s "confirmed?Are you sure you want to burn the iso into /dev/$dev? Confirm (RETURN) or abort (CTRL+C)..."
# #           # echo
# #           # wipefs "/dev/$dev"
# #           # cp "result/iso/nixos-*.iso /dev/$dev"
# #           # sync "/dev/$dev"
# #           # echo "NixOS ISO burned into /dev/$dev"
}


iso_menu() {
new_menu "
ISO images Menu
1) Build from flake
2) Burn into disk
" build_iso burn_iso
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
