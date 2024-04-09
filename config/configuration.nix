# dukk.nix v7

{ config, pkgs, newpkgs, ... }:

let 
  sddm-dukk-theme = pkgs.callPackage ../dotfiles/sddm.nix {};
  dukk-picom = pkgs.callPackage ../dotfiles/picom.nix {};
in
{
  imports =
    [ # scans hardware, i guess
      ./hardware-configuration.nix
    ];

  # holy nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = [(pkgs.adi1090x-plymouth-themes.override {selected_themes = ["rings"];})];
  };
  # ntfs support is a joke
  boot.supportedFilesystems = [ "ntfs" ];
  networking.hostName = "nixos"; # too lazy to change this

  # bluetooth works #LinuxGoals
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # i enabled polkit, but it never worked :(
  security.polkit.enable = true;

  # for future reference, the commands are nmtui and nmcli
  # shouldn't have taken me that long to figure that out
  networking.networkmanager.enable = true;
  
  # stupid localsend
  networking.firewall.allowedTCPPorts = [ 80 443 53317 ];
  # stupid kdeconnect
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; }
  ];

  # "god shed his grace of thee..."
  time.timeZone = "America/New_York";

  # select internationalisation properties...?
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # take that, elon
  services.xserver.enable = true;

  programs.kdeconnect.enable = true;

  # so dat do (be kinda cool) man
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "corners";
    settings = {
      General = { InputMethod = ""; };
    };
  };

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  # i preferred gnome but hyprland didn't (screw xdg-portal-gnome)
  # of course, i don't use hyprland anymore, so...
  services.xserver.desktopManager.plasma5.enable = true;
  # trying something new
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
  };

  # keys
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;

  # actually never tested if printing works
  services.printing.enable = true;

  # sound? on linux? #LinuxGoals
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # yeah, it's me.
  users.users.dukk = {
    isNormalUser = true;
    description = "Daksh Gupta";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [];
    shell = pkgs.nushell;
  };

  # Nvidia drivers :/
  hardware.nvidia = {

    # something for wayland idk
    modesetting.enable = true;

    # who am i, richard stallman?
    open = false;

    # why not
    nvidiaSettings = true;

    # hope this works
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  systemd = {
    # *delaying boot so that you can see the startup screen for longer*
    # *failing to even make a systemd service work*
    # maybe i should use void instead
    #services.sweetDreams = {
      #enable = true;
      #description = "Sweet Dreams";
      #wantedBy = [ "multi-user.target" ];
      #before = [ "sddm.service" ];
      #serviceConfig = {
        #Type = "simple";
        #ExecStart = "${pkgs.bash} /home/dukk/sweetdreams.sh";
        #Restart = "always";
        #RestartSec = 10;
        #TimeoutStopSec = 20;
      #};
    #};
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  # crab cult
  environment.shells = with pkgs; [ nushell ];

  #env var

  environment.sessionVariables.MOZ_USE_XINPUT2 = "1";


  # oss is cool, don't sue me
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      picom = dukk-picom;
      new = import newpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    })
  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  # or just use home manager
    sddm-dukk-theme
  ];
  
  # less verbose boot log
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" "fbcon=vc:2-6" "console=tty0" ];
  boot.loader.grub.extraConfig = "GRUB_CMDLINE_LINUX_DEFAULT=\"quiet loglevel=3 vga=current\"";



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment? (no)

}
