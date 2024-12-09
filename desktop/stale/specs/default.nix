{
  imports = [
    ./display
    ./kernel
  ];
  config = {
    generic.intel.enable = true;
    generic.nvidia.enable = true;
  };
}
