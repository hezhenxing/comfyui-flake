{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfyui_embedded_docs";
  version = "0.3.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-pUUVY0QS98J6ChHwwyiHKJnTeVjrrqv+qfepp03OpnA=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
  ];
}
