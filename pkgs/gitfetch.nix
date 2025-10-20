{
  lib,
  pkgs,
  ...
}:

pkgs.python312Packages.buildPythonApplication rec {
  pname = "gitfetch";
  version = "1.0.2";
  format = "pyproject";

  src = pkgs.fetchurl {
    url = "https://github.com/Matars/gitfetch/archive/refs/tags/v${version}.tar.gz";
    hash = "sha256-YErW48cMoIzqF7+cqSNkdrc57MWzXjghxzBL3xVqIcE=";
  };

  nativeBuildInputs = [ pkgs.python312Packages.setuptools ];

  meta = with lib; {
    description = "A neofetch alternative for GitHub quick view";
    homepage = "https://github.com/Matars/gitfetch";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
