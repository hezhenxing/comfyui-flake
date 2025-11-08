{
  pkgs,
  python,
  buildPythonPackage,
  fetchFromGitHub,
  cudaPackages,
  linuxPackages,
  ...
}:
buildPythonPackage rec {
  pname = "sageattention";
  version = "2.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    inherit pname version;
    owner = "thu-ml";
    repo = "SageAttention";
    rev = "v${version}";
    hash = "sha256-luHu7BkOLRg1LfwNvj3ieeaRSYHNYciMK56MCzkUQd4=";
  };

  postPatch = ''
    cat <<EOF > pyproject.toml
    [build-system]
    requires = [
      "setuptools",
      "wheel",
      "packaging",
    ]
    build-backend = "setuptools.build_meta"
    EOF
  '';

  TORCH_CUDA_ARCH_LIST = "8.9";

  NIX_CFLAGS_COMPILE = [
    "-I${python.pkgs.pybind11}/include"
  ];

  nativeBuildInputs =
    with cudaPackages;
    [
      cudatoolkit
      cuda_cudart
      cuda_nvcc
      cuda_cccl
      libcusparse
      libcublas
      libcusolver
    ]
    ++ (with python.pkgs; [
      pybind11
      torch
      setuptools
      build
      wheel
      packaging
    ]);

  dependencies = with python.pkgs; [
  ];
}
