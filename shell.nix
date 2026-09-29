{ pkgs ? import  { system = "x86_64-linux"; } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # Core build systems
    gnumake
    cmake
    ninja
    pkg-config
    binutils
    gdb

    # Development runtimes and compilers
    cargo
    rustc
    rustfmt
    clippy
    nodejs_20

    # Utilities
    ripgrep
    llama-cpp
  ];

  NIX_ENFORCE_PURITY = 0;

  shellHook = ''
    echo "Nix Build and Development Shell Active."
    export PATH="\(HOME/.cargo/bin:\)PATH"
    exec zsh -i
  '';
}
