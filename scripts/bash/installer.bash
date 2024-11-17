list-devices() {
	echo -e "\nDISKS AND PARTITIONS"
	lsblk --noheadings
}

confirmation_info() {
	echo -e "Press 'y' to confirm, or any other key to cancel"
}

continue_or_exit() {
	echo -e "\nDo you want to continue?"
	confirmation_info
	read -r -s -n 1 response
	response=${response,,}
	if [[ "$response" =~ ^(y)$ ]]
	then return
	else exit 1
	fi
}

confirmation=false
while [ "$confirmation" = false ]
do
	list-devices 
	echo -e "\nWhich disk do you want to install NixOS in? (CTRL+C to abort)"
	read -r new_nixos
	if test -b /dev/"$new_nixos"
	then
		if lsblk -ndo type /dev/"$new_nixos" | grep -qF part
		then
			echo -e "\nThis is a partition, not a disk"
			continue
		fi
	else
		echo -e "\nThis is not a valid storage device"
		continue
	fi
	echo -e "\nAre you sure you want to create a partition table and format /dev/$new_nixos to install NixOS?"
	confirmation_info
	read -r -s -n 1 confirm_or_not
	confirm_or_not=${confirm_or_not,,}
	if [[ "$confirm_or_not" =~ ^(y)$ ]]
	then confirmation=true
	else continue_or_exit
	fi
done

echo -e "\nMounting: $new_nixos ~> /mnt"
mount "/dev/$new_nixos" /mnt 

list-devices
