{ config, pkgs, callPackage, ... }: 

{
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu        # application launcher most people use
        i3status     # gives you the default i3 status bar
        i3lock       # default i3 screen locker
        (pkgs.polybar.override {
          mpdSupport = true;
          pulseSupport = true;
        })  # Add polybar with overrides here
      ];
    };
  };

  services.xserver.windowManager.i3.package = pkgs.i3-gaps;
}

