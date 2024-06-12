{
  pkgs,
  custom-treesitter
}:
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/parsing/tree-sitter/update.nix
# This list has nothing to do with what you can do with :TSInstall. These are all packaged by the nix chads.
[
  (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [ 
    p.c 
    p.java 
    p.bash 
    p.json 
    p.json5
    p.javascript
    p.ini
    p.html
    p.latex 
    p.python 
    p.markdown 
    p.ron 
    p.rust 
    p.toml 
    p.nix 
    p.vimdoc 
    p.vim 
    p.yaml 
    p.verilog 
    p.regex 
    p.mermaid 
    p.kdl 
    p.norg
    p.lua
  ] ++ custom-treesitter))]
