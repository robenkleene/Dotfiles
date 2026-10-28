#!/usr/bin/env python3
"""Flatten the presentation UI of a Max patch into a single patch.

    rk-max-ui.py -s Foo.maxpat -d bar/FooUi.maxpat

Every object with `"presentation" : 1` is copied into the destination at the
position it's displayed at, recursing into `bpatcher` objects, so the whole
interface can be laid out in one patch instead of one `bpatcher` at a time. The
copy is one way, edits in the destination don't flow back into the source.

What's copied is what's visible when the patch loads:
* Objects with `"hidden" : 1` are skipped, along with their contents
* Objects outside a `bpatcher`'s visible area are skipped, so for tabs that are
  pages scrolled into view with `offset`, only the default page is copied
* `#1`, `#2`, etc. are replaced with the `bpatcher`'s `args`

Each copied object's `varname` is set to its path through the `bpatcher`
hierarchy, e.g., `DrumSynthRack::DrumSynthBank::1-DrumSynth::AdEnv::Attack`,
to show where it came from.
"""

import argparse
import copy
import json
import os
import re
import sys

def main():
    parser = argparse.ArgumentParser(
        description="Flatten the presentation UI of a Max patch into one patch"
    )
    parser.add_argument("-s", "--src", required=True, help="source `.maxpat`")
    parser.add_argument("-d", "--dst", required=True, help="destination `.maxpat`")
    args = parser.parse_args()

    src = os.path.abspath(args.src)
    root = load_patch(src)["patcher"]
    search_dirs = patch_dirs(os.path.dirname(src))

    boxes = []
    flatten(root, (0.0, 0.0), None, [], [], search_dirs, boxes)
    if not boxes:
        sys.exit("error: no presentation objects found in " + args.src)

    for index, box in enumerate(boxes):
        box["id"] = "obj-" + str(index + 1)
        # Lay the patching view out the same way, so either view is usable
        box["patching_rect"] = list(box["presentation_rect"])
    right = max(box["presentation_rect"][0] + box["presentation_rect"][2] for box in boxes)
    bottom = max(box["presentation_rect"][1] + box["presentation_rect"][3] for box in boxes)

    # Keep the source's patcher attributes (fonts, colors, etc.)
    patcher = {key: value for key, value in root.items() if key not in ("boxes", "lines")}
    window = patcher.get("rect", [100.0, 100.0, 0.0, 0.0])
    patcher["rect"] = [window[0], window[1], right, bottom]
    patcher["openinpresentation"] = 1
    patcher["boxes"] = [{"box": box} for box in boxes]
    patcher["lines"] = []

    with open(args.dst, "w") as f:
        json.dump({"patcher": patcher}, f, indent=4)
        f.write("\n")
    print("Wrote {} objects to {}".format(len(boxes), args.dst))


def flatten(patcher, origin, clip, path, args, search_dirs, out):
    """Appends `patcher`'s visible presentation objects to `out`.

    `origin` is where the patcher's presentation `0, 0` lands in the
    destination, and `clip` is the destination rect it's visible within (`None`
    for the top level patch).
    """
    for entry in patcher.get("boxes", []):
        box = substitute(entry["box"], args)
        if not box.get("presentation") or box.get("hidden"):
            continue
        x, y, width, height = box.get("presentation_rect", box.get("patching_rect"))
        rect = [origin[0] + x, origin[1] + y, width, height]
        if clip and not overlaps(rect, clip):
            continue
        name = box.get("varname", box["maxclass"])

        if box["maxclass"] == "bpatcher":
            sub = bpatcher_patcher(box, search_dirs)
            if sub is None:
                print("warning: couldn't find " + box.get("name", "embedded patcher"), file=sys.stderr)
                continue
            offset = box.get("offset", [0.0, 0.0])
            sub_clip = intersect(rect, clip) if clip else rect
            sub_args = [str(arg) for arg in box.get("args", [])]
            flatten(sub, (rect[0] - offset[0], rect[1] - offset[1]), sub_clip,
                    path + [name], sub_args, search_dirs, out)
            continue

        copied = copy.deepcopy(box)
        copied["presentation_rect"] = rect
        copied["varname"] = "::".join(path + [name])
        out.append(copied)


def substitute(value, args):
    """Replaces `#1`, `#2`, etc. in every string in `value` with `args`."""
    if not args:
        return value
    if isinstance(value, str):
        return re.sub(r"#(\d+)",
                      lambda m: args[int(m.group(1)) - 1] if 0 < int(m.group(1)) <= len(args) else m.group(0),
                      value)
    if isinstance(value, list):
        return [substitute(item, args) for item in value]
    if isinstance(value, dict):
        # The embedded patcher of a `bpatcher` gets its own `args`
        return {key: item if key == "patcher" else substitute(item, args) for key, item in value.items()}
    return value


def bpatcher_patcher(box, search_dirs):
    """Returns the patcher a `bpatcher` displays, embedded or from its file."""
    if box.get("embed") and "patcher" in box:
        return box["patcher"]
    name = box.get("name")
    for directory in search_dirs:
        path = os.path.join(directory, name)
        if os.path.isfile(path):
            return load_patch(path)["patcher"]
    return None


def patch_dirs(directory):
    """Returns `directory` and its subdirectories, where `bpatcher` files are looked up."""
    dirs = [directory]
    for current, subdirs, _ in os.walk(directory):
        subdirs[:] = sorted(d for d in subdirs if not d.startswith("."))
        dirs += [os.path.join(current, d) for d in subdirs]
    return dirs


def load_patch(path):
    with open(path) as f:
        return json.load(f)


def overlaps(a, b):
    return a[0] < b[0] + b[2] and b[0] < a[0] + a[2] and a[1] < b[1] + b[3] and b[1] < a[1] + a[3]


def intersect(a, b):
    left, top = max(a[0], b[0]), max(a[1], b[1])
    right, bottom = min(a[0] + a[2], b[0] + b[2]), min(a[1] + a[3], b[1] + b[3])
    return [left, top, right - left, bottom - top]


if __name__ == "__main__":
    main()
