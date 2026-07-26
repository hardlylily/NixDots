# aaa
{ configs, pkgs, inputs, ... }:

{

# there's not a lot to touchy here honestly do whatever you want

programs.steam = {
    enable = true;
    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
        proton-ge-bin
        inputs.proton-cachyos.packages.${pkgs.system}.proton-cachyos
        ];

    };
}
