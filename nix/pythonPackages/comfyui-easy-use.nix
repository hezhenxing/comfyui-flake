{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-easy-use";
  version = "1.3.4";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "yolain";
    repo = "ComfyUI-Easy-Use";
    rev = "v${version}";
    hash = "sha256-TMcNJ+r5Lk119M3bxYbTts5Aa0yhUEQe6id1izrFfQU=";
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
    diffusers
    accelerate
    clip-interrogator
    lark
    onnxruntime
    opencv-python-headless
    sentencepiece
    spandrel
    matplotlib
    peft
  ];
}
