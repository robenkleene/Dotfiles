---
name: maxmsp-javascript
description: Write JavaScript for the Max/MSP `js` (and `v8`) object. Use when creating or editing `.js` files that run inside a Max patch, or when porting Max patch logic to JavaScript.
allowed-tools: Read, Write, Edit, Grep, Glob
---

# Max/MSP JavaScript

JavaScript that runs inside Max's `js` / `v8` object. The file is loaded by a
`js MyFile.js` object in a `.maxpat`; functions become message handlers.

## File Structure

A `.js` for Max is not a module — it is a flat script. Top-level code runs once
when the object loads. Declare globals, then define handler functions.

```js
autowatch = 1;       // recompile automatically when the file changes on disk
inlets = 2;          // number of inlets on the js object
outlets = 1;         // number of outlets

var state = [0, 0];  // top-level code runs at load time
```

## Inlets & Outlets

- `inlets` / `outlets` — set as global assignments, NOT `var`. They configure
  the host `js` object.
- `inlet` — global int, the index of the inlet the current message arrived on.
  Read it inside a handler to branch on which inlet fired.
- `outlet(n, ...)` — send out outlet `n`. Pass multiple args or an array to
  send a Max list: `outlet(0, "set", 1, 2)` or `outlet(0, myArray)`.
- Outlets fire right-to-left, like native Max objects — if order matters,
  send the rightmost outlet first.
- Name inlet indices with constants for readability:
  ```js
  var INLET_TAB = 0, INLET_NOTE = 1;
  ```

### Assist Comments

- `setinletassist(index, string)` / `setoutletassist(index, string)` set the
  hover ("assist") text for an inlet/outlet. Call them in the top-level script
  body so they run at load (and re-run on `autowatch` recompile).
- Follow the shared Max assist-comment schema — `(type(s), unit, range)
  description`, types first. See the `maxmsp` skill's "Assist Comments" section.

## Message Handlers

Incoming Max messages dispatch to functions **by name**:

| Max message            | Function called                          |
|------------------------|-------------------------------------------|
| `bang`                 | `bang()`                                  |
| an `int`               | `msg_int(value)`                          |
| a `float`              | `msg_float(value)`                        |
| a `list` (2+ atoms)    | `list()` — use `arrayfromargs(arguments)` |
| `foo 1 2 3`            | `foo(1, 2, 3)` if `foo` is defined        |
| anything unmatched     | `anything()` — `messagename` holds the selector |

- `msg_int` / `msg_float` are the special names for bare numbers — a function
  literally named `int` will NOT receive ints.
- `arrayfromargs(arguments)` converts the `arguments` object to a real array.
- `arrayfromargs(messagename, arguments)` prepends the selector — useful in
  `anything()` and for message handlers where you want the leading symbol.
- `messagename` — global string with the current message's selector.

```js
function msg_int(value) {
  if (inlet === INLET_TAB) { /* ... */ }
}

function list() {
  var args = arrayfromargs(arguments);   // real array of the list atoms
}

function anything() {
  var args = arrayfromargs(messagename, arguments);
  if (messagename === "init") { /* args[0] === "init" */ }
}
```

## autowatch

`autowatch = 1;` recompiles the script when the file changes — keep it on
during development. **Caveat:** recompiling re-runs top-level code and wipes
any state held in globals. If a script depends on accumulated state, leave
`autowatch` off (or re-send the state) so a recompile doesn't reset it.

## Debugging

- `post("text\n")` — prints to the Max console. Include the trailing `\n`.
- No `console.log`. A common helper: `function log(o){ post(JSON.stringify(o)+"\n"); }`
- `error("msg\n")` — prints as a Max error.

## Language Environment

- The classic `js` object is an **older ECMAScript engine** — prefer ES5:
  `var`, classic `function`, no arrow functions / `let` / `const` / template
  literals unless targeting the newer `v8` object. (Some patches mix ES6 in
  files run by `v8`; match whatever the existing files in the project use.)
- `String#replace` with a **string** pattern replaces only the first match and
  treats `$` literally in the pattern — handy for substituting tokens like
  `"$1-Osc".replace("$1", "0")`.
- Standard `Math`, `Array`, `JSON` are available.

## Including Other Files

- `include("OtherFile")` — loads `OtherFile.js` from the same folder (no
  extension). The included file's globals/functions become available. Used to
  share pure-logic helpers across scripts.

## Max-Specific Globals & Classes

- `Dict("name")` — wraps a Max `dict`. `.get(key)`, `.set(key, val)`,
  `.parse(jsonString)`, `.clear()`. Pair a `js` `Dict` with a `dict` object of
  the same name to exchange structured data with the patch.
- `Task`, `Patcher`, `Maxobj`, `Buffer`, `Folder`, `File` — other host classes
  (use as needed).

## Porting Patch Logic to JavaScript

When converting `.maxpat` objects to JS:

- A `message` box that does `$1`/`$2` substitution → a token array plus a
  substitution loop. The box is triggered by any message in its left inlet;
  the triggering atoms become `$1`, `$2`, … in order.
- `route` / `select` → `if`/`switch` on the value.
- `coll` → a plain JS object used as an address→data map.
- `t` (trigger), `gate`, `sprintf`, `zl.*` → ordinary control flow / string
  ops. Remember trigger fires right-to-left.
- Map each patch inlet to a `js` inlet; keep `r`/`s` (send/receive) pairs as
  inlets or explicit handler functions.
- Preserve the patch's single combined output as one outlet unless splitting
  improves clarity.

## Conventions

- Keep handler functions small and named after the messages they handle.
- Define inlet-index and message-name constants at the top.
- Document the inlet/outlet contract in a header comment — Max gives no type
  signatures, so the comment is the interface.
