{ lib, ... }: {
  imports = [
    ./rice
    ./tools
  ];
  options = {
    derivations = {
    rice = {
	arknights-grub.enable = lib.mkEnableOption "";
	crosscode-grub.enable = lib.mkEnableOption "";
	};
	tools = {
	cadoras.enable = lib.mkEnableOption "";
	goris.enable = lib.mkEnableOption "";
	};
  };
  };
}
