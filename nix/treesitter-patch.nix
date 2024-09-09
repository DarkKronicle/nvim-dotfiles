{
  pkgs,
  stdenv
}:
grammar: language: pkgs.runCommand "${language}-moved" { } ''
  mkdir -p $out/queries/${language}
  ln -s ${grammar}/parser $out/parser
  ln -s ${grammar}/queries/* $out/queries/${language}
''
