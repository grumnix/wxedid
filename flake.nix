{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";

    wxedid_src.url = "https://sourceforge.net/projects/wxedid/files/wxedid-0.0.27.tar.gz";
    wxedid_src.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, wxedid_src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = wxedid;

          wxedid = pkgs.stdenv.mkDerivation rec {
            pname = "wxedid";
            version = "0.0.27";

            src = wxedid_src;

            postPatch = ''
              patchShebangs .
            '';

            nativeBuildInputs = with pkgs; [
              autoreconfHook
            ];

            buildInputs = with pkgs; [
              wxGTK30
            ];
          };
        };
      }
    );
}
