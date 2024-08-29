{ config, pkgs, ... }:

{
  imports =
    [ # default
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Valid hostname
  networking.hostName = "nixos-3839j"; # Change this to a valid hostname

  # Enable NTFS support at boot
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable network manager
  networking.networkmanager.enable = true;

  # Set timezone
  time.timeZone = "America/Sao_Paulo";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Keyboard layout
  services.xserver.layout = "br";
  services.xserver.xkbVariant = "";
  console.keyMap = "br-abnt2";

  # Enable CUPS
  services.printing.enable = true;

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User configuration
  users.users.metaorior = {
    isNormalUser = true;
    description = "metaorior";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      xfce.xfce4-terminal
    ];
  };

  services.xserver.displayManager.lightdm.autoLogin.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.user = "metaorior";

  # Optional Firefox installation
  programs.firefox.enable = false;


  # NVIDIA driver configuration
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  # System packages and Python configuration to allow pip usage
  environment.systemPackages = with pkgs; [
    unzip
    zip
    torrential
    bluez
    transmission
    kate
    google-chrome
    vlc
    libreoffice
    gzip
    gimp
    htop
    neofetch
    handbrake
    libgcc
    virtualbox
    wineWowPackages.full
    blueman
    jdk22
    prismlauncher
    rar
    gedit
    unrar
    python3
    python312Packages.pip  # Ensure pip is included
    git
    gnome.ghex
    gnome.gnome-sudoku
    mesa
    libglvnd
    (python3.withPackages (ps: with ps; [ pip moviepy ]))  # Python with pip and MoviePy
  ];

  # Nix configuration to bypass restrictions (use with caution)
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;  # Allow broken packages if necessary
    allowInsecure = true;  # Allows the use of insecure packages
  };

  # Enable pip to work outside of virtual environments
  environment.variables.PIP_REQUIRE_VIRTUALENV = "false";

  # Enable SDDM and Plasma5
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.enable = true;

  # Set NixOS version
  system.stateVersion = "24.05";
}
