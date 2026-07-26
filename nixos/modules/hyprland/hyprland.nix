{ pkgs, configs, inputs, ...}:

{
 imports = [
   inputs.noctalia.nixosModules.default
   ];

   programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

 programs.hyprland = {
  enable = true;
  xwayland.enable = true; # No touchy
  };

  # No touchy
 xdg.menus.enable = true;
 xdg.mime.enable = true;

 # Packages that you can touchy:
 # wiremix
 # waybar
 # hyprlock
 # either thunar or nautilus
 # walker
 # wallust
 # matugen
 # THE REST NO TOUCHY!!!!
 environment.systemPackages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    awww
    waybar
    wiremix
    hyprlock
    hyprshot
    hyprcursor
    bibata-cursors
    hyprsunset
    wireplumber
    grim
    thunar
    nautilus
    slurp
    wl-clipboard
    libnotify
    gpu-screen-recorder
    hyprpolkitagent
    matugen
    walker
    wallust

 ];

}
