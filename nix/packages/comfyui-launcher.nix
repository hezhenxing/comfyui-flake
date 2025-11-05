{
  lib,
  pkgs,
  python3,
  python3Packages,
  ...
}:
let
  inherit (builtins) attrValues mapAttrs;
  inherit (lib)
    filterAttrs
    hasPrefix
    join
    pipe
    ;
  inherit (python3) sitePackages;
  extensions = pipe python3Packages [
    (filterAttrs (n: p: hasPrefix "comfyui-" n && (p.passthru.comfyui.extension or false)))
    attrValues
  ];
  extDirs = pipe extensions [
    (map (ext: ext.src.repo))
    (join " ")
  ];
  extArg = ext: "--overlay-src ${ext}/${sitePackages}";
  extArgs = pipe extensions [
    (map extArg)
    (join " ")
  ];
  comfyui = python3Packages.comfyui.override { inherit extensions; };

in
pkgs.writeShellScriptBin "comfyui-launcher" ''
  trap 'rmdir .work/work .work' EXIT
  mkdir -p comfyui .work/work
  mkdir -p comfyui/{input,output,custom_nodes}
  for d in ${extDirs}; do
    mkdir -p comfyui/custom_nodes/$d
  done
  ${pkgs.bubblewrap}/bin/bwrap \
    --dev-bind / / \
    ${extArgs} \
    --overlay-src ${comfyui}/${sitePackages} \
    --overlay $PWD/comfyui $PWD/.work ${comfyui}/${sitePackages} \
    ${comfyui}/bin/comfyui
''
