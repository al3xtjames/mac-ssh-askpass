{
  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin"; };

  outputs = { self, nixpkgs, }:
    let systems = [ "aarch64-darwin" "x86_64-darwin" ];
    in {
      packages = nixpkgs.lib.genAttrs systems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in rec {
          default = mac-ssh-askpass;
          mac-ssh-askpass = pkgs.swiftPackages.callPackage ./default.nix {
            inherit (pkgs.darwin.apple_sdk_11_0.frameworks) AppKit Foundation;
          };
        }
      );
    };
}