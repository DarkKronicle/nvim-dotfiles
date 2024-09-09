{
  rustPlatform,
  fetchFromGitHub,
  lib,
}: rustPlatform.buildRustPackage {

  pname = "mipsy";
  version = "latest";

  src = fetchFromGitHub {
    owner = "insou22";
    repo = "mipsy";
    rev = "7edd349cfdd8680579a86a89666ff4ad8a65415b";
    hash = "sha256-1S3y4bKd3j5pL4jFVoSg2pzxf54hAQX3V/6A6zHAO6U=";
  };

  # Updates to work with 1.80
  cargoPatches = [ ./mipsy.patch ./mipsy-build.patch ./mipsy-version.patch ./mipsy-git.patch ];

  cargoHash = "sha256-NW0aboaY0mV5zKqOZwAo//zHQ8Dk0qvKxnRyr6YkdDE=";

}
