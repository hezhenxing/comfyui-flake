{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "conformer";
  version = "0.3.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Mu80+kYf8y4cMwYQJcD1g4hPGdLwq6IAI09Odx93fto=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    torch
    einops
  ];
}
