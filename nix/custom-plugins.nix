{ 
  pkgs 
}:
let
  noCheck = pkg: pkg.overrideAttrs (_: {
    doCheck = false;
  });
in
pkgs.lib.forEach (with pkgs.neovimPlugins; [
  cutlass-nvim # cut operation. Could be done via registers, but is nicer
  accelerated-jk-nvim # move faster with j and k
  mini-animate # animate scrolling and some other things
  mini-surround
  mini-hipatterns # show me the colors!
  scrollEOF-nvim # scroll past the end of the file by a few lines
  fold-cycle-nvim # fold binds cycle through folds
  yazi-nvim
  tiny-code-action-nvim
  neorg-extras
  neotest-dotnet
  kitty-scrollback-nvim
  neorg-interim-ls

  undotree # undotree but in lua

  heirline-components-nvim # nice prebuilt components for heirline
  nvim-fundo
  image-nvim
]) noCheck
