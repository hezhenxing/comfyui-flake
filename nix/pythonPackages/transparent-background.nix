{
  fetchPypi,
  python,
  ...
}:
python.pkgs.buildPythonPackage rec {
  pname = "transparent-background";
  version = "1.3.4";
  pyproject = true;

  src = fetchPypi {
    pname = "transparent_background";
    inherit version;
    hash = "sha256-KAFOzgrlt3YPfBIjGEDbP1rRtJOWjQ19vOSgeeIG36Y=";
  };

  postPatch = ''
    sed -i '/^os.makedirs/d' setup.py
  '';

  nativeBuildInputs = with python.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python.pkgs; [
    torch
    torchvision
    opencv-python
    timm
    tqdm
    kornia
    gdown
    wget
    easydict
    albumentations
    albucore
    pymatting
    pyvirtualcam
    flet
    pyyaml
  ];
}
