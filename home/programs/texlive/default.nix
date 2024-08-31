{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-full;
      custom-latex-course-class = {
        pkgs = [
          inputs.custom-latex-course-class.packages.${pkgs.system}.default
        ];
      };
    })
  ];
}
