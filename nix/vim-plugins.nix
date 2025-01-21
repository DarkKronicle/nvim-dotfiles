{
  pkgs
}:
with pkgs.vimPlugins; [
  lazy-nvim # package manager
  nvim-hlslens # highlight search
  nvim-lspconfig # lsp config ofc
  nvim-notify # make notifications look good
  nvim-spider # movement commands make a bit more sense
  nvim-ufo # fold, but pretty :3
  nvim-web-devicons # icons
  
  blink-cmp # fast completion
  blink-compat # use my cmp with blink!
  blink-ripgrep-nvim # ripgrep my files for blink
  cmp-emoji # emojis for blink
  cmp-latex-symbols # latex symbols for blink

  dressing-nvim # make normal things pretty
  flash-nvim # search, but fast
  friendly-snippets # snippets and more snippets!
  gitsigns-nvim # git signs on the sidebar!
  heirline-nvim # bar, tabs, all that jazz
  highlight-undo-nvim # highlight undo, duh
  hydra-nvim # become the snake with keybinds
  indent-blankline-nvim # look at all those tab lines
  luasnip # snippets
  marks-nvim # little mark icons in the gutter + more

  neorg # super nice note format by people who care
  neorg-telescope # 

  noice-nvim # intercept and make built in stuff look a bit nicer
  nui-nvim # dependency of neotree. UI library

  catppuccin-nvim # very nice theme with tons of integrations all over the place
  plenary-nvim # another dependency
  promise-async # yet another dependency

  rainbow-delimiters-nvim # make my brackets rainbow :3
  telescope-nvim # menu thing
  telescope-fzf-native-nvim # better telescope finding
  todo-comments-nvim # make todo good again
  ultimate-autopair-nvim # when I parenthesis make another
  vim-illuminate # show me copies of the words I've highlighted
  rustaceanvim # rust, more rust, and finally more rust
  twilight-nvim # dim in zen
  vimtex # latex for vim
  yanky-nvim # some nice yank utils
  cmp_yanky # show my yank in completion

  inc-rename-nvim # rename
  bufdelete-nvim # nicer deleting of buffers
  glance-nvim # look at lsp definitions
  neo-tree-nvim # tree!
  which-key-nvim # show me my bindings

  image-nvim
  nabla-nvim

  no-neck-pain-nvim # center windows in specific situations

  nvim-dap
  nvim-dap-ui
  nvim-dap-virtual-text

  neotest
  neotest-golang
  neotest-gradle
  neotest-java
  neotest-python
  nvim-coverage

  lsp_lines-nvim

  trouble-nvim
  gitlinker-nvim
  neogen
  diffview-nvim

  nvim-treesitter-context
]
