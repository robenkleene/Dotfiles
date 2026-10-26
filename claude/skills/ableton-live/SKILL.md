---
name: ableton-live
description: Create and edit Ableton Live sets (`.als`) programmatically, e.g., generating test sets that clone a track per test with different device parameter values. Use when reading, generating, or modifying a `.als` file, especially one containing Max for Live devices.
allowed-tools: Read, Write, Edit, Grep, Glob, Bash
---

# Ableton Live Sets

A `.als` is gzipped XML. Never write one from scratch. Start from a set the user
saved in Live, and build everything new by deep-copying elements that already
exist in it, so every element has the fields that version of Live expects.

## Ids (Live refuses the set if these are wrong)

Live rejects a set as corrupt over two separate id rules. Check both before
handing the set over (see Validation).

### Non-unique list ids

Every element in a list has an `Id` attribute that must be unique among its
siblings, e.g., the `MxDFloatParameter Id="0"`…`Id="179"` entries in a Max for
Live device's `ParameterList`. These ids are local to the list, so the same
values repeat in every device, which is fine.

When adding an element by cloning a sibling, the copy keeps the sibling's `Id`
and Live refuses the set with "Non-unique list ids". Give the copy a new `Id`.
In a `ParameterList`, the `Id` matches `<Index Value>`, so use max index + 1 for
both.

### Non-unique pointee ids

Automation and modulation targets have ids that must be unique across the
whole document and below `LiveSet/NextPointeeId`. When cloning a track or
device, renumber every element whose tag:

- ends in `Target` (`AutomationTarget`, `ModulationTarget`, etc.)
- starts with `ControllerTargets.` (`ControllerTargets.0`…`ControllerTargets.26`,
  easy to miss because the tag name is numbered)
- is `Pointee`

Count up from `NextPointeeId`, then set `NextPointeeId` past the last id used.

Cloned tracks also need a new track `Id`: max over all `LiveSet/Tracks`
children (which include return tracks) + 1.

## Max for Live Parameters

A device's parameters live at
`.//MxDeviceInstrument/ParameterList/ParameterList` (or the audio/MIDI effect
equivalent). Each entry is an `MxDFloatParameter`, `MxDIntParameter`, or
`MxDEnumParameter` with `Name`, `MinValue`, `MaxValue`, `Default`, and the value
in `Timeable/Manual`.

- **Live matches entries to device parameters by `Name`** (the
  `parameter_longname`). A name that isn't in the list is silently ignored, so
  assert that every parameter you set was found.
- **A set saved before a parameter was added to the device has no entry for
  it.** Setting values for it does nothing. Add the entry by cloning a sibling
  of the same type, and give it a unique `Id`/`Index` and fresh target ids (see
  Ids).
- **The element type must match the device's `parameter_type`.** If a
  parameter changed type (e.g., int to float), replace the stale element with a
  clone of the right type, at the same position with the same `Id` and `Index`.
  `MxDIntParameter` has fields the float type doesn't, so cloning is safer than
  renaming the tag. The device's types are in the `.amxd` JSON's
  `patcher.parameters`, e.g., `["ModVol", "ModVol", 0]`, where `0` is float.
- **Write int and enum values as integer strings, floats as `repr(float(v))`.**
- **`Manual` stores the dial's linear position, not the displayed value, when
  the dial has a `parameter_exponent`.** Convert with
  `lo + ((v - lo) / (hi - lo)) ** (1 / exp) * (hi - lo)`, taking `lo`, `hi`, and
  `exp` from the `.maxpat`'s `saved_attribute_attributes.valueof`
  (`parameter_mmin`, `parameter_mmax`, `parameter_exponent`). Writing the
  displayed value gives wildly wrong results for exponential dials (times,
  frequencies).

Live loads the device from the `.amxd` on disk (`PatchSlot/MxPatchRef/FileRef`),
not from a copy in the set. So device edits take effect on reopening the set,
but the `.amxd` must already contain any new parameters (grep it for their
names); a new parameter in a `.maxpat` that the `.amxd` hasn't been re-saved
with doesn't exist yet.

## Arrangement Clips

Don't build a `MidiClip` skeleton by hand. Copy a complete one from the set,
e.g., `GroovePool/Grooves/Groove/Clip/Value/MidiClip`, then set:

- `Id="0"`, `Time` (start, in beats), `CurrentStart`, `CurrentEnd`, `Name`
- `Loop/LoopStart` = 0; `Loop/LoopEnd`, `Loop/OutMarker`, `Loop/HiddenLoopEnd`,
  `ScrollerTimePreserver/RightTime`, and `FollowAction/FollowTime` = length;
  `Loop/LoopOn` = false

Notes: clear `Notes/KeyTracks`, then add one `KeyTrack Id="n"` per pitch,
containing `Notes/MidiNoteEvent` elements (`Time` relative to the clip start,
`Duration`, `Velocity`, `OffVelocity`, a unique `NoteId`) followed by
`MidiKey Value="<pitch>"`. Set `Notes/NoteIdGenerator/NextId` past the last
`NoteId`.

Append the clip to the track's
`DeviceChain/MainSequencer/ClipTimeable/ArrangerAutomation/Events`. On cloned
tracks, also set `Name/EffectiveName`, `Name/UserName`, and
`DeviceChain/MainSequencer/Recorder/IsArmed` = false.

Write the file with an explicit `<?xml version="1.0" encoding="UTF-8"?>` header
and `gzip.open(path, "wt", encoding="utf-8")`.

## Validation

Run this on every generated set before handing it over. Both counts must be 0.

```python
import collections, gzip, xml.etree.ElementTree as ET

root = ET.fromstring(gzip.open(path).read())
list_dups = sum(
    n > 1
    for parent in root.iter()
    for n in collections.Counter(c.get("Id") for c in parent if c.get("Id") is not None).values()
)
targets = [
    int(e.get("Id")) for e in root.iter()
    if e.get("Id") and (e.tag.endswith("Target") or e.tag.startswith("ControllerTargets.") or e.tag == "Pointee")
]
pointee_dups = len(targets) - len(set(targets))
assert max(targets) < int(root.find("LiveSet/NextPointeeId").get("Value"))
print("list id dups", list_dups, "pointee id dups", pointee_dups)
```

## Exporting Audio for Analysis

When the user exports the set's audio for automated analysis:

- **Live's default export range starts at the first clip, not at 0.** If the
  set opens with silence, the exported audio is shifted earlier by that amount.
  Either ask for the export to start at bar 1, or detect the offset (compare
  the file's length with the expected length) and shift the expected times.
- Note timing in exports is accurate to about 1 ms, so per-note analysis can be
  driven directly from the times the set was generated with. Write those to a
  manifest alongside the set.
- Before blaming the device for a failed measurement, run the analyzer on a
  synthetic WAV with known values. Several first-pass failures were analyzer
  bugs (e.g., autocorrelation pitch tracking on short windows; use zero
  crossings instead).
- Include a control test whose result should differ if the set's values were
  applied (e.g., a feature toggled off next to the same test toggled on), so a
  set whose parameter values were silently ignored is caught.
