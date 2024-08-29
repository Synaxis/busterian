{ config, lib, pkgs, ... }:

{
  # Basic System Configuration
  imports = [
    # Include the results of the hardware scan for automatic configuration
    ./hardware-configuration.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable OpenGL for the system
  hardware.opengl.enable = true;

  # Enable the X server and configure video drivers
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" "intel" ]; # Include Intel and NVIDIA drivers
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.autoLogin.user = "meta"; # Optional: auto-login

  # Enable NVIDIA Prime
  hardware.nvidia = {
    modesetting.enable = true;  # Required for proper mode setting
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;  # Use NVIDIA's proprietary drivers
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;  # Specify the driver version if needed

    prime = {
      # Configure Bus IDs for Intel and NVIDIA GPUs
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      # Configure Prime modes
      offload.enable = true;  # Enable offload mode
      offload.enableOffloadCmd = true;  # Enable offload command

      # Uncomment to use sync mode instead of offload mode
      # sync.enable = true;

      # Uncomment to use reverse sync mode if needed
      # reverseSync.enable = true;
    };
  };

  # System packages
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
    gzipv
    gimp
    htop
    neofetch
    handbrake
    libgcc
    virtualbox
    wineWowPackages.full
    blueman
    jdk22
python312Packages.pip
    prismlauncher
    rar
gedit
    unrar
    python3
    git
    gnome.ghex
    gnome.gnome-sudoku
    mesa
    libglvnd
  ];

  # Network configuration
  networking.networkmanager.enable = true;  # Use NetworkManager for managing network connections

  # Enable the firewall with default settings
  networking.firewall.enable = true;

  # System locale and timezone settings
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "America/New_York";

  # Enable SSH service (optional)
  services.openssh.enable = true;

  # Use GRUB bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";  # Use UEFI mode, no device specification needed
  boot.loader.grub.efiSupport = true;  # Enable EFI support
  boot.loader.efi.canTouchEfiVariables = true;  # Required for EFI boot management

  # Set system hostname
  networking.hostName = "my-laptop";

  # Configure user accounts
  users.users.meta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # Allow user to use sudo
  };

  # Rebuild the system
  system.stateVersion = "23.05";  # Update this to the current NixOS version

  # Optional: Enable systemd services or other settings as needed
}
