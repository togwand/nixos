help() {
cat << EOF
DESCRIPTION
 My program for NixOS installation

USAGE
 Press a key to execute a keybind or the displayed menu option

KEYBINDINGS
 h, H
 		Read about the program usage in a pager screen
 m, M
 		Print a manual installation guide and exit
 q, Q
		Exit the program
EOF
}

manual_guide() {
clear
cat << EOF
MANUAL INSTALLATION
 Create partition table on disk (e.g. $ sudo cgdisk /dev/sda), no swap partition needed if swap file in custom config
 Format partitions (e.g. mkfs.* ...)
 Mount formatted partitions
 $ sudo nixos-install --flake your_flake_uri#your_config_name
 $ sudo nixos-enter --root /mnt -c 'passwd your_user_name'
 Reboot
EOF
exit
}

status() {
cat << EOF
NIXOS INSTALLER
 Press 'h' for help

STATUS
 Location: $PWD
EOF
}

menu() {
cat << EOF

MENU
 1) Install NixOS from a flake
EOF
}

flake_options() {
cat << EOF

OPTIONS
 1) Clone a remote git flake repository
 2) Use an existing local or remote flake (flake-uri)
EOF
}

install_nixos_flake() {
	local flake_uri config_name
	echo "How do you want to get the installation flake?"
	flake_options
	while true
	do
		read -rsn 1 flake_option
		case $flake_option in 
			1)
				sudo -u nixos ranger
				read -rei "https://github.com/togwand/nixos-config" -p "git repo to clone: " repo
				read -rei "experimental" -p "git branch to use: " branch
				read -rei "/tmp" -p "clone root directory: " clone_path
				read -rei "nixos-config" -p "clone repo name: " clone_name
				flake_uri="$clone_path/$clone_name"
				sudo -u nixos git clone "$repo" "$flake_uri"
				cd "$flake_uri" || true
				sudo -u nixos git switch "$branch"
				echo "Edit flake before installing? (y/n)"
				read -rsn 1 edit_answer
				case $edit_answer in 
					y) sudo -u nixos ranger;;
				esac
				echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
				echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
				echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
				read -rei "stale" -p "config name to install: " config_name
				break;;
			2)
				read -rei "github:togwand/nixos-config/experimental" -p "flake uri: " flake_uri
				echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
				echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
				echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
				read -rei "stale" -p "config name to install: " config_name
				break ;;
			*)  continue;;
		esac
	done
	disko -m disko -f "$flake_uri#$config_name"
	nixos-install --root /mnt --no-root-password --flake "$flake_uri#$config_name"
	while true
	do
	echo "All Users:"
	nixos-enter --root /mnt -c "sudo passwd -Sa | grep -v nixbld | grep -v messagebus | grep -v polkituser | grep -v systemd- | grep -v nm-openvpn | grep -v rtkit | grep -v nm-iodine | grep -v nobody | grep -v nscd | grep -Eo '^[^ ]+'"
	echo "Please enter a user to give password to"
	read -rei "togwand" -p "user: " user
	nixos-enter --root /mnt -c "sudo passwd $user"
	echo "Users with passwords:"
	nixos-enter --root /mnt -c "sudo passwd -Sa | grep P | grep -Eo '^[^ ]+'"
	echo "Stop giving passwords to users? (y/n)"
	read -rsn 1 end_passwd
	case $end_passwd in
		y) break;;
	    *) continue;;
	esac
	done
	echo "Users with passwords:"
	nixos-enter --root /mnt -c "sudo passwd -Sa | grep P | grep -Eo '^[^ ]+'"
	echo "Please enter a user to copy the used flake to"
	read -rei "togwand" -p "user: " user
	local git_path="/mnt/home/$user/git" make_path
	case $flake_option in 
		1)
			make_path="$git_path/$clone_name"
			sudo -u nixos mkdir -p "$make_path"
			sudo -u nixos cp -r "$flake_uri" "$git_path";;
		2)
			read -rei "nixos-config" -p "name of the directory: " directory_name
			make_path="$git_path/$directory_name"
			sudo -u nixos mkdir -p "$make_path"
			if ! sudo -u nixos cp -r "$flake_uri" "$git_path"
			then "The flake uri you specified was a remote one, so it wasn't copied"
			fi
	esac
	echo "Installation from flake finished. Press enter to reboot"
	read -rs reboot_input
	case $reboot_input in 
		*) systemctl reboot;;
	esac
}

show_interface() {
	if $refresh
	then 
		refresh=false
		clear
		status
		menu
	fi
}

if [ $EUID != 0 ]
then
	bin_name="${0##*/}"
	echo "This program options require root permissions"
	echo "Please restart it with elevated permissions (e.g. sudo $bin_name)"
	exit
fi
refresh=true
while true
do
	show_interface
	read -rsn 1 key
	case $key in
		1) install_nixos_flake;;
		h|H) help|less;;
		m|M) manual_guide;;
		q|Q) clear && exit;;
	esac
done
