{
  pkgs,
  inputs
}:
(with pkgs.tree-sitter.builtGrammars; [
    tree-sitter-nu
])
