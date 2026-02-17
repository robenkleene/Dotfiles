#!/usr/bin/awk -f

/SECTIONSTART/ {
    in_block = 1;
    block = "\n"
}
/SECTIONSTART/,/SECTIONEND/ {
    if (in_block) {
        block = block $0 "\n";
    }
    if (/SECTIONKEY/) {
        found_key = 1;
    }
}
/SECTIONEND/ {
    if (in_block) {
        if (found_key) {
            printf "%s", block;
        }
        in_block = 0;
        found_key = 0;
    }
}
