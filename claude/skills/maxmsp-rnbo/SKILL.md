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
- **Patching vs `codebox~` is a load time trade-off.** Patched objects read
  like Max, but compile far slower: Thump's patched port generated 1.6 - 3 MB
  of C++ and took 2 - 3.5 s to compile, its single `codebox~` 0.4 MB and 0.7 s.
  Thump chose the `codebox~`, with `param` objects feeding its inlets, because
  `rnbo~` compiles on every load. Patching still suits small patches.
- `expr` and `expr~` take `in1`, `in2`, ... (not `$f1`), and support
  `pow`, `clamp`, `atodb` and ternaries, e.g. `overdrive~` as
  `expr~ in1 >= 1 ? 1 : (in1 > 0 ? 1 - pow(1 - in1, in2) : ...)`. Commas need
  no escaping.
- `filtercoeff~`'s type is an attribute, not an inlet: `filtercoeff~ @type
  lowpass`, changed with an enum index through `set type`.
- `accum` clamps at its `min`, 0 by default, so it drops negative values. Sum
  with `+ 0.` and a `trigger f f` back into its right inlet instead.
- `send~` names must be unique (a second one is a compile error), so signals
  can't be summed onto one bus as in MSP. Sum explicitly (e.g. a `ModSum`
  abstraction of `receive~` -> `+~` -> one `send~`). Message `send` can repeat.
- Mostly the same as Max: `trigger`, `pack`, `unpack`, `gate`, `gate~`,
  `selector~`, `switch`, `select`, `snapshot~` (bang to sample), `random`,
  `scale` (linear without a power argument), `beatstohz~`, `sah~`, `delta~`,
  `line~` (value/time pairs, `0 0 1 1 0 5`).

## Abstractions

- A `.rnbopat` file is `{"patcher": {... "classnamespace": "rnbo" ...}}` in the
  Max search path, used as `p @file Name`.
- **Avoid `@args` and `#1`.** They work (`p @file Name @args a`, also mid-word
  like `r osc#1-trig`), but Max prints "RNBO: WARNING : Patcher arg #1 not
  defined." for every `#1` each time it compiles, since it reads the
  abstraction's objects without the args first. The user found that noise
  unacceptable. Give abstractions inlets and outlets instead, and route with
  cords. That also makes the signal flow visible.
- **Prefer cords to `send`/`receive`** generally, for readable flow and because
  the buses need names (and so `#1`) per instance. Several signal cords into one
  inlet are summed (RNBO inserts an adder), so a mod matrix can cord every
  slot's outlet straight into one `out~` per destination.
- Inlets and outlets are numbered by `in N`/`in~ N` and `out N`/`out~ N`, one
  sequence shared by message and signal (`in~ 1`, `in 2` is two inlets).
- Prefix project abstractions (e.g. `DspOsc`) so they can't collide with other
  `.rnbopat` files in the search path.
- `param`s inside an abstraction work, named after `#1` substitution, but keep
  them at the top level of the `rnbo~` patcher and cord them into the
  abstractions. Their names then match what Max sends, and they're the plugin
  parameters on export.

## Load Time

`rnbo~` generates and compiles C++ every time it loads (freezing doesn't
change that, as far as is known), so load time follows the generated code's
size. Measure it offline: compile with `compile.js ... cpp`, check the `.cpp`
size and parameter count, and time `clang++ -O1 -c` on it.

- **Every abstraction instance and every object costs code.** RNBO generates a
  class per subpatcher instance (no sharing), and turns objects' settable state
  (cold inlets, `expr` inputs, `gate` state) into hidden parameters, each with
  lookup code. Thump's patched port generated 14x the C++ of its single
  `codebox~` version (3.2 MB vs 229 KB).
- **Repeated sections: one polyphonic subpatcher.** `p @file Slot @polyphony 5
  @voicecontrol user` generates the code once; all voices run (no MIDI
  allocation), messages to its inlets reach every voice, and signal outlets
  are summed. Each voice picks its own settings by `loadbang` -> `voice` ->
  `switch 5` over all five slots' inputs. This halved Thump's code.
- **Small helpers: inline them** rather than abstracting (each instance is a
  class); a few objects plus one `expr` beat a `p @file` per use.
- The `rnbo~` `optimization` attribute: `O0` compiles about 2.5x faster than
  `O1` but the DSP used about 4x the CPU, a poor trade for Push.
- `staterestore`/`presets` off only saved about 6%.
- A Max external export loads instantly but doesn't load on Push standalone.

## Feedback

"Audio feedback detected. Consider using a feedback~ object" means some
object's signal inputs can't be ordered.

- **Sibling abstractions are ordered as units**, by their `send~`/`receive~`
  links as well as cords. If abstraction A sends to B, B to C, and C back to A
  (e.g. an envelope -> mod matrix -> the voice that made the envelope), it's a
  loop even if no signal actually flows around inside. A `feedback~` inside an
  abstraction doesn't help. Bring the signal out on an outlet and put
  `feedback~` at that level before the `send~` (one vector of delay, as MSP's
  `send~`/`receive~` gave implicitly).
- **Signal -> message -> signal counts as feedback:** e.g. `selector~` ->
  `snapshot~` -> ... -> `sig~` back into the same `selector~`.
- To find the objects, wrap RNBO's logger at runtime:
  `const Log = req("@rnbo/xam/lib/log.js"); const e = Log.error; Log.error =
  (m, o, ...r) => { console.log(o && o.patchPath); return e(m, o, ...r); };`
  The path is the top-level box id; compiling each abstraction alone, then
  removing sections one at a time, narrows it down.
- With cords, put the `feedback~` on the cord into the matrix (e.g. each
  section's envelope outlet -> `feedback~` -> the mod matrix's source inlet).

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
  from Max by sending `name <value>` to the left inlet. Names can be any symbol,
  e.g. a Live long name like `1-Gain`. `@exponent 5`, `@steps 97` and
  `@enum Off On` work (an enum outputs its index).
- Set `parameter_enable` to 0 when nothing in Live needs to see RNBO's
  parameters. Otherwise the internal object parameters can be exposed too.

## Getting Values into `rnbo~`

`rnbo~` compiles asynchronously when the patch or device loads. **Messages sent
before it finishes are dropped** with `rnbo~: doesn't understand "<name>"`.
That includes the values Live parameters output on load.

- **Re-send when it's ready (what Thump does).** In the RNBO patcher,
  `loadbang` -> `outport ready`; `rnbo~` outputs `ready` from its rightmost
  outlet once compiled. In Max, each parameter's path is `prepend <name>` ->
  `t l l` -> `s <bus>`, with the right outlet into `zl reg`'s right inlet, and
  `route ready` broadcasts a bang that makes every `zl reg` send its message
  again. Put a `gate` (closed) before `rnbo~` and open it on `ready` before the
  re-send, otherwise each value sent during the compile still prints "doesn't
  understand". This keeps real `param`s, which matter for export.
- **Signals don't have this problem**, since `sig~` holds its value: feed
  control values as signals into `in~` inlets (`sig~` -> `send~` ->
  `receive~` -> `rnbo~`). But they aren't parameters in exported code.
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
# inlet/outlet counts of objects, to fill in numinlets/numoutlets and check cords
node ~/.claude/skills/maxmsp-rnbo/scripts/boxinfo.js items.json

# compile an `rnbo~` box (JSON of the box holding `patcher`; embed each
# `p @file` box's abstraction as its "patcher", as Max does)
node ~/.claude/skills/maxmsp-rnbo/scripts/compile.js box.json js desc.json
# -> "status Success params N inlets N outlets N", or the codegen errors

# C++ export, then render notes offline to a WAV
node ~/.claude/skills/maxmsp-rnbo/scripts/compile.js box.json cpp desc.json export.cpp
R=/Applications/Max.app/Contents/Resources/C74/packages/RNBO/source/rnbo
clang++ -std=c++17 -O2 -I$R -I$R/common -I$R/src \
    ~/.claude/skills/maxmsp-rnbo/scripts/render.cpp export.cpp $R/RNBO.cpp -o render
./render inputs.txt out.wav 2 0.1:60:100 1.1:60:100
```

To set `param`s instead of `in~` inputs, call
`rnbo.setParameterValue(index, value)` before processing. The index is the
param's position in `desc.json`'s `parameters`.

- A cord to an inlet that doesn't exist fails codegen with "attach, no
  attribute ..." and no location. Check every cord against `boxinfo.js` counts
  first.
- Run compile on every patcher before handing it over. It reports the same
  errors Max would, with the offending code.
- `desc.json`'s `parameters` show each param's `paramId` and `name`, and
  whether a value was constant-folded instead of becoming a parameter.
- Render to check that patches actually make sound, then measure level, decay
  and pitch from the WAV (e.g. RMS per 10 ms, zero crossings). That's how
  "silent" and "too quiet" bugs were found before the user opened anything.
- To trace a value, temporarily replace an output (`out2 = <expr>;`), compile
  and render that channel.

## Exporting (Official)

Keep the `rnbo~`, its message plumbing and the export in their own patcher
(Thump's `Engine.maxpat`, inlets for notes and controllers, outlets for audio),
not in a UI patcher.

There's no supported command line export, but `rnbo~` takes export messages,
so a button in the patch can export without the sidebar (`rnbo~.maxhelp`, `p
export`, has the example):

1. `rnbo~ @dumpoutlet 1` adds an outlet after the outport outlet.
2. `dumptargetconfig cpp-export cpp-code-export` -> `rnbo~`. The dump outlet
   sends `targetconfig <dict>` (and later `exportstatus ...`):
   `route targetconfig exportstatus` -> `t b b l`, `l` into `dict my_config`.
3. `set output_path <dir>, set export_name Name.cpp, set classname Name, set
   copy_library 1` -> `dict my_config`, then
   `export cpp-export cpp-code-export my_config` -> `rnbo~`.

To ask for the folder instead of hardcoding it: `opendialog fold` ->
`conformpath slash boot` (Max's `Macintosh HD:/Users/...` to `/Users/...`) ->
`prepend set output_path` into a `zl reg`, sent to the `dict` after it's
filled from `targetconfig`.

The C++ export writes `<output_path>/<export_name>.cpp`, `description.json`,
`presets.json` (if any), and with `copy_library` the runtime in `rnbo/`
(compile `rnbo/RNBO.cpp` with the export; include `rnbo/` and `rnbo/common/`).
Exporting needs an RNBO license. Prefer this to the local codegen harness for
anything committed.

## Using the C++ Export

- `RNBO::CoreObject rnbo;` finds the exported patch when its `.cpp` is linked
  in. `prepareToProcess(sampleRate, blockSize)`, then
  `process(ins, numIns, outs, numOuts, frames, &midiIn, &midiOut)`.
- The patch's own `param`s are the ones with `ParameterInfo::visible`; the
  hundreds of others are objects' internal parameters. Build host parameters
  from the visible ones (`getParameterName`, `min`/`max`/`exponent`/`steps`/
  `enumValues`).
- **Parameter changes and MIDI at the same time:** RNBO handles a block's MIDI
  before parameter events at the same timestamp, so a note can miss a change
  made in the same block (e.g., a preset turning an oscillator on). Calling
  `process(..., 0)` with zero frames after `setParameterValue` applies them
  first.
- RNBO's JUCE adapter (`source/rnbo/adapters/juce/RNBO_JuceAudioProcessor.cpp`)
  shows how to schedule the host transport (`TempoEvent`, `BeatTimeEvent`,
  `TimeSignatureEvent`, `TransportEvent`) and MIDI (`RNBO::TimeConverter`
  from `RNBO_TimeConverter.h`). Mark RNBO's include dirs `SYSTEM` in CMake, or
  JUCE's warning flags flood the build.

## Max for Live and Push

- `rnbo~` works in Max for Live devices and on **Push 3 standalone**. The user
  confirmed this on Push with a test device.
- `rnbo~` compiles when the device loads, so it loads slower than plain Max and
  is silent until compiled. Cycling '74 suggests exporting to a Max external for
  speed, but **Push standalone doesn't load third-party externals**, so keep
  `rnbo~` for Push.
- JUCE AU/VST plugins don't run on Push. A Push version is always a Max for
  Live device, which can host the same RNBO patch.
