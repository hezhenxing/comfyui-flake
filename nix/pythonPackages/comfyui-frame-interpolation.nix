{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-frame-interpolation";
  version = "1.0.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Fannovel16";
    repo = "ComfyUI-Frame-Interpolation";
    rev = "a969c01dbccd9e5510641be04eb51fe93f6bfc3d";
    hash = "sha256-bBtGs/LyQf7teCD7YT4dypYQTuy3ja+zV1hbQkYcGuU=";
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

  nativeBuildInputs = with python.pkgs; [
    hatchling
  ];

  dependencies = with python.pkgs; [
    torch
    numpy
    einops
    opencv-python
    kornia
    scipy
    pillow
    torchvision
    tqdm
    cupy
  ];
}
