{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-videohelpersuite";
  version = "1.7.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Kosinkadink";
    repo = "ComfyUI-VideoHelperSuite";
    rev = "8923bd836bdab8b7bbdf4ed104b7d045e70c66e2";
    hash = "sha256-NSN0yDJ7c+MqMO4thVCuDKuGrkgTcFYMlQsv1UGWMNM=";
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
    imageio-ffmpeg
    opencv-python
  ];
}
