{ config, pkgs, ... }:

{
  imports =
    [ # default
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nixos_#3839j"; # hostname to be found on network like smb 
  # networking.wireless.enable = true;  # enable wireless wpa_supplicant.

  # Configure o proxy de rede, se necessário
  # networking.proxy.default = "http://usuario:senha@proxy:porta/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Habilitar rede
  networking.networkmanager.enable = true;

  # Defina seu fuso horário.
  time.timeZone = "America/Sao_Paulo";

  # Selecione as propriedades de internacionalização.
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

  # Configurar layout de teclado no X11
  services.xserver.layout = "br";
  services.xserver.xkbVariant = "";

  # Configurar layout de teclado no console
  console.keyMap = "br-abnt2";

  # Habilitar CUPS para imprimir documentos.
  services.printing.enable = true;

  # Habilitar som com pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Se você quiser usar aplicativos JACK, descomente isso
    # jack.enable = true;

    # media-session.enable = true;
  };

  # suport  touchpad
  # services.xserver.libinput.enable = true;

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

  # Instalar firefox.
  programs.firefox.enable = false;

  # Permitir pacotes não livres
  nixpkgs.config.allowUnfree = true;


  nixpkgs.config.nvidia.acceptLicense = true;
  # NVIDIA driver
  services.xserver.videoDrivers = [ "nvidia" ];

  # Habilitar decodificação de vídeo acelerada por hardware para alguns aplicativos
  hardware.opengl.enable = true;

  hardware.nvidia = {

    # O modesetting é necessário.
    modesetting.enable = true;

    # Gerenciamento de energia Nvidia. Experimental, e pode fazer com que o modo de espera/suspensão falhe.
    # Habilite isso se você tiver problemas de corrupção gráfica ou travamentos de aplicativos após acordar
    # do modo de espera. Isso corrige ao salvar toda a memória VRAM em /tmp/ 
    # em vez de apenas o essencial.
    powerManagement.enable = false;

    # Gerenciamento de energia detalhado. Desliga a GPU quando não está em uso.
    # Experimental e só funciona em GPUs Nvidia modernas (Turing ou mais recentes).
    powerManagement.finegrained = false;

    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Disponível apenas a partir do driver 515.43.04+
    open = false;

    # nvidia-settings
    nvidiaSettings = true;

    # here i use 470 because my gpu is an old tesla gt 730 low profile
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  # Liste os pacotes instalados no perfil do sistema. Para buscar, execute:
  # $ nix search wget
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
    unrar
    python3
    bluez
    git
    bluez-alsa
    gnome.ghex
    gnome.gnome-sudoku
    mesa
    libglvnd
    libglvnd.dev
    mesa
  ];

  # Alguns programas precisam de wrappers SUID, podem ser configurados ainda mais ou são
  # iniciados em sessões de usuário.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Liste os serviços que você deseja habilitar:

  # Habilitar o daemon OpenSSH.
  # services.openssh.enable = true;

  # firewall ports
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Ou desabilitar o firewall completamente.
  # networking.firewall.enable = false;

  #set nixos version
  system.stateVersion = "24.05";

services.xserver.displayManager.sddm.enable = true;
services.xserver.desktopManager.plasma5.enable = true;
services.xserver.enable = true;
}
