{
  pkgs,
  inputs
}:
let
  patch-treesitter = pkgs.callPackage ./treesitter-patch.nix { };
in
[
    (pkgs.tree-sitter.buildGrammar {
      language = "kanata";
      version = "a6213d0";
      src = inputs.treesitter-kanata;
      generate = true;
     })
] ++ (with pkgs.tree-sitter.builtGrammars; [
    tree-sitter-nu
])
