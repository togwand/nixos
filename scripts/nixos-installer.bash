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

KNOWN ISSUES
 You can "queue" options before the current one ends
EOF
}

manual_guide() {
clear
cat << EOF
MANUAL INSTALLATION
 Create partition table on disk (e.g. $ sudo cgdisk /dev/sda), no swap partition needed if swap file in custom config
 Format partitions (e.g. mkfs.* ...)
 Mount formatted partitions
 $ sudo nixos-generate-config --root /mnt 
 $ sudo cp /mnt/etc/nixos /etc/nixos
 $ sudo nixos-install --flake your_flake_uri#your_config_name
 $ sudo nixos-enter --root /mnt -c 'passwd your_user_name'
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
 1) Installation
EOF
}

install() {
	echo "You need to specify a flake and a configuration name before the installation"
	echo "Do you want to clone a flake repository before that (y/n)?"
	read -rsn 1 clone_or_not
	case $clone_or_not in 
		y)
			read -rei "https://github.com/togwand/nixos-config" -p "url to clone: " cloned_repo
			read -rei "/home/guided_install/cloned_flake" -p "clone to: " destination
			git clone "$cloned_repo" "$destination"
			;;
		*) return 1
	esac
	read -rei "/home/guided_install/cloned_flake" -p "flake uri: " flake_uri
	read -rei "stale" -p "config name: " config_name
	lsblk
	echo "Enter the disk you will be using to install NixOS"
	read -rei "/dev/sda" -p "nixos disk: " nixos_disk
	echo "$nixos_disk will be tested and wiped"
	read -rei "no" -p "continue? (yes/no) " test_and_wipe
	if [ "$test_and_wipe" != "yes" ]
	then return 1
	fi
	wipefs -af "$nixos_disk"
	blkdiscard -f "$nixos_disk"
	echo "Make a table with 2 partitions:
	 #1 100-500 MiB of space, type ef00 (the \"esp\")
	 #2 remaining space, default type (fs root partition)"
	read -rsn 1 -p "Press any key to continue " test_and_wipe
	cgdisk "$nixos_disk"
	echo "Formatting and mounting partitions"
	mkfs.fat -F 32 "$nixos_disk"1
	mkfs.ext4 "$nixos_disk"2
	mount "$nixos_disk"2 /mnt
	mkdir -p /mnt/boot
	mount "$nixos_disk"1 /mnt/boot
	# install-patch-hw
	# disko command to mount stuff in the disko file
	nixos-install --root /mnt --flake "$flake_uri"#"$config_name"
	read -rei "togwand" -p "user without password: " user
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
		1) clone_flake;;
		2) install;;
		h|H) help|less;;
		m|M) manual_guide;;
		q|Q) clear && exit;;
	esac
done
