{config, pkgs ? import <nixpkgs>, ...}:
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };
  #users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
}
