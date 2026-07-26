

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/programs/spicetify.nix
      ./modules/apps/steam.nix
      ./modules/hyprland/hyprland.nix
    ];

  # Bootloader. No touchy.

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    timeout = 5;
	efi = {
	 efiSysMountPoint = "/boot";
	};
    grub = {
	enable = true;
	efiSupport = true;
	devices = ["nodev"];
	useOSProber = true;
	extraEntriesBeforeNixOS = false;
	extraEntries = ''
		menuentry "Reboot" {
			reboot
		}
		menuentry "Shutdown" {
			halt
		}
	      '';
	    };
	};

  # Kernel, No touchy.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Hostname, can touchy.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;

  # Time zone, yes touchy.
  time.timeZone = "America/Asuncion";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_PY.UTF-8";
    LC_IDENTIFICATION = "es_PY.UTF-8";
    LC_MEASUREMENT = "es_PY.UTF-8";
    LC_MONETARY = "es_PY.UTF-8";
    LC_NAME = "es_PY.UTF-8";
    LC_NUMERIC = "es_PY.UTF-8";
    LC_PAPER = "es_PY.UTF-8";
    LC_TELEPHONE = "es_PY.UTF-8";
    LC_TIME = "es_PY.UTF-8";
  };

  # X11, can touchy
  services.xserver.enable = false;

  # Enable sddm, recommended no touchy
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # Enable plasma, can touchy.
  services.desktopManager.plasma6.enable = true;

   # Swap space
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  } ];

  # No touchy, i don't know what this is or what it does but stuff breaks if i remove this
  services.fwupd.enable = true;

  # Zsh shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  # No touchy
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # X11 keymap. Same as fwupd, stuff breaks if removed.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing,,,,
  services.printing.enable = true;

  # Pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # User account, can touchy
  users.users.weepbird = {
    isNormalUser = true;
    description = "weepbird";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # FIREFOX!!! SSSDFAKGIEJHIJ
  programs.firefox.enable = true;

  # Allow unfree packages, for discord and nvidia and stuff
  nixpkgs.config.allowUnfree = true;

  # Will put this thing somewhere else in /modules later
  environment.systemPackages = with pkgs; [
    vim
    gamescope
    wget
    kitty
    git
    easytag
    fastfetch
    vesktop
    google-chrome
    btop
    mpv
    steam-run
    plasma-panel-colorizer
    cowsay
    cava
    pipes
    wine64
    cbonsai
    onlyoffice-desktopeditors
    cmatrix
    kdePackages.filelight
    krita
    curl
    zip
    unzip
    prismlauncher
    lutris
    nicotine-plus
    qbittorrent
    obs-studio
    ntfs3g
    nwg-look

  # No touchy
  ];
  nixpkgs.overlays = [
  (prev: final: {
    pnpm_10_29_2 = prev.pnpm_10;
     })

    ];
  # Fonts, will also probably move this somewhere else
   fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.caskaydia-mono
  ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # You know the drill, don't know what it does but it can break stuff if removed
  powerManagement.cpuFreqGovernor = "performance";

  # GPU CONFUGIRATIO N BELOW!!!! SSDGH
  # TOUCHY IF AMD OTHERWISE NO TOUCHY



  # Enable OpenGL/Vulkan. No touchy if gaming
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # For steam
  };

  # Load NVIDIA Drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management, no touchy
    powerManagement.enable = false;

    # Fine-grained power management. No touchy
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module, recommended no touchy but if you need to touchy, go touchy
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Select the stable driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;


  };


  # NO TOUCHY.
  system.stateVersion = "25.11";

}
