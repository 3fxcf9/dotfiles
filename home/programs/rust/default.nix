{unstable, ...}: {
  home.packages = with unstable; [
    rustc
    cargo
    rust-analyzer
    rustfmt
    gcc
  ];
}
