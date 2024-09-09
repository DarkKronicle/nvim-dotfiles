# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license

# This is an empty nixCats config.
# you may import this template directly into your nvim folder
# and then add plugins to categories here,
# and call the plugins with their default functions
# within your lua, rather than through the nvim package manager's method.
# Use the help, and the example repository https://github.com/BirdeeHub/nixCats-nvim

# It allows for easy adoption of nix,
# while still providing all the extra nix features immediately.
# Configure in lua, check for a few categories, set a few settings,
# output packages with combinations of those categories and settings.

# All the same options you make here will be automatically exported in a form available
# in home manager and in nixosModules, as well as from other flakes.
# each section is tagged with its relevant help section.

{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    nixCats.inputs.nixpkgs.follows = "nixpkgs";
    
    neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    neorg-overlay.inputs.nixpkgs.follows = "nixpkgs";
    # for if you wish to select a particular neovim version
    # neovim-flake = {
    #   url = "github:neovim/neovim/nightly?dir=contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-utils.follows = "flake-utils";
    # };
    # add this input to the nvimSRC attribute of the settings set later in this file.

    "plugins-cutlass-nvim" = {
      url = "github:gbprod/cutlass.nvim";
      flake = false;
    };
    "plugins-cmp-luasnip-choice" = {
      url = "github:doxnit/cmp-luasnip-choice";
      flake = false;
    };
    "plugins-accelerated-jk-nvim" = {
      url = "github:rainbowhxch/accelerated-jk.nvim";
      flake = false;
    };
    "plugins-luasnip-snippets" = {
      url = "github:mireq/luasnip-snippets";
      flake = false;
    };
    "plugins-mini-animate" = {
      url = "github:echasnovski/mini.animate";
      flake = false;
    };
    "plugins-mini-hipatterns" = {
      url = "github:echasnovski/mini.hipatterns";
      flake = false;
    };
    "plugins-mini-surround" = {
      url = "github:echasnovski/mini.surround";
      flake = false;
    };
    "plugins-scrollEOF-nvim" = {
      url = "github:Aasim-A/scrollEOF.nvim";
      flake = false;
    };
    "plugins-fold-cycle-nvim" = {
      url = "github:jghauser/fold-cycle.nvim";
      flake = false;
    };
    "plugins-heirline-components-nvim" = {
      url = "github:Zeioth/heirline-components.nvim";
      flake = false;
    };
    "plugins-telescope-egrepify-nvim" = {
      url = "github:fdschmidt93/telescope-egrepify.nvim";
      flake = false;
    };
    "plugins-yazi-nvim" = {
      url = "github:mikavilpas/yazi.nvim";
      flake = false;
    };
    "plugins-tiny-code-action-nvim" = {
      url = "github:rachartier/tiny-code-action.nvim";
      flake = false;
    };
    "plugins-neorg-extras" = {
      url = "github:juniorsundar/neorg-extras";
      flake = false;
    };
    "plugins-neotest-dotnet" = {
      url = "github:DarkKronicle/neotest-dotnet";
      flake = false;
    };
  };

  # see :help nixCats.flake.outputs
  outputs = { self, nixpkgs, flake-utils, nixCats, ... }@inputs: let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    forEachSystem = flake-utils.lib.eachSystem flake-utils.lib.allSystems;
    # the following extra_pkg_config contains any values
    # which you want to pass to the config set of nixpkgs
    # import nixpkgs { config = extra_pkg_config; inherit system; }
    # will not apply to module imports
    # as that will have your system values
    extra_pkg_config = {
      allowUnfree = true;
    };

    system_resolved = forEachSystem (system: let
      # see :help nixCats.flake.outputs.overlays
      standardPluginOverlay = utils.standardPluginOverlay;
      dependencyOverlays = (import ./overlays inputs) ++ [
        # This overlay grabs all the inputs named in the format
        # `plugins-<pluginName>`
        # Once we add this overlay to our nixpkgs, we are able to
        # use `pkgs.neovimPlugins`, which is a set of our plugins.
        (standardPluginOverlay inputs)
        inputs.neorg-overlay.overlays.default
        # add any flake overlays here.
      ];
      # these overlays will be wrapped with ${system}
      # and we will call the same flake-utils function
      # later on to access them.
    in { inherit dependencyOverlays; });
    inherit (system_resolved) dependencyOverlays;

    # see :help nixCats.flake.outputs.categories
    # and
    # :help nixCats.flake.outputs.categoryDefinitions.scheme
    categoryDefinitions = { pkgs, settings, categories, name, ... }@packageDef: 
      let 
        mipsy = pkgs.callPackage ./nix/mipsy/mipsy.nix { };
        mipsy-editor-features = pkgs.callPackage ./nix/mipsy/mipsy-editor-features.nix { };
      in{
      # to define and use a new category, simply add a new list to a set here, 
      # and later, you will include categoryname = true; in the set you
      # provide when you build the package using this builder function.
      # see :help nixCats.flake.outputs.packageDefinitions for info on that section.

      # propagatedBuildInputs:
      # this section is for dependencies that should be available
      # at BUILD TIME for plugins. WILL NOT be available to PATH
      # However, they WILL be available to the shell 
      # and neovim path when using nix develop
      propagatedBuildInputs = {
        generalBuildInputs = with pkgs; [
        ];
      };

      # lspsAndRuntimeDeps:
      # this section is for dependencies that should be available
      # at RUN TIME for plugins. Will be available to PATH within neovim terminal
      # this includes LSPs
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          universal-ctags 
          ripgrep 
          fd 
          gcc
          nix-doc 
          lua-language-server 
          nixd
          texlab
          svls
          nushell
          imagemagick
          omnisharp-roslyn
          netcoredbg
          mipsy
          mipsy-editor-features # Also has script for lsp
        ];
      };

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        customPlugins = with pkgs.nixCatsBuilds; [ ];
        gitPlugins = (((import ./nix/custom-plugins.nix) { pkgs = pkgs; }) ++ 
          # Now you may be thinking, this isn't a plugin. You're right! But this needs to be in the runtime
          # path so that the queries and highlights are there!
          (import ./nix/treesitter-src.nix { inherit pkgs inputs; })); 
        general = (
          ((import ./nix/vim-plugins.nix) { pkgs = pkgs; }) 
          ++ ((import ./nix/treesitter.nix) { pkgs = pkgs; custom-treesitter = (import ./nix/treesitter-grammars.nix { inherit pkgs inputs; }); }) ++ [ mipsy-editor-features ]
        );
      };

      # not loaded automatically at startup.
      # use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        customPlugins = with pkgs.nixCatsBuilds; [ ];
        gitPlugins = with pkgs.neovimPlugins; [ ];
        general = with pkgs.vimPlugins; [ ];
      };

      # shared libraries to be added to LD_LIBRARY_PATH
      # variable available to nvim runtime
      sharedLibraries = {
        general = with pkgs; [
        ];
      };

      # environmentVariables:
      # this section is for environmentVariables that should be available
      # at RUN TIME for plugins. Will be available to path within neovim terminal
      environmentVariables = {
        test = {
          CATTESTVAR = "It worked!";
        };
      };

      # If you know what these are, you can provide custom ones by category here.
      # If you dont, check this link out:
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
      extraWrapperArgs = {
        test = [
          '' --set CATTESTVAR2 "It worked again!"''
        ];
      };

      # lists of the functions you would have passed to
      # python.withPackages or lua.withPackages

      # get the path to this python environment
      # in your lua config via
      # vim.g.python3_host_prog
      # or run from nvim terminal via :!<packagename>-python3
      extraPython3Packages = {
        test = (_:[]);
      };
      # populates $LUA_PATH and $LUA_CPATH
      extraLuaPackages = {
        general = [ 
          (ps: [ ps.magick ]) 
        ];
      };
    };



    # And then build a package with specific categories from above here:
    # All categories you wish to include must be marked true,
    # but false may be omitted.
    # This entire set is also passed to nixCats for querying within the lua.

    # see :help nixCats.flake.outputs.packageDefinitions
    packageDefinitions = {
      # These are the names of your packages
      # you can include as many as you wish.
      nvim-cats = {pkgs , ... }: {
        # they contain a settings set defined above
        # see :help nixCats.flake.outputs.settings
        settings = {
          wrapRc = true;
          # IMPORTANT:
          # you may not alias to nvim
          # your alias may not conflict with your other packages.
          aliases = [ "vim" ];
          # caution: this option must be the same for all packages.
          # neovim-unwrapped = inputs.neovim-flake.packages.${pkgs.system}.neovim;
        };
        # and a set of categories that you want
        # (and other information to pass to lua)
        categories = {
          general = true;
          gitPlugins = true;
          customPlugins = true;
          generalBuildInputs = true;
          test = true;
          example = {
            youCan = "add more than just booleans";
            toThisSet = [
              "and the contents of this categories set"
              "will be accessible to your lua with"
              "nixCats('path.to.value')"
              "see :help nixCats"
            ];
          };
        };
      };
    };
  # In this section, the main thing you will need to do is change the default package name
  # to the name of the packageDefinitions entry you wish to use as the default.
    defaultPackageName = "nvim-cats";
  in


  # see :help nixCats.flake.outputs.exports
  forEachSystem (system: let
    inherit (utils) baseBuilder;
    customPackager = baseBuilder luaPath {
      inherit nixpkgs system dependencyOverlays extra_pkg_config;
    } categoryDefinitions;
    nixCatsBuilder = customPackager packageDefinitions;
    # this is just for using utils such as pkgs.mkShell
    # The one used to build neovim is resolved inside the builder
    # and is passed to our categoryDefinitions and packageDefinitions
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # these outputs will be wrapped with ${system} by flake-utils.lib.eachDefaultSystem

    # this will make a package out of each of the packageDefinitions defined above
    # and set the default package to the one named here.
    packages = utils.mkPackages nixCatsBuilder packageDefinitions defaultPackageName;

    # choose your package for devShell
    # and add whatever else you want in it.
    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ (nixCatsBuilder defaultPackageName) ];
        inputsFrom = [ ];
        shellHook = ''
        '';
      };
    };

    # To choose settings and categories from the flake that calls this flake.
    # and you export overlays so people dont have to redefine stuff.
    inherit customPackager;
  }) // {

    # these outputs will be NOT wrapped with ${system}

    # this will make an overlay out of each of the packageDefinitions defined above
    # and set the default overlay to the one named here.
    overlays = utils.makeOverlays luaPath {
      # we pass in the things to make a pkgs variable to build nvim with later
      inherit nixpkgs dependencyOverlays extra_pkg_config;
      # and also our categoryDefinitions
    } categoryDefinitions packageDefinitions defaultPackageName;

    # we also export a nixos module to allow configuration from configuration.nix
    nixosModules.default = utils.mkNixosModules {
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions nixpkgs;
    };
    # and the same for home manager
    homeModule = utils.mkHomeModules {
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions nixpkgs;
    };
    # now we can export some things that can be imported in other
    # flakes, WITHOUT needing to use a system variable to do it.
    # and update them into the rest of the outputs returned by the
    # eachDefaultSystem function.
    inherit utils categoryDefinitions packageDefinitions dependencyOverlays;
    inherit (utils) templates baseBuilder;
    keepLuaBuilder = utils.baseBuilder luaPath;
  };

}
