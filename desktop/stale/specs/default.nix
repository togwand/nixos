{
  imports = [
    ./display
    ./kernel
  ];
  config = {
    nvidia.enable = true;
    intel.enable = true;
  };
}
