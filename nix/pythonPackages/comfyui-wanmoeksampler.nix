{
  python,
  buildPythonPackage,
  fetchFromGitHub,
  ...
}:
buildPythonPackage rec {
  pname = "comfyui-wanmoeksampler";
  version = "1.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "stduhpf";
    repo = "ComfyUI-WanMoeKSampler";
    rev = "ee8fa8ffb356dc5d9f456a0cdb211e60e543cb59";
    hash = "sha256-pR4/IHnaj4N/zgI+9yM+iTQcb8aOYwBMQnbSfSA7QV8=";
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
  ];
}
