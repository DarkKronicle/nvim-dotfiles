{ 
  pkgs 
}:
let
  noCheck = pkg: pkg.overrideAttrs (_: {
    doCheck = false;
  });
in
pkgs.lib.forEach (with pkgs.neovimPlugins; [
  cutlass-nvim
  accelerated-jk-nvim
  luasnip-snippets
  mini-animate
  mini-surround
  mini-hipatterns
  scrollEOF-nvim
  fold-cycle-nvim
  heirline-components-nvim
  telescope-egrepify-nvim
  yazi-nvim
  tiny-code-action-nvim
  neorg-extras
  neotest-dotnet
  kitty-scrollback-nvim
]) noCheck
