{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-randomseedgenerator";
  version = "1.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Limbicnation";
    repo = "ComfyUI-RandomSeedGenerator";
    rev = "928cbec8c362ca56e2ffd2cec69d92f80a61b3c3";
    hash = "sha256-B1H1xsglNrg0oev8mR6WcoOC/HaG1Q8PTaF0OshkGDk=";
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
  ];
}
