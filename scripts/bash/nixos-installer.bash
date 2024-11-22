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
 $ sudo nixos-install --impure --flake your_flake_uri#your_config_name
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
 1) Clone a repository
 2) Guided installation
 3) Flake installation (disko)
EOF
}

clone_repo() {
	read -rei "https://github.com/togwand/nixos-config" -p "url to clone: " cloned_repo
	read -rei "/home/clones/cloned_repo" -p "clone to: " destination
	git clone "$cloned_repo" "$destination"
}

confirm_prompt() {
	echo "$1"
	echo "Confirm by entering \"yes\". Anything else will exit this option (previous changes will remain)"
	read -rei "$3" -p "$2 " confirmation
	if [ "$confirmation" = yes ]
	then return 0
	else return 1
	fi
}

test_device() {
	if test -b /dev/"$1"
	then
		if lsblk -ndo type /dev/"$1" | grep -qF part
		then 
			echo "this is a partition, not a disk"
			return 1
		fi
	else 
		echo "this is not a valid storage device"
		return 1
	fi
	umount /dev/"$1"?*
}

install-patch-hw() {
	echo "Patch hardware configuration for ntfs drives? (yes/no)"
	read -rei "yes" -p "answer: " answer
	if [ "$answer" = "yes" ]
	then 
		blkid|grep ntfs
		lsblk
		read -re -p "device which has ntfs partitions: " ntfs_drive
		read -re -p "partition numbers to mount: " -a ntfs_partitions
		for partition in "${ntfs_partitions[@]}"
		do
			if df -H | grep /dev/"$ntfs_drive$partition"
			then
				echo "unmounting previously mounted ntfs partition dev/$ntfs_drive/$partition"
				umount /dev/"$ntfs_drive$partition"
			fi
			read -rei "/mnt/ntfs-$partition" -p "partition #$partition mountpoint: " part_mountpoint
			if ! ls "$part_mountpoint"
			then mkdir -p "$part_mountpoint"
			fi
			mount -t ntfs3 /dev/"$ntfs_drive$partition" "$part_mountpoint"
		done
	fi
	nixos-generate-config --root /mnt --dir /etc/nixos
	sed -i $'/fsType = "ntfs3"/a\\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix
	rm /etc/nixos/configuration.nix
}

guided_install() {
	read -re -p "device: " nixos_disk
	if ! confirm_prompt "/dev/$nixos_disk will be tested for validity and all partitions unmounted" "continue? " "no"
	then return 1
	else 
		if ! test_device "$nixos_disk"
		then return 1
		fi
	fi
	echo "Please make a partition table with 2 spots, the first one for the esp, the second one for the root?"
	if ! confirm_prompt "/dev/$nixos_disk will be partitioned and all data lost" "continue? " "no"
	then return 1
	fi
	cgdisk /dev/"$nixos_disk"
	echo "Did you make a partition table with 2 spots, the first one for the esp, the second one for the root?"
	if ! confirm_prompt "/dev/$nixos_disk will be formatted and all data lost" "continue? " "no"
	then return 1
	fi
	mkfs.fat -F 32 /dev/"$nixos_disk"1
	mkfs.ext4 /dev/"$nixos_disk"2
	mount /dev/"$nixos_disk"2 /mnt
	mkdir -p /mnt/boot
	mount /dev/"$nixos_disk"1 /mnt/boot
	install-patch-hw
	read -rei "github:togwand/nixos-config" -p "flake uri: " flake_uri
	read -rei "stale" -p "config name: " config_name
	echo "flake installation with $flake_uri#$config_name"
	nixos-install --root /mnt --impure --flake "$flake_uri"#"$config_name"
	if ! confirm_prompt "You are about to give an user a password" "continue? " "yes"
	then return 1
	else
		read -rei "togwand" -p "user to be granted password: " user
		nixos-enter --root /mnt -c "passwd $user"
	fi
}

flake_install() {
	# Will need disko for this one
	# See vimjoyer impermanence video and learn to use disko to make a disko config to install nixos with
	# Slightly modify an existing file with disko using sed or something inside this function?
	read -rei "github:togwand/nixos-config" -p "flake uri: " flake_uri
	read -rei "stale" -p "config name: " config_name
	echo "Full flake input: $flake_uri#$config_name"
	echo "WIP, in the future you will be able to install with a flake+disko with your input"
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

nicer_bind() {
	local alias="$1"
	case $1 in
		clone_repo) alias="cloning";;
		guided_install) alias="guided installation";;
		flake_install) alias="flake+disko installation";;
	esac
	if $1
	then echo "$alias ended, next!"
	else echo "$alias ended with an error"
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
		1) nicer_bind clone_repo;;
		2) nicer_bind guided_install;;
		3) nicer_bind flake_install;;
		h|H) help|less;;
		m|M) manual_guide;;
		q|Q) clear && exit;;
	esac
done
