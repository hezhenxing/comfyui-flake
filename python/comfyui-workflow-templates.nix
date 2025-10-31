{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfyui_workflow_templates";
  version = "0.2.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-B4QaZYQR2YqbJj20BHiZtiwYwH7/Lsf57M0MXDs3lM4=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
  ];
}
