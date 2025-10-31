{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfyui_manager";
  version = "4.0.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-i7WaLslzV8ElIFK2dAeGSiEnsK3bbIJ0unOYBY4AxiA=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    gitpython
    pygithub
    transformers
    huggingface-hub
    typer
    rich
    typing-extensions
    toml
    uv
    chardet
  ];
}
