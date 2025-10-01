{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kendell";
  home.homeDirectory = "/home/kendell";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  #programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    # System & Package Management
    pkgs.chezmoi

    # Shell & Terminal Utilities
    pkgs.freshfetch
    pkgs.rofi
    pkgs.xclip
    pkgs.starship
    pkgs.cowsay
    pkgs.xplr
    pkgs.cava
    pkgs.libnotify

    # Text Editing & Development Tools
    pkgs.neovim
    pkgs.vimPlugins.packer-nvim
    pkgs.lua
    pkgs.gcc
    pkgs.gnumake
    pkgs.java-language-server
    pkgs.go
    pkgs.lua-language-server
    pkgs.nixfmt-rfc-style
    pkgs.nil
    pkgs.alejandra
    pkgs.jdk8
    pkgs.jre8

    # System & Utility Software
    pkgs.gnupg
    pkgs.pass
    pkgs.feh
    pkgs.tree
    pkgs.ncdu
    pkgs.xfce.thunar
    pkgs.xfce.xfconf
    pkgs.vlc
    pkgs.zathura
    pkgs.dunst
    pkgs.autorandr

    # Fonts
    pkgs.inconsolata-nerdfont

    # Multimedia & Audio
    pkgs.pulseaudioFull
    pkgs.picom

    # Version Control & GitHub Integration
    pkgs.gh

    # Office & Productivity
    pkgs.libreoffice-qt6-fresh

    # Miscellaneous
    pkgs.vesktop
    pkgs.btop
    pkgs.CuboCore.coreshot #x11
    pkgs.unzip
    pkgs.postman
    pkgs.remmina
    pkgs.zoom-us
  ];

  #Enable Cattppuccin globally
  catppuccin = {
    enable = true;
    flavor = "frappe";
    gtk = {
      enable = true;
      flavor = "frappe";
    };
    cursors = {
      enable = true;
    };
    spotify-player = {
      enable = true;
      flavor = "frappe";
    };
    btop = {
      enable = true;
      flavor = "frappe";
    };
  };

  qt = {
    enable = true;

    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";

      catppuccin = {
        enable = true;

        flavor = "frappe";
        accent = "lavender";
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kendell/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #autorandr display settings
  programs.autorandr = {
    enable = true;
    profiles = {
      "Desktop" = {
        fingerprint = {
          DP2 = "00ffffffffffff0005e30124350d0300
                        2c1e0104a5341d783b1e61a855529b25
                        115054bfef00d1c081803168317c4568
                        457c6168617c023a801871382d40582c
                        450009252100001efc7e808870381240
                        1820350009252100001e000000fc0032
                        3447315747340a2020202020000000fd
                        003090a0a021010a2020202020200129
                        020328f14c0103051404131f12021190
                        3f230907078301000065030c00100068
                        1a00000101309000866f80a070384040
                        3020350009252100001efe5b80a07038
                        35403020350009252100001e011d0072
                        51d01e206e28550009252100001e7c2e
                        90a0601a1e403020360009252100001a
                        0000000000000000000000000000002a";
          DVI-D1 = "00ffffffffffff0010ac2640564e4547
                         2611010380261e78eea2a5a3574c9d25
                         115054a54b00714f8180010101010101
                         010101010101302a009851002a403070
                         1300782d1100001e000000ff00465031
                         383237394c47454e560a000000fc0044
                         454c4c203139303846500a20000000fd
                         00384c1e510e000a202020202020009d";
        };
        config = {
          DP2 = {
            enable = true;
            primary = true;
            #position = "0x0";
            mode = "1920x1080";
            rate = "144.00";
          };
          DVI-D1 = {
            enable = true;
            crtc = 1;
            mode = "1024x1280";
            rotate = "left";
            rate = "60.00";
          };
        };
      };
    };
  };

  programs.git = {
    enable = true;
    # extraConfig = {
    #   #set GitHub CLI to handle credentials
    #   credential.helper = "${pkgs.gh}/bin/gh auth git-credential";
    # };
    userEmail = "92357397+Kendellb@users.noreply.github.com";
    userName = "kendell";
  };
  programs.gh.gitCredentialHelper.enable = true;

  xsession.numlock.enable = true;

  #Enabling notify-send dbus and dunst dameon
  services.systembus-notify.enable = true;
  services.dunst.enable = true;

  home.activation.chezmoi = lib.hm.dag.entryAfter ["installPackages"] ''
    PATH="${pkgs.chezmoi}/bin:${pkgs.git}/bin:${pkgs.git-lfs}/bin:''${PATH}"

    $DRY_RUN_CMD chezmoi init https://github.com/Kendellb/dotfiles.git
    $DRY_RUN_CMD chezmoi update -a
    $DRY_RUN_CMD chezmoi git status
  '';

  #  programs.firefox = {
  #    enable = true;
  #    profiles.kendell = {
  #      search.engines = {
  #        "Nix Packages" = {
  #          urls = [
  #            {
  #              template = "https://search.nixos.org/packages";
  #              params = [
  #                {
  #                  name = "type";
  #                  value = "packages";
  #                }
  #                {
  #                  name = "query";
  #                  value = "{searchTerms}";
  #                }
  #              ];
  #            }
  #          ];
  #
  #          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  #          definedAliases = ["@np"];
  #        };
  #      };
  #      search.force = true;
  #
  #      bookmarks = [
  #        {
  #          #  name = "wikipedia";
  #          #  tags = [ "wiki" ];
  #          #  keyword = "wiki";
  #          #  url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
  #        }
  #      ];
  #
  #      settings = {
  #        "dom.security.https_only_mode" = true;
  #        "browser.download.panel.shown" = true;
  #        "identity.fxaccounts.enabled" = false;
  #        "signon.rememberSignons" = false;
  #      };
  #
  #      userChrome = ''
  #        /* some css */
  #      '';
  #
  #      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
  #        bitwarden
  #        ublock-origin
  #        sponsorblock
  #        youtube-shorts-block
  #        firefox-color
  #      ];
  #    };
  #  };

  services.flatpak.packages = [
    #{ appId = "com.brave.Browser"; origin = "flathub";  }
    "com.usebottles.bottles"
    "io.mrarm.mcpelauncher"
    "com.github.tchx84.Flatseal"
  ];
}
