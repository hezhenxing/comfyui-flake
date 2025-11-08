{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-comfyroll-customnodes";
  version = "1.76";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Suzie1";
    repo = "ComfyUI_Comfyroll_CustomNodes";
    rev = "d78b780ae43fcf8c6b7c6505e6ffb4584281ceca";
    hash = "sha256-+qhDJ9hawSEg9AGBz8w+UzohMFhgZDOzvenw8xVVyPc=";
  };

  passthru.comfyui.extension = true;

  postPatch = ''
    sed -i 's:"/usr/share/fonts/truetype":os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), "fonts"):' nodes/nodes_graphics_text.py
    cat <<EOF >> pyproject.toml
    [project]
    name = "comfyroll_customnodes"
    version = "${version}"
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
  ];
}
