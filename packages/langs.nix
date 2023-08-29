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
  config.home = with pkgs; mkMerge [
    (makelang "haskell" [ghc stack])
    (makelang "rust" [cargo rustc rust-analyzer])
    (makelang "node" [nodejs])
    (makelang "zig" [zig])
    (makelang "c" [clang-tools gcc])
    (makelang "java" [jdk8 jre8])
  ];
}
