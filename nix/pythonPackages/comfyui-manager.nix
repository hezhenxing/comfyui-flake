{
  lib,
  pkgs,
  python,
  fetchFromGitHub,
}:
let
  inherit (python.pkgs) buildPythonPackage;
in
buildPythonPackage rec {
  pname = "comfyui-manager";
  version = "3.35";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Comfy-Org";
    repo = "ComfyUI-Manager";
    rev = version;
    hash = "sha256-JNwHBnY+Gm2rQ2vZ0cVLLuM+5zrR3ebC/EZfH1lRnWA=";
  };

  passthru.comfyui.extension = false;

  build-system = with python.pkgs; [
    hatchling
  ];

  dependencies = with python.pkgs; [
    chardet
    gitpython
    huggingface-hub
    matrix-nio
    pygithub
    rich
    toml
    transformers
    typer
    typing-extensions
    uv
  ];

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
  '';

  meta = {
    description = "ComfyUI-Manager is an extension designed to enhance the usability of ComfyUI. It offers management functions to install, remove, disable, and enable various custom nodes of ComfyUI. Furthermore, this extension provides a hub feature and convenience functions to access a wide range of information within ComfyUI";
    homepage = "https://github.com/Comfy-Org/ComfyUI-Manager";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
  };
}
