{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Valid hostname
  networking.hostName = "nixos-3839j"; 

services.mysql = {
  enable = true;
  package = pkgs.mysql;


};


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
hardware.opengl.driSupport32Bit = true;
  hardware.opengl.driSupport = true;


  # Audio setup with PipeWire
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
    extraGroups = [ "networkmanager" "wheel" "adbusers" "kvm" ]; # Added adbusers and kvm for Android and Emulator


    packages = with pkgs; [
      xfce.xfce4-terminal
    ];
  };

  # Optional auto-login setup
  services.xserver.displayManager.lightdm.autoLogin.enable = true;
  services.xserver.displayManager.lightdm.autoLogin.user = "metaorior";

  # Optional Firefox installation
  programs.firefox.enable = false;
networking.firewall.enable = false;

  # NVIDIA driver configuration
    nixpkgs.config.android_sdk.accept_license = true;
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
    gcc
    dxvk
    volk
vulkan-headers
gpt4all
gst_all_1.gstreamer
tor-browser
   libreoffice
    gzip
    gimp
    htop
    llvmPackages_12.libcxx
    wireshark
    libcxx

    neofetch
    handbrake
    xorg_sys_opengl
    zenith-nvidia
    libgcc
    android-tools
    obs-studio
    virtualbox
    wget
    ffmpeg-full
    handbrake
    autoconf
    gnumake
    automake
    wine
    ninja
    driversi686Linux.libvdpau-va-gl
    driversi686Linux.vaapiVdpau
    driversi686Linux.mesa
    vulkan-volk
    sdkmanager
    vulkan-utility-libraries
    winetricks
    wineWowPackages.full
    blueman
    steam-run
    cmake
    nvidia-vaapi-driver
    jdk19
        android-tools
    androidenv.androidPkgs_9_0.androidsdk    # Add Android SDK package
    androidenv.androidPkgs_9_0.platform-tools # Add platform tools
    vulkan-tools
    prismlauncher
    libgcc
    python312Packages.tkinter
    rar
    gedit
    flutter
    dbeaver-bin
    libglvnd
    unrar
    mysql-workbench
        lutris
    pipx
    cabextract
    python3Full
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
  
    # Enable adb for unprivileged users
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];


  # Enable pip to work outside of virtual environments
  environment.variables.PIP_REQUIRE_VIRTUALENV = "false";

  # Enable SDDM and Plasma5
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.enable = true;

  # Set NixOS version
  system.stateVersion = "24.05";
}
