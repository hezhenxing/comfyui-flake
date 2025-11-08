{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "colour-science";
  version = "0.4.6";
  pyproject = true;

  src = fetchPypi {
    pname = "colour_science";
    inherit version;
    hash = "sha256-vpjCybKlyvDEQ0MfQCWZyp4cx9lEu4BBVoA7zJevTPA=";
  };

  nativeBuildInputs = with python.pkgs; [
    hatchling
  ];

  propagatedBuildInputs = with python.pkgs; [
    imageio
    numpy
    scipy
    typing-extensions
  ];
}
