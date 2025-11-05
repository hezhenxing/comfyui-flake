# comfyui-flake

ComfyUI as Nix flake expression.

```shell
nix run github:hezhenxing/comfyui-flake
```

This will automatically create a directory `comfyui` as the ComfyUI working state directory and setup an overlay filesystem with all the dependencie, and then start the ComfyUI server.
