{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-chatterbox";
  version = "1.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "wildminder";
    repo = "ComfyUI-ChatterBox";
    rev = "f0300cf84ee1b8fc9cbd38cb68cb3bace1895063";
    hash = "sha256-cAevPoz1Ru1Yv+U5FnPYfNHFWiOHXMHzaVxBZz0FPJg=";
  };

  passthru.comfyui.extension = true;

  postPatch = ''
    cat <<EOF >> pyproject.toml
    [build-system]
    requires = ["hatchling"]
    build-backend = "hatchling.build"

    [tool.hatch.build]
    ignore-vcs = true
    include = ["*"]
    exclude = [".*"]

    [tool.hatch.build.targets.wheel.sources]
    "" = "custom_nodes/${src.repo}"
    EOF
  '';

  pytestCheckPhase = ''
    # skip check
  '';

  nativeBuildInputs = with python.pkgs; [
    hatchling
  ];

  dependencies = with python.pkgs; [
    torch
    torchaudio
    librosa
    numpy
    huggingface-hub
    einops
    scipy
    tokenizers
    soundfile
    s3tokenizer
    conformer
    safetensors
    transformers
    diffusers
  ];
}
