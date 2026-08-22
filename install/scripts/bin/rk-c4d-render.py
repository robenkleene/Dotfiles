#!/usr/bin/env python3
"""Render a Cinema 4D scene described by a Python file.

    rk-c4d-render glass_sphere.py

The scene file runs inside a headless Cinema 4D session and must define
`build(doc, ctx)`; see `scene_runner.py` in the loader folder for the full
contract. Output goes to `./renders/<scene name>.png`.

The loader folder lives outside this script, in the Cinema 4D application
settings; point `--loader-dir` or `C4D_LOADER_DIR` elsewhere to override.
"""

import argparse
import importlib.util
import os
import shutil
import subprocess
import sys
import tempfile
import time

default_c4d = (
    "/Applications/Maxon Cinema 4D 2026/Cinema 4D.app/Contents/MacOS/Cinema 4D"
)
default_loader_dir = os.path.expanduser(
    "~/Developer/Settings/Apps/Cinema 4D/c4d_loader"
)
default_size = (1600, 1200)
preview_size = (800, 600)

# Everything Cinema 4D needs from the loader folder. `c4d_loader.pyp` is the file
# Cinema 4D itself loads; the other two are imported by it.
loader_files = ("c4d_loader.pyp", "scene_runner.py", "protocol.py")


def fail(message):
    sys.stderr.write("error: %s\n" % message)
    raise SystemExit(1)


def load_protocol(loader_dir):
    """Import `protocol.py` out of the loader folder, wherever it is installed.

    `protocol` is the single definition of the environment variable names this
    script and the loader agree on. It cannot be a plain `import` at the top of
    the file, because the loader folder is only known once `--loader-dir` has
    been parsed, and it lives outside this script's own directory.
    """
    missing = [
        name
        for name in loader_files
        if not os.path.isfile(os.path.join(loader_dir, name))
    ]
    if missing:
        fail(
            "Cinema 4D loader not found in: %s\n"
            "       missing: %s\n"
            "       set --loader-dir or C4D_LOADER_DIR"
            % (loader_dir, ", ".join(missing))
        )

    path = os.path.join(loader_dir, "protocol.py")
    spec = importlib.util.spec_from_file_location("protocol", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def parse_args(argv):
    parser = argparse.ArgumentParser(
        description="Render a Cinema 4D scene described by a Python file.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("scene", help="Python file defining build(doc, ctx)")
    parser.add_argument(
        "-o", "--output-dir", default="renders", help="where to write the render"
    )
    parser.add_argument("-w", "--width", type=int, help="render width in pixels")
    parser.add_argument("--height", type=int, help="render height in pixels")
    parser.add_argument(
        "-p",
        "--preview",
        action="store_true",
        help="render small with cheap anti-aliasing, and set ctx.preview",
    )
    parser.add_argument(
        "--c4d",
        default=os.environ.get("C4D_BIN", default_c4d),
        help="Cinema 4D binary (also settable with C4D_BIN)",
    )
    parser.add_argument(
        "--loader-dir",
        default=os.environ.get("C4D_LOADER_DIR", default_loader_dir),
        help="folder holding c4d_loader.pyp (also settable with C4D_LOADER_DIR)",
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="echo all of Cinema 4D's console output, not just progress",
    )
    return parser.parse_args(argv)


def run_cinema4d(binary, env, log_path, log_prefix, verbose):
    """Run Cinema 4D headless, logging everything and echoing progress lines."""
    with open(log_path, "w") as log_file, open(os.devnull) as devnull:
        # Cinema 4D spins at 100% CPU on EOF from a closed pipe, so hand it
        # `/dev/null` rather than letting `Popen` close stdin.
        process = subprocess.Popen(
            [binary, "-nogui"],
            stdin=devnull,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            env=env,
            text=True,
        )
        for line in process.stdout:
            log_file.write(line)
            if verbose or line.startswith(log_prefix):
                sys.stdout.write(line)
                sys.stdout.flush()
        process.wait()


def report_failure(log_path):
    sys.stderr.write("error: render failed, see %s\n" % log_path)
    with open(log_path) as handle:
        lines = handle.readlines()
    for index, line in enumerate(lines):
        if line.startswith("Traceback"):
            sys.stderr.writelines(lines[index:])
            break
    raise SystemExit(1)


def main(argv):
    args = parse_args(argv)

    scene = os.path.abspath(args.scene)
    if not os.path.isfile(scene):
        fail("no such scene file: %s" % scene)
    if not os.access(args.c4d, os.X_OK):
        fail("Cinema 4D not found at: %s (set --c4d or C4D_BIN)" % args.c4d)

    loader_dir = os.path.abspath(os.path.expanduser(args.loader_dir))
    protocol = load_protocol(loader_dir)

    width, height = preview_size if args.preview else default_size
    width = args.width or width
    height = args.height or height

    output_dir = os.path.abspath(args.output_dir)
    os.makedirs(output_dir, exist_ok=True)
    log_path = os.path.join(output_dir, "render.log")

    # Stamped once here rather than in the runner, so every file a single run
    # produces carries the same value.
    timestamp = int(time.time())

    print("rendering %s at %dx%d" % (os.path.basename(scene), width, height))
    print("log: %s" % log_path)

    status_dir = tempfile.mkdtemp(prefix="c4d-render-")
    status_path = os.path.join(status_dir, "status")
    try:
        env = dict(os.environ)
        env.update(
            protocol.encode(
                loader_dir=loader_dir,
                scene=scene,
                output_dir=output_dir,
                width=width,
                height=height,
                preview=args.preview,
                timestamp=timestamp,
                status_path=status_path,
            )
        )
        run_cinema4d(args.c4d, env, log_path, protocol.log_prefix, args.verbose)
        status = ""
        if os.path.isfile(status_path):
            with open(status_path) as handle:
                status = handle.read().strip()
    finally:
        shutil.rmtree(status_dir, ignore_errors=True)

    if status != protocol.status_ok:
        report_failure(log_path)

    name = os.path.splitext(os.path.basename(scene))[0]
    print("done: %s" % os.path.join(
        output_dir, protocol.output_name(name, timestamp, "png")
    ))


if __name__ == "__main__":
    main(sys.argv[1:])
