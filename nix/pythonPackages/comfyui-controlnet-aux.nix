{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-controlnet-aux";
  version = "1.1.3";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Fannovel16";
    repo = "comfyui_controlnet_aux";
    rev = "12f35647f0d510e03b45a47fb420fe1245a575df";
    hash = "sha256-pZep/vyHtAHplFJhG/ILg45ogTVNxpKJSCqw/HUOx2E=";
  };

  passthru.comfyui.extension = true;

  postPatch = ''
    cat <<EOF >> pyproject.toml
    [build-system]
    requires = ["hatchling"]
    build-backend = "hatchling.build"

    [tool.hatch.build]
    include = ["*"]
    exclude = [".*"]

    [tool.hatch.build.targets.wheel.sources]
    "" = "custom_nodes/${src.repo}"
    EOF
  '';

  nativeBuildInputs = with python.pkgs; [
    hatchling
  ];

  dependencies = with python.pkgs; [
    torch
    importlib-metadata
    huggingface-hub
    scipy
    opencv-python
    filelock
    numpy
    pillow
    einops
    torchvision
    pyyaml
    scikit-image
    python-dateutil
    mediapipe
    fvcore
    yapf
    omegaconf
    ftfy
    addict
    yacs
    yapf
    trimesh
    albumentations
    scikit-learn
    matplotlib
  ];
}
