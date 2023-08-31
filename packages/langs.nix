# Packages for a good variety of languages, easily toggleable.
{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.packages.langs;
  makelang = lang: packs: (mkIf cfg.${lang}.enable {
    packages = packs;
  });
in
{
  options.packages.langs = {
    haskell.enable = mkEnableOption "Haskell";
    rust.enable = mkEnableOption "Rust";
    node.enable = mkEnableOption "Node";
    zig.enable = mkEnableOption "Zig";
    c.enable = mkEnableOption "C";
    java.enable = mkEnableOption "Java";
  };
  # lines 21-26 give me lisp vibes
  config.home = with pkgs; mkMerge [
    (makelang "haskell" [ghc stack])
    (makelang "rust" [cargo rustc rust-analyzer])
    (makelang "node" [nodejs])
    (makelang "zig" [zig])
    (makelang "c" [clang-tools gcc])
    (makelang "java" [jdk8 jre8])
  ];
}
