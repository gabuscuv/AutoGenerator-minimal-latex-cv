{
  description = "TeX Live environment ready for developercv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-small
          moresize
          latex-uni8
          collection-fontsrecommended
          collection-latexrecommended
          ;
      };

    in
    {
      packages.${system}.texlive-resumeReady = pkgs.buildEnv {
        name = "texlive-resumeReady";
        paths = [
          tex
          pkgs.qpdf
        ];
      };
      defaultPackage.${system} = self.packages.${system}.texlive-resumeReady;

      devShell.${system} = pkgs.mkShell {
        buildInputs = [
          self.packages.${system}.texlive-resumeReady
        ];
      };
    };
}
