bin_name="${0##*/}"

documentation() {
cat << EOF
[ DOCUMENTATION ]
* Inputting anything besides nothing or one of the options gets you here
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

q) Quit
* Exits the active menu (or the program if it's the main menu)

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
* Patches it for mounted ntfs3 partitions
* Discards configuration.nix

2) Rebuild configuration - REQUIRES ELEVATED PERMISSIONS
* Asks user for a build type and one path to a flake
* It outputs a preview from the inputs
* The user needs to type 'yes' to actually rebuild
* Any other input will return the user to the configuration menu


[ STORE MENU ]

1) Delete unreachable files - WORKS DIFFERENTLY WITH AND WITHOUT ROOT PERMISSIONS
* Prompts to delete old generations along garbage files, or just the files
* This option reads the current user profile, and deletes the files of that profile

2) Replace identical with links
* Runs "nix store optimise"
EOF
}


new_menu() {
	local txt=$1
	local is_open=true
	while [ "$is_open" = true ]
	do
		if [ $EUID = 0 ]
		then
			echo -e "\n* Running with root privileges"
		fi
		echo -e "\nGeneral"
		echo -e "d) Documentation"
		echo -e "r) Reboot"
		echo -e "q) Quit"
		echo -e "$txt"
		IFS=' ' read -rp "Input: " -a input
		for option in "${input[@]}"
		do
			case "$option" in
				d) documentation|less;;r) systemctl reboot;;q) is_open=false;;
				1)$2;;2)$3;;3)$4;;4)$5;;5)$6;;6)$7;;7)$8;;8)$9;;9)${10};;10)${11};;
				?) documentation|less;;
				*) documentation|less
			esac
		done
	done
}


patch_hw() {
	if 
		nixos-generate-config
		sed -i $'/fsType = "ntfs3"/a\\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix
		rm /etc/nixos/configuration.nix
	then echo "Patched hardware config successfully!"
	else echo "There was an error patching hardware config..."
	fi
}


rebuild_config() {
	if
		local confirmation=""
		echo -e "\nValid types = [test, boot, switch]\n"
		read -rp "Type? " type
		echo -e "\nFlake path examples"
		echo -e "* Flake in github: github:repo/owner/flake/branch#config"
		echo -e "* Relative directory flake: ./flake-rel-path#config\n"
		read -rp "Flake path? " path
		echo -e "\nConfiguration will be rebuilt with type '$type' and flake path '$path'"
		echo -e "Type 'yes' to confirm the system rebuild\n"
		read -rp "Confirm? " confirmation
		if [ "$confirmation" = "yes" ]
		then nixos-rebuild "$type" --impure --flake "$path"
		else return
		fi
	then echo "Configuration has been rebuilt with type '$type' and flake path '$path'"
	else echo "There was an error rebuilding the configuration..."
	fi
}


config_menu() {
new_menu "
Configuration Menu
1) Patch hardware file
2) Rebuild configuration
" patch_hw rebuild_config
}


# store_menu() {
# 	echo -e "\nHow do you want to manipulate the nix store"
# 	echo -e "2) Collect garbage"
# # "os.storage-optimise-partial" = "nix-collect-garbage && sudo nix-collect-garbage && nix store optimise";
# 	echo -e "3) Collect garbage and generations\n"
# # "os.storage-optimise-full" = "nix-collect-garbage -d && sudo nix-collect-garbage -d && nix store optimise";
# }

delete_unreachable() {
	local include_gens=""
	if
		echo -e "\nType 'yes' to delete old generations along with files\n"
		read -rp "Include generations? " include_gens
		if [ "$include_gens" = "yes" ]
		then nix-collect-garbage -d 
		else nix-collect-garbage
		fi
	then 
		if [ "$include_gens" = "yes" ]
		then echo "Deleted unreachable files and old generationss of user ID '$EUID'"
		else echo "Deleted unreachable files of user ID '$EUID'"
		fi
	else echo "There was an error deleting unreachable files..."
	fi
}


store_menu() {
new_menu "
Store Menu
1) Delete unreachable files
2) Replace identical with links
" delete_unreachable "nix store optimise"
}


# flake_menu() {
# 	echo -e "\nWhich flake directory do you want to manage?"
# 	echo -e "How do you want to manage the flake?"
# 	echo -e "1) Format .nix files"
# 	echo -e "2) Update lock file\n"
# }
flakes_menu() {
new_menu "
TEST Menu
1)
2)
3) 
" 1 2 3
}


# git_menu() {
# 	echo -e "\nWhich git repository do you want to manage?"
# 	echo -e "How do you want to manage the git repository?"
# 	echo -e "1) See diff"
# # "g.diff" = "nix fmt && git diff | bat";
# 	echo -e "2) Add files"
# 	echo -e "3) Commit changes"
# 	echo -e "4) Push to remote\n"
# # "g.push-after-commit" = "git add -A && nix fmt && git add -A && git commit && git push";
# }
git_menu() {
new_menu "
TEST Menu
1)
2)
3) 
" 1 2 3
}


# iso_menu() {
# 	echo -e "\nHow do you want to manipulate ISO images?"
# 	echo -e "1) Build an ISO using a flake"
# # build-iso() {
# # 	flake_uri=""
# # 	flake_cfg=""
# # 	nix build "$flake_uri"#nixosConfigurations."$flake_cfg".config.system.build.isoImage
# # }
# # burn-iso() {
# #           # lsblk --noheadings --nodeps
# #           # read "dev?Enter the removable device path without /dev (e.g. sdc): "
# #           # read -s "confirmed?Are you sure you want to burn the iso into /dev/$dev? Confirm (RETURN) or abort (CTRL+C)..."
# #           # echo
# #           # wipefs "/dev/$dev"
# #           # cp "result/iso/nixos-*.iso /dev/$dev"
# #           # sync "/dev/$dev"
# #           # echo "NixOS ISO burned into /dev/$dev"
# # }
# 	echo -e "2) Burn an ISO into a removable device\n"
# # "tools.burn-new-minimal-iso" = "build-minimal-iso && burn-iso";
# }
iso_menu() {
new_menu "
TEST Menu
1)
2)
3) 
" 1 2 3
}


main_menu() {
new_menu "
Main Menu
1) Configuration
2) Nix store
3) Flakes
4) Git
5) ISO images
" config_menu store_menu flakes_menu git_menu iso_menu
}


# SCRIPT START POINT
main_menu
