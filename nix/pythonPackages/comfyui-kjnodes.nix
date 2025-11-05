{
  python,
  fetchFromGitHub,
  buildPythonPackage,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-kjnodes";
  version = "1.1.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "kijai";
    repo = "ComfyUI-KJNodes";
    rev = "6c996e1877db08c7de020ee14421dd28d7574ec2";
    hash = "sha256-dh7c7Qu5YW7t3NNvP1KTC+qbDkv6rg6IuCNwNqBZGK0=";
  };

  passthru.comfyui = {
    extension = true;
  };

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
    pillow
    scipy
    color-matcher
    matplotlib
    huggingface-hub
    mss
    opencv-python
    torchlibrosa
  ];
}
