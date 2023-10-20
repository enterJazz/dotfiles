{
  pkgs ? import <nixpkgs> {}
}:
pkgs.mkShell
{
  buildInputs = with pkgs;
  [
    cargo
    rustc
    rustfmt
    rust-analyzer
    clippy
  ];
  RUST_BACKTRACE = 1;
}

