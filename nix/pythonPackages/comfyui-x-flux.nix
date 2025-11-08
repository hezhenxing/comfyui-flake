{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-x-flux";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "XLabs-AI";
    repo = "x-flux-comfyui";
    rev = "00328556efc9472410d903639dc9e68a8471f7ac";
    hash = "sha256-9487Ijtwz0VZGOHknMTbrJgZHsNjDHJnLK9NtohpO0A=";
  };

  passthru.comfyui.extension = true;

  postPatch = ''
    sed -i 's/einops==0.8.0/einops/' requirements.txt pyproject.toml
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
    gitpython
    einops
    transformers
    diffusers
    sentencepiece
    opencv-python
  ];
}
