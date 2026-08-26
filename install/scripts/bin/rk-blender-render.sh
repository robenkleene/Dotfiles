#!/bin/sh

# Renders a Blender scene script with `blender --background`, writing the
# output into ./renders relative to the current working directory. The scene
# is also saved alongside the render as a matching `.blend`, so every image
# has the file that produced it next to it.
#
# Usage:
#     rk-blender-render.sh <scene-script.py> [scene-script-args...]
#
# The scene script is expected to accept an `--output DIR` argument and write
# its render there. Any extra arguments are forwarded to the scene script:
#
#     rk-blender-render.sh scenes/glass_sphere.py --samples 512

set -eu

usage() {
    echo "usage: $(basename -- "$0") <scene-script.py> [scene-script-args...]" >&2
}

if [ "$#" -eq 0 ]; then
    usage
    exit 64
fi

scene=$1
shift

case "$scene" in
    -h | --help)
        usage
        exit 0
        ;;
esac

if [ ! -f "$scene" ]; then
    echo "$(basename -- "$0"): no such file: $scene" >&2
    exit 66
fi

# Blender resolves `--python` relative to its own working directory, so pass an
# absolute path.
scene_dir=$(CDPATH= cd -- "$(dirname -- "$scene")" && pwd)
scene_path="$scene_dir/$(basename -- "$scene")"
output_dir="$PWD/renders"

# Blender executes arguments in order, so this runs after the scene script has
# rendered and can reuse the output path it set. Saving is skipped unless that
# render actually landed on disk, so a failed scene script does not leave a
# stray `.blend` behind.
save_blend_expr='
import os

import bpy

filepath = bpy.path.abspath(bpy.context.scene.render.filepath)
if filepath and os.path.isfile(filepath):
    blend_path = os.path.splitext(filepath)[0] + ".blend"
    bpy.ops.wm.save_as_mainfile(filepath=blend_path, compress=True, copy=True)
    print("[rk-blender-render] Wrote " + blend_path)
else:
    print("[rk-blender-render] No render found at " + repr(filepath) + "; skipping .blend")
'

exec blender \
    --background \
    --factory-startup \
    --python "$scene_path" \
    --python-expr "$save_blend_expr" \
    -- \
    --output "$output_dir" \
    "$@"
