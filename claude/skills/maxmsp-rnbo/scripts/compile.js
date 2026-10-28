// Compiles an `rnbo~` box with the RNBO codegen bundled in Max, without opening Max.
//
// Usage: RNBO_DIR=<RNBO package> node compile.js <box.json> [js|cpp] [desc.json] [code.out]
//
// `box.json` is the `rnbo~` box object (the one holding `patcher`). Prints any
// codegen errors and a summary line; `desc.json` gets the patcher description
// (params, inlets, outlets), `code.out` the generated source.
const RNBO = process.env.RNBO_DIR || "/Applications/Max.app/Contents/Resources/C74/packages/RNBO";
// The codegen finds its operator definitions through `RNBO_DIR`
process.env.RNBO_DIR = RNBO;
const S = RNBO + "/server";
const req = require("module").createRequire(S + "/dist/start.js");
const runner = req("@rnbo/xam-runner");
const grpc = req("@rnbo/grpc");
const xam = req("@rnbo/xam").default || req("@rnbo/xam");
const { buildController } = req(S + "/dist/controllers/build.js");
const { RNBOCodegenInvocationContext } = req(S + "/dist/src/contexts.js");
const fs = require("fs");

const obj = JSON.parse(fs.readFileSync(process.argv[2], "utf8"));
obj.rnbo_classname = obj.rnbo_classname || "rnbomatic";

// Max asks the server for each box's `rnboinfo` before codegen. Without it a
// `codebox~`'s inlets aren't declared.
function fillInfo(patcher) {
  for (const { box } of patcher.boxes) {
    if (box.maxclass === "comment" || box.maxclass === "panel") continue;
    if (box.patcher) fillInfo(box.patcher);
    box.rnbo_uniqueid = box.rnbo_uniqueid || box.id;
    const text = box.text || box.rnbo_classname;
    const parsed = xam.parseBoxText(text);
    const spec = {};
    if (parsed) xam.parseExtraAttributes(parsed.xamclass, box.rnbo_extra_attributes, spec);
    const { info, messages } = buildController.instanceInfo(text, [], spec);
    for (const m of messages) console.log("INFO", box.id, m.type, m.message);
    if (info) box.rnboinfo = info;
  }
}
fillInfo(obj.patcher);

const context = new RNBOCodegenInvocationContext({ authDict: undefined, clientId: 0 });
const L = grpc.rnbo_proto.CodegenLanguage;
const language = process.argv[3] === "cpp" ? L.CODEGEN_LANGUAGE_CPP : L.CODEGEN_LANGUAGE_JS;
runner.codegenInvocationStorage
  .run(context, () => buildController.createCodegenInvocation(obj, { language }).call())
  .then((r) => {
    for (const m of r.messages || []) console.log("MSG", m.type, m.message);
    const d = r.desc || {};
    console.log("status", r.status, "params", (d.parameters || []).length,
      "inlets", (d.inlets || []).length, "outlets", (d.outlets || []).length);
    if (process.argv[4]) fs.writeFileSync(process.argv[4], JSON.stringify(d, null, 1));
    if (process.argv[5] && r.code) {
      fs.writeFileSync(process.argv[5], typeof r.code === "string" ? r.code : JSON.stringify(r.code));
    }
    process.exit(0);
  })
  .catch((e) => {
    console.log("ERROR", e.message);
    for (const m of e.messages || []) console.log("MSG", m.type, m.message);
    process.exit(1);
  });
