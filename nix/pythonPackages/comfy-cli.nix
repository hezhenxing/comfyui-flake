{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "comfy_cli";
  version = "1.5.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-F/P6z7HCxJEs9e/zUsQJO76oVxyBc7zlEoMAiwbb6ag=";
  };

  postPatch = ''
    sed -i 's/click<=8.1.8/click/' pyproject.toml
  '';

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    charset-normalizer
    click
    cookiecutter
    gitpython
    httpx
    mixpanel
    packaging
    pathspec
    pip
    psutil
    pyyaml
    questionary
    requests
    rich
    ruff
    semver
    tomlkit
    typer
    typing-extensions
    uv
    websocket-client
  ];
}
