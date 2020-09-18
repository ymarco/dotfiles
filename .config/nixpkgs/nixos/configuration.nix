# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.cleanTmpDir = true; # not sure why its not enabled by default
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    # efi.efiSysMountPoint = "/boot";
    # grub.device = "/dev/disk/by-uuid/"; # "nodev"
    # grub.efiSupport = true;
    # grub.enable = true;
    # grub.extraEntriesBeforeNixOS = true;
    # grub.useOSProber = true;
  };

  # lemme do stuff with android
  programs.adb.enable = true;

  # clean up the nix store periodically
  nix = {
    autoOptimiseStore = true;
    daemonNiceLevel = 5;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    trustedUsers = [ "root" "ym" ];
  };


  networking.hostName = "lipad";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Network Manager
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u3u2.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # ZFS
  networking.hostId = "d701c8b6"; # head -c 8 /etc/machine-id
  boot.supportedFilesystems = [ "zfs" ];
  # verify and repair data weekly
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
  # auto-snapshot on subvolumes where com.sun:auto-snapshot is enabled
  services.zfs.autoSnapshot = {
    enable = true;
    # UTC timestamp, otherwise daylight savings create name conflicts
    flags = "-k -p -u";
    frequent = 16; # 15min, default: 4
    hourly = 36; # default: 24
    daily = 7; # default: 7
    weekly = 3; # default: 4
    monthly = 2; # default: 12
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus20";
    keyMap = "dvorak";
  };

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";
  location.latitude = 31.5;
  location.longitude = 34.75;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nvidia-offload
    coreutils wget neovim zip unzip killall binutils-unwrapped lm_sensors gnumake
    # the HTML manual is too slow. Even the manpage one is 110k lines long.
    config.system.build.manual.manpages
    # XeTeX in Hebrew
    (texlive.combine {
      inherit (texlive) scheme-medium collection-langother collection-xetex bidi
        zref babel-hebrew ucs cancel standalone amsmath wrapfig capt-of
        subfigure multirow blindtext xcharter;
    })
  ];
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  environment.shellAliases = {
    nsh = "nix-shell";
    nen = "nix-env";
    nor = "sudo nixos-rebuild";
    econ = "sudo nvim /etc/nixos/configuration.nix";
  };

  # services.transmission.enable = true;
  # services.transmission.settings = {
  #   download-dir = "/home/ym/to-be-sorted/Torrents/";
  #   speed-limit-up = 250;
  #   speed-limit-up-enabled = true;
  # };
  #nixpkgs.config.st = {enable = true; patches = [/home/ym/programs/st/my.diff];};
  
  environment.variables = {
    EDITOR = "emacsclient --alternate-editor=vim";
    TERMINAL = "xst";
    BROWSER = "firefox";
    READER = "evince";
    #PATH = "/opt/emacs-native-comp/bin:/home/ym/.scripts:/home/ym/.scripts/rofi:$PATH";
    PATH = "/home/ym/.scripts:/home/ym/.scripts/rofi:$PATH";
    STARDICT_DATA_DIR = "/home/ym/.local/share/dic";
    MESA_LOADER_DRIVER_OVERRIDE = "iris";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    # pinentryFlavor = "gnome3";
  };
  # So home-manager can set gtk themes
  programs.dconf.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
    passwordAuthentication = false;

    # Allow local LAN to connect with passwords
    extraConfig = ''
        Match address 192.168.0.0/24
        PasswordAuthentication yes
      '';
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Blootooth as well, but don't waste power
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;
  # Allow users in video group to change brightness
  hardware.brillo.enable = true;
  # Enable all sysrq functions (useful to recover from some issues):
  boot.kernel.sysctl."kernel.sysrq" = 1; # NixOS default: 16 (only the sync command)
  # Documentation: https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html

  # Enable touchpad support.
  services.xserver.libinput = {
    enable = true;
    # Only on touchpads
    additionalOptions = "MatchIsTouchpad \"on\"";
    naturalScrolling = true;
    accelSpeed = "0.5";
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ym = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Let me sudo
      "networkmanager" # Let me change wifi
      "video" # Let me change brightness
      "adbusers" # android stuff
      "plugdev"
    ];
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpZgDiw5ZxOuzFcmKo6OnzCBKoKX8L84qZJ+4G9bBMSlUxlVxN4HMze8apdKHeAOctpO0N8rudBd0D+AzS1zXWNZzyLx3gyihHnvcGGiNdBQEVW9PIDXgFfdASN7RqHQ509OICLYQIPi7PQyJMKjqxJjDsItg+JAeHgIv3pQ+nujoN+/xCJXjNA+7/snhb64aSSl/Y5793/IRDzaX6FzO8u4wCtlgTfq1/guMpPn/T3QcQ7sgv2FeyXWdBcjEuQQFU+W6MtW8QsDdcd87wwJ2fHBwu06n+vSEh94/jEbaBxzQEAwE9ekQFOPeIHBRuCkqtSvb3dpLXN4YFypOP0ZBE9aFrvYTd+E7R1hHmh8Dq1qX2QoXPfr9agmb8h0g/HkiqvUVWAfmSidFk5k9XTzNSj1BjyAj1TiM2VloOITqkljYrTtP7IKRUGh4QvHzHvXQGbzpsTaVJ/+MECMqjgxepUUTEPYv0vnOBrgm5+rAsgr0NrO1c4jKzIz9Wq89I/HU= ym@nixos
"
    ];
  };


  # configured by home-manager as well
  services.xserver = {
    enable = true;
    layout = "us,us,il,il";
    xkbVariant = "dvorak,,,";
    xkbOptions = "caps:swapescape";
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;
    windowManager.bspwm.configFile = /home/ym/dotfiles/.config/bspwm/bspwmrc;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      ubuntu_font_family
      source-sans-pro
      #bitstream charter when? currently I have it local
      dejavu_fonts
      symbola
      #noto-fonts
      #noto-fonts-cjk
      font-awesome-ttf
      #siji
      emacs-all-the-icons-fonts
    ];
    fontconfig.defaultFonts = {
      sansSerif = ["Source Sans Pro" "DejaVu Sans"];
      monospace = ["Ubuntu Mono"];
      serif = ["XCharter" "DejaVu Serif" "DavidCLM"];
    };
  };
  programs.zsh.enable = true;


  systemd.targets.ac-power = {
    description = "AC-only services";
  };
  services.udev.extraRules = let systemctl = "${pkgs.systemd}/bin/systemctl"; in
    ''
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${systemctl} stop ac-power.target"
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${systemctl} start ac-power.target"
    '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
  # NVIDIA
  nixpkgs.config.allowUnfree = true;
  # hardware.bumblebee.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  # services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.nvidia.prime = {
    # sync.enable = true;
    offload.enable = true;
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.opengl = {
    enable = true;
    # package = (pkgs.mesa.override {
      # galliumDrivers = [ "nouveau" "virgl" "swrast" "iris" ];
    # }).drivers;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };
}
