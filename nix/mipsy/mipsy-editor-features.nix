{
  fetchFromGitHub,
  wasm-pack,
  python3,
  buildNpmPackage,
  rustPlatform,
  stdenv,
  rustc,
  wasm-bindgen-cli,
  writeTextFile,
  nodejs,
}:       
let
  mipsySource =  fetchFromGitHub {
    owner = "insou22";
    repo = "mipsy";
    rev = "7edd349cfdd8680579a86a89666ff4ad8a65415b";
    hash = "sha256-1S3y4bKd3j5pL4jFVoSg2pzxf54hAQX3V/6A6zHAO6U=";
  };

  src = stdenv.mkDerivation {
    pname = "mipsy-editor-features-source";
    version = "latest";

    src = fetchFromGitHub {
      owner = "XavierCooney";
      repo = "mipsy-editor-features";
      rev = "b6d5d59521499ccd71eeec3ab6e59402d15eb962";
      hash = "sha256-RFm4SaaYQ/XvBrlqfGWych6fl7TyYEJecnRw/iiKuuw=";
    };

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      mkdir -p $out/mipsy
      cp -r $src/* $out
      cp -r ${mipsySource}/* $out/mipsy/

      runHook postInstall
    '';
  };

  python = python3.withPackages (python-pkgs: [
    python-pkgs.pyyaml
  ]);

  wasmModule = let
    wasm-bindgen-83 = wasm-bindgen-cli.override {
      version = "0.2.83";
      hash = "sha256-+PWxeRL5MkIfJtfN3/DjaDlqRgBgWZMa6dBt1Q+lpd0=";
      cargoHash = "sha256-GwLeA6xLt7I+NzRaqjwVpt1pzRex1/snq30DPv4FR+g=";
    };
    in
    rustPlatform.buildRustPackage {
      pname = "mipsy-editor-features-wasm";
      version = "latest";

      src = src;

      nativeBuildInputs = [ 
        wasm-pack 
        wasm-bindgen-83
        rustc.llvmPackages.lld
      ];

      cargoHash = "sha256-bMWyvjvY5whGYbpYlffpKLszf4VcA8W80pm/iiOPZvk=";

      buildPhase = ''
      runHook preBuild
      cd mipsy_vscode/
      HOME=$(mktemp -d) wasm-pack build --target nodejs --release --mode no-install
      cd ../
      runHook postBuild
      '';

      installPhase = ''
      runHook preInstall


      mkdir -p $out/src
      cp -r ./* $out/src

      runHook postInstall
      '';

    };

in
  buildNpmPackage {
    inherit src;
    pname = "mipsy-editor-features";
    version = "latest";

    npmBuildScript = "compile";

    npmDepsHash = "sha256-GhW7vs/n6mTfiXDawY1KEnCQ8Fo/2UGEEowrrnInQuc=";

    nativeBuildInputs = [ 
      python
    ];

    configurePhase = ''
      runHook preConfigure

      python generate_syntax.py

      echo ${wasmModule}

      mkdir -p mipsy_vscode/pkg
      cp -r ${wasmModule}/src/mipsy_vscode/pkg/* mipsy_vscode/pkg

      chmod -R a+rw mipsy_vscode/pkg

      runHook postConfigure
    '';

    postInstall = ''
      mkdir -p $out/lua
      mkdir -p $out/syntax
      mkdir -p $out/bin

      cat <<EOT > $out/bin/mipsy-lsp
      #!/usr/bin/env bash

      cd "\$(dirname "\$(realpath \$0)")"/..
      ${nodejs}/bin/node $out/lib/node_modules/xavc-mipsy-features/out/server.js --stdio
      EOT

      chmod +x $out/bin/mipsy-lsp

      cp vim-out/mipsy.lua $out/lua/mipsy.lua
      cp vim-out/mips.vim $out/syntax/mips.vim
    '';

}
