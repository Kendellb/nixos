{
  config,
  pkgs,
  ...
}: {
  catppuccin = {
    accent = "lavender";
    flavor = "frappe";

    pointerCursor.enable = true;
    pointerCursor.accent = "lavender";
    pointerCursor.flavor = "frappe";
  };

  gtk = with pkgs; {
    enable = true;

    # https://nix.catppuccin.com/index.html
    catppuccin = {
      enable = true;

      flavor = "frappe";
      accent = "lavender";

      icon.enable = true;
      icon.accent = "lavender";
      icon.flavor = "frappe";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = with pkgs; {
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

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.packages = with pkgs; [
  ];
}
