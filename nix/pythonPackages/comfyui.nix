{
  lib,
  python,
  buildPythonPackage,
  fetchFromGitHub,
  extensions ? [ ],
  ...
}:
buildPythonPackage rec {
  pname = "comfyui";
  version = "0.3.67";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "comfyanonymous";
    repo = "ComfyUI";
    rev = "v${version}";
    hash = "sha256-/zfs6HqhpgsblG4MgDPN9ZGz5abwHNkHrGq3uX/f6pQ=";
  };

  postPatch = ''
    sed -i 's/^if __name__ == "__main__":/def main():/' main.py
    cat <<EOF >> pyproject.toml
    [build-system]
    requires = ["hatchling"]
    build-backend = "hatchling.build"

    [tool.hatch.build]
    include = ["*"]

    [project.scripts]
    comfyui = "main:main"
  '';

  build-system = with python.pkgs; [
    hatchling
  ];

  dependencies =
    extensions
    ++ (with python.pkgs; [
      comfyui-frontend-package
      comfyui-workflow-templates
      comfyui-embedded-docs

      torch
      torchsde
      torchvision
      torchaudio
      numpy
      einops
      transformers
      tokenizers
      sentencepiece
      safetensors
      aiohttp
      yarl
      pyyaml
      pillow
      scipy
      tqdm
      psutil
      alembic
      sqlalchemy
      av

      #non essential dependencies:
      kornia
      spandrel
      pydantic
      pydantic-settings
    ]);
}
