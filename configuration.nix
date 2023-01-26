{ config, pkgs, lib, nixpkgsPath, ... }:
let
    mypkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/ee01de29d2f58d56b1be4ae24c24bd91c5380cea.tar.gz";
    }) { crossSystem = { system = "armv6l-linux"; };};
  
    myPkg = mypkgs.fish;
    myhx = mypkgs.helix;
    mykernel = mypkgs.linuxKernel.kernels.linux_rpi1;
in
{
  imports = [
    (nixpkgsPath + "/nixos/modules/profiles/minimal.nix")
#    (nixpkgsPath + "/nixos/modules/profiles/headless.nix")
    (./installation-device.nix)
  ];

  disabledModules =
    [ (nixpkgsPath + "/nixos/modules/profiles/all-hardware.nix")
      (nixpkgsPath + "nixos/modules/profiles/base.nix")
    ];

  # cifs-utils fails to cross-compile
  # Let's simplify this by removing all unneeded filesystems from the image.
  boot.supportedFilesystems = lib.mkForce [ "vfat" ];
  boot.initrd.includeDefaultModules = false;
  boot.initrd.kernelModules = [ "ext4" "vfat" ];

  boot.kernelPackages = lib.mkDefault mykernel; #lib.mkDefault pkgs.linuxKernel.kernels.linux_rpi1;
  environment.systemPackages = [ myhx ];
  environment.defaultPackages = [];
  xdg.icons.enable  = false;
  xdg.mime.enable   = false;
  xdg.sounds.enable = false;
  # programs.fish.enable = true;
  users.users.razvan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  users.defaultUserShell = myPkg;
}
