{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfyui_workflow_templates";
  version = "0.2.4";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-YAjMHt7ZV+0RRcr0k5c+06+pNKLNY6qVqiqzUTBc6SI=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
  ];
}
