{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wasi-sdk.url = "github:michaelfranzl/wasi-sdk-nixos?ref=v3.0.0";
  };

  outputs =
    {
      self,
      nixpkgs,
      wasi-sdk,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {

      packages.x86_64-linux.default = import ./default.nix {
        inherit pkgs;
        wasi-sdk = wasi-sdk.packages.x86_64-linux.default;
      };

      apps.x86_64-linux.default =
        let
          server = pkgs.writeShellApplication {
            name = "serve";
            runtimeInputs = [
              pkgs.coreutils
              pkgs.python3
            ];
            text = ''
              env -C examples python3 -m http.server 8000 --bind 127.0.0.1
            '';
          };
        in
        {
          type = "app";
          program = "${server}/bin/serve";
        };

      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
