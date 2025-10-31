{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  chardet,
  gitpython,
  huggingface-hub,
  matrix-nio,
  pygithub,
  rich,
  toml,
  transformers,
  typer,
  typing-extensions,
  uv,
}:

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

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
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

  pythonImportsCheck = [
    "comfyui_manager"
  ];

  meta = {
    description = "ComfyUI-Manager is an extension designed to enhance the usability of ComfyUI. It offers management functions to install, remove, disable, and enable various custom nodes of ComfyUI. Furthermore, this extension provides a hub feature and convenience functions to access a wide range of information within ComfyUI";
    homepage = "https://github.com/Comfy-Org/ComfyUI-Manager";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
  };
}
