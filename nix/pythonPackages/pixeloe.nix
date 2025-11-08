{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "pixeloe";
  version = "0.1.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-LWuVp6elV+B6bxV41tr6iErcQlzBqxbYzsLm/yZZSQE=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    opencv-python
    numpy
    pillow
    torch
    kornia
  ];
}
