{
  pkgs,
  fetchFromGitHub,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "s3tokenizer";
  version = "0.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "xingchensong";
    repo = "S3Tokenizer";
    rev = "8038afee628b4f4b90b30ac9ed4e0d0f16f78903";
    hash = "sha256-uicRo3hhTYYtkgiw9RlGjdC/es5ywWGaJKWnSK8xQP4=";
  };

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  postPatch = ''
    sed -i '/pre-commit/d' requirements.txt
  '';

  doCheck = false;

  propagatedBuildInputs = with python.pkgs; [
    numpy
    torch
    onnx
    onnxruntime
    tqdm
    torchaudio
    einops
  ];
}
