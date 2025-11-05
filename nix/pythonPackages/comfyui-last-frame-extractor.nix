{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-last-frame-extractor";
  version = "0.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Charonartist";
    repo = "comfyui-last-frame-extractor";
    rev = "30f294b1a0a87c7abaf979f04ee74d887a87f027";
    hash = "sha256-t41rXtFlEXHBNSUk42oWwUTs3Zi3SddX3T+raaOL6vM=";
  };

  passthru.comfyui.extension = true;

  postPatch = ''
    cat <<EOF > pyproject.toml
    [project]
    name = "${pname}"
    version = "${version}"

    [project.urls]
    Repository = "${src.meta.homepage}"

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
