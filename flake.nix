{
  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flakelight = {
      url = "github:nix-community/flakelight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flakelight,
  }: let
    inherit (builtins) mapAttrs;
    inherit (flakelight.lib) importDir;
    pyoverlays = final: _: mapAttrs (_: pkg: final.callPackage pkg {}) (importDir ./python);
  in
    flakelight ./. {
      inherit inputs;

      nixpkgs.config = {
        allowUnfree = true;
        cudaSupport = true;
      };

      withOverlays = [
        (final: prev: {
          pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [pyoverlays];
        })
      ];

      devShell.env = pkgs: {
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc.lib
          pkgs.cudaPackages.cuda_nvrtc
          #pkgs.linuxPackages.nvidia_x11
        ];
      };
      devShell.shellHook = ''
        #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(env NIXPKGS_ALLOW_UNFREE=1 nix eval --raw --impure nixpkgs#linuxPackages.nvidia_x11.outPath)/lib
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(nix eval --raw /etc/nuxos#nixosConfigurations.nuxos.config.hardware.nvidia.package.outPath)/lib
      '';
      devShell.packages = pkgs:
        with pkgs; let
          workspace = "/home/hezx/work/comfyui-flake";
          install = writeShellScriptBin "install" ''
            cd ${workspace}
            if [[ -d ComfyUI ]]; then
              echo "ComfyUI directory already exists. Skipping clone."
            else
              git clone https://github.com/Comfy-Org/ComfyUI.git ComfyUI
              git clone https://github.com/Comfy-Org/ComfyUI-Manager.git ComfyUI/custom_nodes/ComfyUI-Manager
            fi
          '';
          run = writeShellScriptBin "run" ''
            cd ${workspace}
            source venv/bin/activate
            cd ComfyUI
            python main.py
          '';
        in [
          install
          run
          pkg-config
          (pkgs.python3.withPackages (
            p:
              with p; [
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

                # ComfyUI-Manager dependencies
                gitpython
                pygithub
                matrix-nio
                transformers
                huggingface-hub
                typer
                rich
                typing-extensions
                toml
                uv
                chardet
              ]
          ))
        ];
    };
}
