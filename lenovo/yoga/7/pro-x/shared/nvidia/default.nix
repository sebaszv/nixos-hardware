/*
 * #######################################
 * NVIDIA GeForce RTX 3050 Mobile (Ampere)
 * #######################################
 * This enables the NVIDIA driver and PRIME offload mode.
 *
 * This is for the NVIDIA GeForce RTX 3050 Mobile (Ampere) that
 * Lenovo Slim Yoga 7 laptops have.
 *
 * Either `hardware.nvidia.prime.amdgpuBusId` or
 * `hardware.nvidia.prime.intelBusId` should be set for it to work.
 * This is set by the importing `lenovo-yoga-7-14ARH7-nvidia` and
 * `lenovo-yoga-7-14IAH7-nvidia` profiles.
 */
{ lib, ... }:
{
  imports = [
    ## "prime.nix" loads this, aleady:
    # ../../../../common/gpu/nvidia
    ../../../../../common/gpu/nvidia/prime.nix
    ../../../../../common/gpu/nvidia/ampere
  ];

  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];

  hardware = {
    ## Enable the Nvidia card, as well as Prime and Offload:
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:1:0:0";
      };

      powerManagement = {
        enable = true;
        # Doesn't seem to be reliable, yet?
        # finegrained = true
      };
    };
  };
}
