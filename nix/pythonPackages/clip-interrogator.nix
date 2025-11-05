{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "clip-interrogator";
  version = "0.6.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-55Qjcv6blhgYgfcIPjF53nRuWbDjxBmfs+Phm+9CFpM=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    torch
    torchvision
    pillow
    requests
    safetensors
    tqdm
    open-clip-torch
    accelerate
    transformers
  ];
}
