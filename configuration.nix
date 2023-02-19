{ config, pkgs, ... }:

let
  user = "raphaelw";
  userFullName = "Raphaël Weis";
in  
{
  imports =
    [
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

  users.users.${user} = {
    description = "${userFullName}";
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
    shell = pkgs.zsh;
  };
 
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
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
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
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

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Meslo" ]; })
    
  ];
 
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.dnsname.enable = true;
    };
  };

  programs.dconf.enable = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      git
      gh
      firefox
      virt-manager
      distrobox
    ];
    shells = with pkgs; [ zsh ];
  };

  #nix = {
  #  package = pkgs.nixFlakes;
  #  extraOptions = "experimental-features = nix-command flakes";
  #};
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "22.11";
}
