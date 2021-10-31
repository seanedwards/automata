{config, pkgs ? import <nixpkgs>, ...}:
{
  users.users.edwards = {
    isNormalUser = true;
    home = "/home/edwards";
    description = "Tilmon Edwards";
    extraGroups = [ "wheel" ];
    initialPassword = "";
    useDefaultShell = true;
  };
}

