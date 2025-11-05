{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-rgthree";
  version = "1.0.2510052058";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "rgthree";
    repo = "rgthree-comfy";
    rev = "2b9eb36d3e1741e88dbfccade0e08137f7fa2bfb";
    hash = "sha256-ttzpk6HGhVaPpTb/HVIdBrK//foikbs0g3ktGJohTNI=";
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
  ];
}
