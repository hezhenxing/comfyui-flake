{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfyui_frontend_package";
  version = "1.30.1";
  pyproject = true;

  COMFYUI_FRONTEND_VERSION = version;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-kmZGG4IgQKpoy72oaeJ8zJdLcdqzqPOTv2y/FXyoSW8=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
  ];
}
