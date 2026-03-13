{ lib, ... }:

{
  # 🛠️ HELPER: myKernelPackages
  # Asigură compatibilitatea între cel mai nou kernel, ZFS și modulele NVIDIA.
  # Returnează pachetul de kernel optim.
  myKernelPackages = pkgs:
    let
      zfs_version = pkgs.zfs.latestCompatibleLinuxPackages.kernel.version;
      latest_kernel_version = pkgs.linuxPackages_latest.kernel.version;
      preferred_packages =
        if lib.versionAtLeast zfs_version latest_kernel_version
        then pkgs.linuxPackages_latest
        else pkgs.zfs.latestCompatibleLinuxPackages;
    in
      preferred_packages;
}
