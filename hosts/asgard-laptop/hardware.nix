{ ... }:

{
  # Minimal hardware configuration placeholder.
  # This should be replaced by 'nixos-generate-config' output on the target machine.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
