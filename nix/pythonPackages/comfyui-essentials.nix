{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-essentials";
  version = "1.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "cubiq";
    repo = "ComfyUI_essentials";
    rev = "9d9f4bedfc9f0321c19faf71855e228c93bd0dc9";
    hash = "sha256-wkwkZVZYqPgbk2G4DFguZ1absVUFRJXYDRqgFrcLrfU=";
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
    numba
    colour-science
    rembg
    pixeloe
    transparent-background
  ];
}
