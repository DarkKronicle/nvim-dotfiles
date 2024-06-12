{
  pkgs,
  inputs
}:
let
  patch-treesitter = pkgs.callPackage ./treesitter-patch.nix { };
in
[
    (patch-treesitter (pkgs.tree-sitter.buildGrammar {
      language = "kanata";
      version = "a6213d0";
      src = inputs.treesitter-kanata;
      generate = true;
     }) "kanata")
] ++ (with pkgs.tree-sitter.builtGrammars; [
    tree-sitter-nu
])
