# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  cfw = pkgs.callPackage ./pkgs/cfw/default.nix { }; 
  obsidian = pkgs.callPackage ./pkgs/obsidian/default.nix { };
  watt-toolkit =  pkgs.callPackage ./pkgs/watt-toolkit/default.nix { };
  latte-dock = pkgs.libsForQt5.callPackage ./pkgs/latte-dock/default.nix { };
  wps = pkgs.libsForQt5.callPackage ./pkgs/wps/default.nix { };
  sddm = pkgs.callPackage ./pkgs/sddm/default.nix { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
