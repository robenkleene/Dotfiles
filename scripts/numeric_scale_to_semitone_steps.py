#!/usr/bin/env python3

import sys

def numeric_to_semitone(numeric_notation):
    semitone_steps_sharp = [2, 2, 1, 2, 2, 2, 1]
    semitone_steps_flat = [2, 1, 2, 2, 1, 2, 2]
    notes = numeric_notation.split()
    semitone_sequence = []
    for note in notes:
        if note[-1] == "b":
            semitone_sequence.append(semitone_steps_flat[int(note[:-1])-1])
        else:
            semitone_sequence.append(semitone_steps_sharp[int(note)-1])
    return semitone_sequence

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python numeric_to_semitone.py <numeric_notation>")
    else:
        numeric_notation = sys.argv[1]
        semitone_sequence = numeric_to_semitone(numeric_notation)
        print(semitone_sequence)
