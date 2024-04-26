{
  description = "NVFlash tool for linux";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.${system} = {
      default = with pkgs; stdenv.mkDerivation {
        name = "nvflash";
        version = "5.833";

        src = self;

        installPhase = ''
          runHook preInstall

          mkdir -p $out/bin
          install -Dm755 nvflash $out/bin/nvflash

          runHook postInstall
        '';
      };
    };
  };
}
