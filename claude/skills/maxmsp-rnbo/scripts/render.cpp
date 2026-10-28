// Renders an RNBO C++ export offline to a mono 16-bit WAV.
//
// Usage: render <inputs.txt> <out.wav> <seconds> [time_s:pitch:velocity ...]
//
// `inputs.txt` holds one constant value per `in~` (whitespace separated), and
// each note argument schedules a MIDI note-on. Build with:
//
//   R=<RNBO package>/source/rnbo
//   clang++ -std=c++17 -O2 -I$R -I$R/common -I$R/src render.cpp export.cpp $R/RNBO.cpp -o render
#include "RNBO.h"
#include <cstdio>
#include <cstdlib>
#include <fstream>
#include <vector>

static void writeWav(const char *path, const std::vector<float> &data, int sr) {
  FILE *f = fopen(path, "wb");
  int bytes = (int)data.size() * 2;
  auto w32 = [&](int v) { fwrite(&v, 4, 1, f); };
  auto w16 = [&](short v) { fwrite(&v, 2, 1, f); };
  fwrite("RIFF", 1, 4, f); w32(36 + bytes); fwrite("WAVEfmt ", 1, 8, f);
  w32(16); w16(1); w16(1); w32(sr); w32(sr * 2); w16(2); w16(16);
  fwrite("data", 1, 4, f); w32(bytes);
  for (float x : data) { float c = x > 1 ? 1 : (x < -1 ? -1 : x); w16((short)(c * 32767)); }
  fclose(f);
}

int main(int argc, char **argv) {
  const int sr = 48000, bs = 64;
  RNBO::CoreObject rnbo;
  rnbo.prepareToProcess(sr, bs);
  std::vector<double> values;
  std::ifstream in(argv[1]);
  double v;
  while (in >> v) values.push_back(v);
  int nin = rnbo.getNumInputChannels(), nout = rnbo.getNumOutputChannels();
  if ((int)values.size() != nin) { fprintf(stderr, "expected %d inputs, got %zu\n", nin, values.size()); return 1; }
  for (int i = 4; i < argc; i++) {
    double t; int p, vel;
    sscanf(argv[i], "%lf:%d:%d", &t, &p, &vel);
    uint8_t on[3] = {0x90, (uint8_t)p, (uint8_t)vel};
    rnbo.scheduleEvent(RNBO::MidiEvent(t * 1000.0, 0, on, 3));
  }
  std::vector<std::vector<double>> inbuf(nin, std::vector<double>(bs)), outbuf(nout, std::vector<double>(bs));
  std::vector<double *> ins(nin), outs(nout);
  for (int i = 0; i < nin; i++) { std::fill(inbuf[i].begin(), inbuf[i].end(), values[i]); ins[i] = inbuf[i].data(); }
  for (int i = 0; i < nout; i++) outs[i] = outbuf[i].data();
  std::vector<float> data;
  int blocks = (int)(atof(argv[3]) * sr / bs);
  for (int b = 0; b < blocks; b++) {
    rnbo.process(ins.data(), nin, outs.data(), nout, bs);
    for (int i = 0; i < bs; i++) data.push_back((float)outbuf[0][i]);
  }
  writeWav(argv[2], data, sr);
  return 0;
}
