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

install_nixos_flake() {
	read -rei "https://github.com/togwand/nixos-config" -p "flake uri to git clone: " git_repo
	read -rei "/tmp/cloned_repo" -p "clone flake to: " flake_clone
	git clone "$git_repo" "$flake_clone"
	echo "Edit flake clone before installing? (y/n)"
	read -rsn 1 edit_answer
	case $edit_answer in 
		y) sudo -u nixos ranger "$flake_clone";;
	esac
	echo "ATTENTION, this is the POINT OF NO RETURN, if you wish to abort use CTRL+C"
	echo "Configuration name needed for disko and nixos-install"
	read -rei "stale" -p "config name: " config_name
	disko -m disko -f "$flake_clone"#"$config_name"
	nixos-install --root /mnt --flake "$flake_clone"#"$config_name"
	echo "Enter a user name for setting its password and copying the flake clone to the installed filesystem" 
	read -rei "togwand" -p "user: " user
	cp "$flake_clone" /mnt/home/"$user"/installation
	nixos-enter --root /mnt -c "passwd $user"
	systemctl reboot
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
