#################################################################
# NixOS Configuration
#################
# Manual:         https://nixos.org/nixos/options.html
# Packages:       https://nixos.org/nixos/packages.html
# Config options: https://nixos.org/nixos/manual
# NixOS Language: https://nixos.wiki/wiki/Nix_Expression_Language
#################

{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  ### Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "large-horse-collider"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.networkmanager.packages = [ pkgs.networkmanagerapplet ];

  ### Internationalisation properties
  i18n = {
    consoleFont = "Hack";
    consoleKeyMap = "de";
    defaultLocale = "en_US.UTF-8";
  };

  ### Set time zone
  time.timeZone = "Europe/Paris";

  ### Yes, I am silly
  programs.bash.interactiveShellInit = ''
foo=$(fortune -s)
cat <<< "___━*━___━━___━__*___━_*__┓━╭━━━━╮
__*_━━___━━___━━*____━━___┗┓|::::::^---^
___━━___━*━___━━____━━*___━┗|::::|｡◕‿‿◕｡|
___*━__━━_*___━━___*━━___*━━╰O--O---O--O╯

$foo" | lolcat
export TERM=rxvt-unicode
'';

  ### Display color temperature
  services.redshift = {
    enable = true;
    #provider = "geoclue2";
    latitude = "48.78232";
    longitude = "9.17702";
  };

  ### X settings
  services.xserver = {
    enable = true;
    autorun = true;

    ### Keyboard settings
    layout = "de";
    #xkbModel = "pc105";
    xkbOptions = "eurosign:e";
    #xkbVariant = "qwertz,dvorak";
    xkbVariant = "deadgraveacute";

    ### Touchpad support
    libinput.enable = true;
    #synaptics.enable = true;

    ### Display manager
    ## slim
    displayManager = {
      slim.theme = pkgs.fetchurl {
        url = http://marvid.fr/~eeva/mirror/slim-theme-solarized-debian.tar.bz2;
        sha256 = "e792886a39b97bed0cb1022bec381806b0ca1dcc726b093187231bd1902acd49";
      };
    };
    #displayManager.slim = {
    #  autoLogin = false;
    #  defaultUser = "lcd";
    #  enable = true;
    #};
    #displayManager = {
    #  slim.enable = true;
    #  slim.defaultUser = "kana";
    #  slim.autologin = true;
    #  # ${pkgs.xlibs.xmodmap}/bin/xmodmap ~/.Xmodmap
    #  # ${pkgs.xlibs.xrdb}/bin/xrdb -merge ~/.Xresources # Load Xresources # Load Xresources
    #  sessionCommands = ''
    #    ${pkgs.xlibs.xset}/bin/xset r rate 200 60  # set the keyboard repeat rate
    #    ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr # Set cursor
    #    ${pkgs.feh}/bin/feh --no-fehbg --bg-tile ~/dot-files/X11/Wallpapers/Tiling/sugar.png &
    #  '';
    #};

    ### Desktop Environment
    ## xcfe
    #services.xserver.desktopManager.xfce.enable = true;
    #services.xserver.desktopManager.default = "xfce";
    desktopManager.default = "xfce";
    desktopManager.xfce.enable = true;
    desktopManager.xfce.noDesktop = true;
    desktopManager.xfce.enableXfwm = false;

    ## Mate
    desktopManager.mate.enable = true;

    ## i3
    #desktopManager.default = "none";
    desktopManager.xterm.enable = false;

    ### Window manager
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        i3
        rofi
        i3status
        i3lock
      ];
    };

    ## openbox
    windowManager.openbox.enable = true;

    ## xmonad
    #windowManager.xmonad = {
    #  enable = true;
    #  enableContribAndExtras = true;
    #};
    #desktopManager.xterm.enable = false;
  };

  ### Compton composition manager
  #services.compton = {
  #  enable = true;
  #  fade = true;
  #  inactiveOpacity = "0.9";
  #  shadow = true;
  #  fadeDelta = 4;
  #};

  ### User account. Don't forget to set a password with ‘passwd’.
  # users.users.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  users.users.kana = {
    isNormalUser = true;
    description = "Kana";
    extraGroups = [ "wheel" "dialout" "docker" ];
    uid = 1000;
    #openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
  };

  ### State version
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

  ### Installed packages
  environment.systemPackages = with pkgs; [
    #nox # nixos package search

	rxvt_unicode
    htop
    curl
    wget
    #bind
    mate.caja
    ntfs3g # writable ntfs mounts
    #service-wrapper


    firefox
    chromium
    dropbox
    pidgin-with-plugins
    telegram-purple

    mplayer # + mpd for polybar?
    ffmpeg
    playerctl
    spotify
    #cmus
    mpd
    #mpc_cli
    #sonata # mpd client

    git
    atom
    docker
    docker_compose
    #nodejs-8_x
    #(yarn.override { nodejs = nodejs-8_x; })
    #nixops-dns
    #mariadb
    #mysql-workbench

    gimp
    inkscape
    #nomacs
    #feh
    #viewnior # ugly scrollbars :(

    keepass
    truecrypt

    i3
    #openbox
    #twmn
    #dmenu
    #i3status
    #i3lock
    #i3blocks # need for mplayer + mpd?
    polybar
    /*(polybar.override {
      alsaSupport = true;
      i3Support = true;
      i3 = pkgs.i3; jsoncpp = pkgs.jsoncpp;
      #iwSupport = true;
      #githubSupport = true;
      #mpdSupport = true;
    })*/
    lsof # for ssh session display
    #nitrogen
  ];

  environment.variables = {
    #TERMINAL = "alacritty";
    #TERMINAL = "sakura";
    #TERMINAL = "retroterm"; # lol
    #TERMINAL = "kitty"; # only if scrollbar can be removed...
    #TERMINAL = "termite";
    TERMINAL = "urxvt";
  };

  fonts = {
    fonts = with pkgs; [
      siji
      unifont
      hack-font
      iosevka
      #weather-icons # does not work?
    ];

    fontconfig = {
      enable = true;
      defaultFonts.monospace = [ "Consolas" ];
    };
  };

  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
        plugins = [ telegram-purple purple-discord purple-hangouts purple-facebook slack ];
      };

      polybar = pkgs.polybar.override {
        alsaSupport = true;
        i3Support = true;
        #iwSupport = true;
        #githubSupport = true;
        mpdSupport = true;
      };
    };
  };

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;

  #services.mysql.package = pkgs.mariadb;
  #services.mysql.enable = true;

  #services.polybar = {
  #  enable = true;
  #  package = pkgs.polybar.override {
  #    i3Support = true;
  #    alsaSupport = true;
  #    iwSupport = true;
  #    githubSupport = true;
  #  };
  #  config = {
  #    "bar/top" = {
  #      monitor = "eDP1";
  #      width = "100%";
  #      height = "3%";
  #      radius = 0;
  #      # Just sticking them together in the center for now
  #      modules-center = "date i3";
  #    };
  #    "module/date" = {
  #      type = "internal/date";
  #      internal = 5;
  #      date = "%Y-%m-%d";
  #      time = "%H:%M";
  #      label = "%date% %time%";
  #    };
  #    "module/i3" = {
  #      type = "internal/i3";
  #      scroll-up = "i3wm-wsnext";
  #      scroll-down = "i3wm-wsprev";
  #    };
  #  };
  #  script = ''polybar example &'';
  #};

  # KVM
  #boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  #virtualisation.libvirtd.enable = true;

  # Docker#
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
}
