---
name: maxmsp-rnbo
description: Build and port RNBO patches (`rnbo~`, `codebox~`), including in Max for Live devices and on Ableton Push. Use when creating or editing an `rnbo~` patcher, porting MSP patches to RNBO, writing RNBO `codebox~` code, or checking RNBO patches without opening Max.
allowed-tools: Read, Write, Edit, Grep, Glob, Bash
---

# RNBO

RNBO is Max's exportable subset (C++, plugins, web). In a patch it runs inside
an `rnbo~` object, whose embedded patcher has `"classnamespace": "rnbo"`. See
the `maxmsp` and `maxmsp-m4l` skills for general patcher JSON and Max for Live
rules.

## Local References

Everything about the installed version is in the RNBO package, e.g.
`/Applications/Max.app/Contents/Resources/C74/packages/RNBO` (version in
`package-info.json`):

- `docs/refpages/rnbo/rnbo_<name>.maxref.xml`: one per object, with inlets,
  outlets and attributes. This is the authoritative list of what exists.
  Operators use word names: `*~` is `rnbo_mul~`, `+~` is `rnbo_add~`.
- `help/rnbo_<name>.maxhelp`: example patches. `rnbo_codebox~.maxhelp` has the
  best `codebox~` examples.
- `source/operators/*.js` and `server/node_modules/@rnbo/xam/objects/*.js`: the
  actual implementations (e.g. `curve.js`, `lores.js`, `filtercoeff.js`,
  `saw.js`). Read these to reproduce an object's exact algorithm in code.

## Porting MSP to RNBO

- **Check every object against the refpages first.** Missing ones in practice:
  `overdrive~`, `zmap` (use `scale`), `poly~`/`thispoly~` (use RNBO's own
  polyphony), `coll`, `pattr*`, `js`, `live.*`, `thispatcher`, `forward`.
  `t` isn't listed but `trigger` is, so use `trigger`.
- **Message boxes only accept numbers.** `$1` fails codegen with "Only numbers
  are allowed in messages". Build lists with `pack` instead.
- **`curve~` takes multi-segment lists** of value, time, curve
  groups, e.g. `0 0 0 1 2 0 0 400 -0.5`. A 0 ms group jumps. This replaces the
  common MSP `0, 1 $1 0 0 $2 -0.5` message.
- Max's `cycle~` is a cosine, and a float in its right inlet resets the phase.
- RNBO's `saw`/`rect`/`tri` use PolyBLEP, Max's use BLEP tables, so they differ
  slightly. Their sync input resets on a phasor-style wrap; a one-sample `1`
  (like `click~`) works.

## The `rnbo~` Box

```json
{
    "maxclass": "newobj", "text": "rnbo~ @title Name", "varname": "Name",
    "numinlets": 3, "numoutlets": 3, "outlettype": ["signal", "signal", "list"],
    "inletInfo": {"IOInfo": [
        {"type": "signal", "index": 1, "tag": "in1", "comment": ""},
        {"type": "signal", "index": 2, "tag": "in2", "comment": ""},
        {"type": "midi", "index": -1, "tag": "", "comment": ""}]},
    "outletInfo": {"IOInfo": [{"type": "signal", "index": 1, "tag": "out1", "comment": ""}]},
    "rnboattrcache": {}, "rnboversion": "1.4.5",
    "saved_object_attributes": {"optimization": "O1", "parameter_enable": 0, "uuid": "<uuid>"},
    "patcher": {"fileversion": 1, "classnamespace": "rnbo", "boxes": [], "lines": []}
}
```

- Inlets are the `in~` signal inlets in order, then the MIDI inlet last. The
  MIDI inlet appears when the patcher has `notein`/`midiin`. With no `in~`, the
  first inlet takes messages and the MIDI inlet is inlet 1.
- Inner boxes can be written with just `maxclass`, `text`, counts and rect. Max
  fills in `rnboinfo`, `rnbo_serial` and so on. A `codebox~` box needs
  `"maxclass": "codebox~"`, `"rnbo_classname": "codebox~"` and the code in both
  `"code"` and `"rnbo_extra_attributes": {"code": ..., "nocache": 0, "safemath": 1, "expr": ""}`.
- A `param name @value v @min a @max b` becomes a parameter named `name`, set
  from Max by sending `name <value>` to the left inlet.
- Set `parameter_enable` to 0 when nothing in Live needs to see RNBO's
  parameters. Otherwise the internal object parameters can be exposed too.

## Getting Values into `rnbo~`

`rnbo~` compiles asynchronously when the patch or device loads. **Messages sent
before it finishes are dropped** with `rnbo~: doesn't understand "<name>"`.
That includes the values Live parameters output on load.

- **Signals don't have this problem.** `sig~` holds its value, so feed control
  values as signals into `in~` inlets (`sig~` -> `send~` -> `receive~` ->
  `rnbo~`). This works across bpatchers, and it's what Thump does.
- **`param_connect`** links a UI object to an RNBO `param`
  (`"param_connect": "<rnbo~ varname>::<param>"`), but **only within the same
  patcher**. It can't reach an `rnbo~` from dials in nested bpatchers.
- Notes can go in as MIDI, e.g. `midiformat` into the MIDI inlet. Losing notes
  during the compile doesn't matter.

## `codebox~`

```js
@state phase = 0;                 // persists between samples
@state osc = new saw();           // stateful operators need @state + new
function curve(x, k) {            // functions can read @state, not top-level lets
    return pow(x, k);
}
let f = in1;                      // in1..inN are inlets; the highest used sets the count
let y = osc.next(f, 0)[0];        // multi-output operators return arrays
if (in2 > 0.5) { y = -y; }
out1 = y > 0 ? y : 0;             // ternaries, if/else, switch, for all work
```

- Operator signatures (from `source/operators`): `cycle.next(freq, phase)`,
  `saw.next(freq, sync)`, `rect.next(freq, width, sync)`,
  `tri.next(freq, width, sync)`, `noise.next()`, `pink.next()`,
  `onepole.next(x, hz)`, `rampsmooth.next(x, up, down)`,
  `sah.next(x, trig, thresh)`, `phasor.next(freq, reset)`,
  `biquad.next(x, a0, a1, a2, b1, b2)`, and
  `filtercoeff.next(freq, gain, q, type)` -> `[a0, a1, a2, b1, b2]`. Type is a
  number: 0 lowpass, 1 highpass, 2 bandpass, 3 bandstop (then peaknotch,
  lowshelf, highshelf, resonant, allpass, ...).
- Stateless functions: `clamp`, `fract`, `pow`, `exp`, `cos`, `sin`, `abs`,
  `round`, `minimum`/`maximum`, `dbtoa`, `atodb`, `mstosamps`, `samplerate()`,
  `random(lo, hi)`, constants `pi` and `twopi`. Transport: `tempo()`,
  `beattime()`.
- **`mtof` is stateful** ("Illegal use of stateful operator"). Use
  `440 * pow(2, (m - 69) / 12)`.
- **Functions can't read top-level `let` variables** ("You cannot access the
  local variable"). Pass them as arguments or make them `@state`.
- **`@param` in a `codebox~` isn't exposed as a named RNBO parameter** (it's
  constant-folded). Use `param` objects wired into inlets instead.
- There are no per-instance classes. For repeated state (several envelopes,
  two voices), generate the code with prefixed `@state` names.
- **Detecting events in signal code:** send a changing count into an inlet
  (`notein` -> `stripnote` -> `trigger b f` -> `counter` -> `+ 1` -> inlet) and
  compare it with a `@state` last value. Inlets start at 0 and `counter`'s
  first output is 0, hence the `+ 1`; otherwise the first note looks like no
  change, or a phantom trigger fires at startup.
- A message's value reaches a `codebox~` inlet before the next sample, so
  values sent right to left (velocity, pitch, then count) are all current on
  the trigger sample.

## Checking Without Max

Max's RNBO codegen is a Node server inside the package, and it can be run
directly. The skill's `scripts/` hold a harness:

```sh
# compile an `rnbo~` box (JSON of the box holding `patcher`)
node ~/.claude/skills/maxmsp-rnbo/scripts/compile.js box.json js desc.json
# -> "status Success params N inlets N outlets N", or the codegen errors

# C++ export, then render notes offline to a WAV
node ~/.claude/skills/maxmsp-rnbo/scripts/compile.js box.json cpp desc.json export.cpp
R=/Applications/Max.app/Contents/Resources/C74/packages/RNBO/source/rnbo
clang++ -std=c++17 -O2 -I$R -I$R/common -I$R/src \
    ~/.claude/skills/maxmsp-rnbo/scripts/render.cpp export.cpp $R/RNBO.cpp -o render
./render inputs.txt out.wav 2 0.1:60:100 1.1:60:100
```

- Run compile on every patcher before handing it over. It reports the same
  errors Max would, with the offending code.
- `desc.json`'s `parameters` show each param's `paramId` and `name`, and
  whether a value was constant-folded instead of becoming a parameter.
- Render to check that patches actually make sound, then measure level, decay
  and pitch from the WAV (e.g. RMS per 10 ms, zero crossings). That's how
  "silent" and "too quiet" bugs were found before the user opened anything.
- To trace a value, temporarily replace an output (`out2 = <expr>;`), compile
  and render that channel.

## Max for Live and Push

- `rnbo~` works in Max for Live devices and on **Push 3 standalone**. The user
  confirmed this on Push with a test device.
- `rnbo~` compiles when the device loads, so it loads slower than plain Max and
  is silent until compiled. Cycling '74 suggests exporting to a Max external for
  speed, but **Push standalone doesn't load third-party externals**, so keep
  `rnbo~` for Push.
- JUCE AU/VST plugins don't run on Push. A Push version is always a Max for
  Live device, which can host the same RNBO patch.
