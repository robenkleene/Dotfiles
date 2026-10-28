// Prints each RNBO object's inlet and outlet counts, from RNBO itself.
//
// Usage: node boxinfo.js items.json
//
// `items.json` is a list of {"text": "<box text>"}, optionally with "extra"
// (`rnbo_extra_attributes`), or "patcher" and "args" for a `p` subpatcher.
// Use it to set `numinlets`/`numoutlets`/`outlettype` when writing patchers,
// and to check cords before compiling.
const RNBO = process.env.RNBO_DIR || "/Applications/Max.app/Contents/Resources/C74/packages/RNBO";
process.env.RNBO_DIR = RNBO;
const req = require("module").createRequire(RNBO + "/server/dist/start.js");
const xam = req("@rnbo/xam").default || req("@rnbo/xam");
const { buildController } = req(RNBO + "/server/dist/controllers/build.js");
const items = JSON.parse(require("fs").readFileSync(process.argv[2], "utf8"));
const out = items.map(({ text, extra, patcher, args }) => {
  const parsed = xam.parseBoxText(text);
  const spec = {};
  if (parsed) xam.parseExtraAttributes(parsed.xamclass, extra, spec);
  if (patcher) { spec.patcher = patcher; spec.patcherargs = args || []; }
  const { info, messages } = buildController.instanceInfo(text, [], spec);
  if (!info) return { text, error: messages.map(m => m.message).join("; ") };
  return { text, ins: info.inputs.length, outs: info.outputs.length,
           outtypes: info.outputs.map(o => (o.type === "signal" ? "signal" : "")) };
});
console.log(JSON.stringify(out));
