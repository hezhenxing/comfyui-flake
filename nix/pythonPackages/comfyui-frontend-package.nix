{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfyui_frontend_package";
  version = "1.31.1";
  pyproject = true;

  COMFYUI_FRONTEND_VERSION = version;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-e8m/vRRf4BYuIMMDBVGQ5d6ayzdM7SjHij+DfNN4WRA=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
  ];
}
