{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "spandrel";
  version = "0.4.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-ZG2YFqlC5Z1WqrLckENTlS5X3uSyyz9Z9+pNwPsRofI=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    torch
    torchvision
    safetensors
    numpy
    einops
    typing-extensions
  ];
}
