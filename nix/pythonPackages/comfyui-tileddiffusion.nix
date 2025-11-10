{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-tileddiffusion";
  version = "0.0.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "shiimizu";
    repo = "ComfyUI-TiledDiffusion";
    rev = "a155b1bac39147381aeaa52b9be42e545626a44f";
    hash = "sha256-UDcjTWyA2kQKyeX5pZuvX0RnVAz56WCbak0JGSy4w0Y=";
  };

  passthru.comfyui.extension = true;

  postPatch = ''
    cat <<EOF >> pyproject.toml
    [project]
    name = "${pname}"
    version = "${version}"

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
  ];
}
