{ pkgs, lib, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    timeout = 10;
    };
  };
  
  services = {
    xserver = {
      enable = true;
      displayManager = {
        sddm.enable = true;
        defaultSession = "gnome";
      };
      desktopManager.gnome.enable = true;
      libinput.enable = true;
      layout = "us";
      xkbVariant = "intl";
    };
    printing.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    bluetooth.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.dnsname.enable = true;
    };
  };

  programs.dconf.enable = true; #delete if gnome is no longer in use

  environment = {
    systemPackages = with pkgs; [
      vim
      git
      gh
      firefox
      virt-manager
      distrobox
    ];
  };
}