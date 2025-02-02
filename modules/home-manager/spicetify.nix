{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  options.programs.spicetify = {
    enable = lib.mkEnableOption "Enable Spicetify configuration";
    enabledExtensions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["adblockify" "hidePodcasts" "shuffle"];
      description = "List of enabled Spicetify extensions.";
    };
    colorScheme = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
      description = "Spicetify color scheme.";
    };
  };

  config = lib.mkIf config.programs.spicetify.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; config.programs.spicetify.enabledExtensions;
      colorScheme = config.programs.spicetify.colorScheme;
    };
  };
}
