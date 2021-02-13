{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment = {
    variables.EDITOR = "nvim";

    systemPackages = with pkgs; [
      curl
      diskonaut
      dropbox-cli
      exa
      fd
      geany
      git
      home-manager
      hyperfine
      micro
      nodePackages.prettier
      nox
      pdfarranger
      pipenv
      ripgrep
      shellcheck
      shfmt
      signal-desktop
      spotify
      tealdeer
      tokei
      vim
      watchexec
      wget
      zsh
    ];
  };

  hardware.pulseaudio.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "nixos";

    useDHCP = false;

    interfaces = {
      eno1.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    lorri.enable = true;

    openssh.enable = true;

    printing.enable = true;

    xserver = {
      desktopManager.gnome3.enable = true;
      displayManager.gdm.enable = true;
      enable = true;
    };
  };

  sound.enable = true;

  system.stateVersion = "20.09";

  systemd.user.services.dropbox = {
    after = [ "xembedsniproxy.service" ];

    description = "Dropbox";

    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };

    serviceConfig = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Nice = 10;
      PrivateTmp = true;
      ProtectSystem = "full";
      Restart = "on-failure";
    };

    wants = [ "xembedsniproxy.service" ];

    wantedBy = [ "graphical-session.target" ];
  };

  time.timeZone = "Asia/Hong_Kong";

  users.users.derek = {
    description = "Derek Wan";
    home = "/home/derek";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

}
