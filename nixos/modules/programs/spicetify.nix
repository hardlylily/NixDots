{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      #Only touchy this and theme. Don't touchy the rest,,,


      adblockify
      hidePodcasts
      shuffle
      oneko
      copyLyrics
      loopyLoop
    ];
    theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";

  };
}

