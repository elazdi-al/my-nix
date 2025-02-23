{ config, pkgs, lib, ... }:

let
  # Define default values in one place
  defaultVersion = "0.4.1"
  defaultSha256 = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";

  # Use the configured version or fall back to the default
  version = config.barik or defaultVersion;
  sha256 = defaultSha256;  # You could similarly allow overriding this via config if desired

  # Construct the download URL once based on the version
  url = "https://github.com/mocki-toki/barik/releases/download/v${version}/barik.zip";

  # Fetch the release artifact
  barikZip = pkgs.fetchzip {
    inherit url sha256;
  };
in {
  options.barik = lib.mkOption {
    type = lib.types.str;
    default = defaultVersion;
    description = "The version of barik to install.";
  };

  config = lib.mkIf config.barik != null ({
    # Install the fetched artifact as a system package
    environment.systemPackages = with pkgs; [ barikZip ];

    # Activate an installation script to copy the app into ~/Applications
    darwin.activationPackages = [
      (pkgs.writeShellScriptBin "install-barik" ''
        mkdir -p "$HOME/Applications"
        cp -R ${barikZip}/Barik.app "$HOME/Applications/"
      '')
    ];
  });
}

