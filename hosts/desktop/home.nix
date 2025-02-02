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

    # System & Utility Software
    pkgs.gnupg
    pkgs.pass
    pkgs.feh
    pkgs.tree
    pkgs.ncdu
    pkgs.xfce.thunar
    pkgs.vlc
    pkgs.zathura
    pkgs.dunst
    pkgs.gvfs

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

  #  services.gvfs.enable = true; # Mount, trash, and other functionalities
  #  services.tumbler.enable = true; # Thumbnail support for images

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
}
