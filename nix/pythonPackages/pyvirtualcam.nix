{
  pkgs,
  fetchFromGitHub,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "pyvirtualcam";
  version = "0.14.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "letmaik";
    repo = "pyvirtualcam";
    rev = "v${version}";
    hash = "sha256-97pPws/1AJ2WTw70TE2qDqoLgwLZo3oCSmJMzwgS5/U=";
  };

  NIX_CFLAGS_COMPILE = [
    "-I${pkgs.libyuv}/include"
  ];

  nativeBuildInputs = with python.pkgs; [
    setuptools
    opencv-python
    imageio
    pybind11
    pkgs.libyuv
  ];

  propagatedBuildInputs = with python.pkgs; [
    imageio
    opencv-python
  ];
}
