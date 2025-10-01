# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/i3.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Arc-170"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #mount home partition
  fileSystems."/home" = {
    device = "/dev/nvme0n1p3";
    fsType = "ext4";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # services.xserver.xrandrHeads = [
  #   {
  #     output = "DP-2";
  #     primary = true;
  #     monitorConfig = ''
  #       Option "Mode" "1920x1080"
  #       Option "Rate" "144"
  #       Option "Rotate" "normal"
  #     '';
  #   }
  #   {
  #     output = "DVI-D-1";
  #     monitorConfig = ''
  #       Option "Mode" "1280x1024"
  #       Option "Rotate" "left"
  #       Option "RightOf" "DP-2"
  #     '';
  #   }
  # ];
  services.autorandr.enable = true;

  services.xserver.displayManager.lightdm.greeters.slick.theme.name = "Adwaita";
  services.xserver.displayManager.lightdm.greeters.slick.font.name = "inconsolata-nerdfont";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kendell = {
    isNormalUser = true;
    description = "kendell";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
    packages = with pkgs; [
      gvfs
      mangohud #for steam
      protonup #for steam
      prismlauncher #foss minecraft launcher
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    alacritty
    zsh
    tmux
    firefox
    git
    brightnessctl
    tailscale
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "kendell" = import ./home.nix;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  #Enabling Zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    ohMyZsh.enable = true;
    syntaxHighlighting.enable = true;
  };
  #Enabling zsh for all users
  users.defaultUserShell = pkgs.zsh;

  #Nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.tailscale.enable = true;

  #Automatic updating
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  #Automatic cleanup
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
  nix.settings.auto-optimise-store = true;

  #  programs.firefox.policies = {
  #    DisableTelemetry = true;
  #    DisableFirefoxStudies = true;
  #    EnableTrackingProtection = {
  #      Value = true;
  #      Locked = true;
  #      Cryptomining = true;
  #      Fingerprinting = true;
  #    };
  #    ExtensionSettings = with builtins; let
  #      extension = shortId: uuid: {
  #        name = uuid;
  #        value = {
  #          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
  #          installation_mode = "normal_installed";
  #        };
  #      };
  #    in
  #      listToAttrs [
  #        (extension "ublock-origin" "uBlock0@raymondhill.net")
  #        (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
  #        (extension "firefoxcolor" "FirefoxColor@mozilla.com")
  #        (extension "catppuccin-frappe-lavender" "{5ee380f7-abda-467c-ae9a-d30bf8f0d1d6}")
  #        (extension "custom-new-page" "custom-new-tab-page@mint.as")
  #      ];
  #    # To add additional extensions, find it on addons.mozilla.org, find
  #    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
  #    # Then, download the XPI by filling it in to the install_url template, unzip it,
  #    # run `jq .browser_specific_settings.gecko.id manifest.json` or
  #    # `jq .applications.gecko.id manifest.json` to get the UUID
  #  };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  catppuccin.sddm = {
    enable = true;
    font = "inconsolata-nerdfont";
  };
  #For bottles
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  #  systemd.services.flatpak-repo = {
  #    wantedBy = ["multi-user.target"];
  #    path = [pkgs.flatpak];
  #    script = ''
  #      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #    '';
  #  };

  #make thunar default app for opening directories
  xdg.mime.defaultApplications."inode/directory" = "thunar.desktop";

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
