b_name="${0##*/}"

patch-hw-config() {
	sed -i $'/fsType = "ntfs3"/a\\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix
}

config() {
	config_active=true
	while [ "$config_active" = true ]
	do
		echo -e "\nConfiguration:\n"
		echo -e "1) Test temporary generation"
		echo -e "2) New generation, swap now"
		echo -e "3) New generation, swap after boot"
		echo -e "4) Generate patched hardware configuration"
		echo -e "q) Quit\n"
		IFS=' ' read -rp "Options: " -a input
		for option in "${input[@]}"
		do
		case "$option" in
			1)
				echo -e "Created new generation (swapped after boot)"
				# "os.cfg-new-build-reboot" = "os.prepare-build && sudo nixos-rebuild boot --impure --flake ";
				;;
			2)
				echo -e "Swapped to test generation"
				;;
			3)
				echo -e "Created new generation and swapped to it"
				# "os.cfg-new-build-no-reboot" = "os.prepare-build && sudo nixos-rebuild switch --impure --flake .";
				;;
			4)
				echo -e "Patched hardware configuration"
				# "os.cfg-build-test" = "os.prepare-build && sudo nixos-rebuild test --impure --flake ."
				;;
			q) config_active=false;;
			*) echo -e "Invalid option '$option', usage: option1 option2 (...)\n";;
		esac
		done
	done
}

flakes() {
	echo -e "\nWhich flake directory do you want to manage?"
	echo -e "How do you want to manage the flake?"
	echo -e "1) Format .nix files"
	echo -e "2) Update lock file\n"
}

store() {
	echo -e "\nHow do you want to manipulate the nix store"
	echo -e "1) Optimise the store"
	echo -e "2) Collect garbage"
# "os.storage-optimise-partial" = "nix-collect-garbage && sudo nix-collect-garbage && nix store optimise";
	echo -e "3) Collect garbage and generations\n"
# "os.storage-optimise-full" = "nix-collect-garbage -d && sudo nix-collect-garbage -d && nix store optimise";
}

git() {
	echo -e "\nWhich git repository do you want to manage?"
	echo -e "How do you want to manage the git repository?"
	echo -e "1) See diff"
# "g.diff" = "nix fmt && git diff | bat";
	echo -e "2) Add files"
	echo -e "3) Commit changes"
	echo -e "4) Push to remote\n"
# "g.push-after-commit" = "git add -A && nix fmt && git add -A && git commit && git push";
}


iso() {
	echo -e "\nHow do you want to manipulate ISO images?"
	echo -e "1) Build an ISO using a flake"
# build-iso() {
# 	flake_uri=""
# 	flake_cfg=""
# 	nix build "$flake_uri"#nixosConfigurations."$flake_cfg".config.system.build.isoImage
# }
# burn-iso() {
#           # lsblk --noheadings --nodeps
#           # read "dev?Enter the removable device path without /dev (e.g. sdc): "
#           # read -s "confirmed?Are you sure you want to burn the iso into /dev/$dev? Confirm (RETURN) or abort (CTRL+C)..."
#           # echo
#           # wipefs "/dev/$dev"
#           # cp "result/iso/nixos-*.iso /dev/$dev"
#           # sync "/dev/$dev"
#           # echo "NixOS ISO burned into /dev/$dev"
# }
	echo -e "2) Burn an ISO into a removable device\n"
# "tools.burn-new-minimal-iso" = "build-minimal-iso && burn-iso";
}

main_active=true
while [ "$main_active" = true ]
do
	echo -e "INFO: Some options require to start this program with elevated permissions (e.g. sudo $b_name)"
	echo -e "\nNixOS manager:"
	echo -e "1) Configuration"
	echo -e "2) Flakes"
	echo -e "3) Nix store"
	echo -e "4) Git"
	echo -e "5) ISO images"
	echo -e "q) Quit\n"
	IFS=' ' read -rp "Options: " -a input
	for option in "${input[@]}"
	do
		case "$option" in
			1) config ;;
			2) flakes ;;
			3) store ;;
			4) git ;;
			5) iso ;;
			q) main_active=false;;
			*) echo -e "Invalid option '$option', usage: option1 option2 (...)\n";;
		esac
	done
done
