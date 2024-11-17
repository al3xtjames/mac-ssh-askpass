{ lib
, stdenv
, swift
, swiftpm
}:

stdenv.mkDerivation {
  pname = "mac-ssh-askpass";
  version = "0.1.0";

  src = ./.;

  strictDeps = true;

  nativeBuildInputs = [
    swift
    swiftpm
  ];

  installPhase = ''
    runHook preInstall

    binPath="$(swiftpmBinPath)"
    install -D $binPath/mac-ssh-askpass $out/bin/mac-ssh-askpass

    runHook postInstall
  '';

  meta = with lib; {
    description = "(Incomplete) ssh-askpass(1) implementation for macOS";
    homepage = "https://github.com/al3xtjames/mac-ssh-askpass";
    license = licenses.bsd0;
    maintainers = with maintainers; [ al3xtjames ];
    platforms = platforms.darwin;
  };
}
