#!/usr/bin/awk -f

/^+?+?<<<<<<< / {
    in_block = 1;
    print;
    next;
}

/^+?+?<<<<<<< / {
    in_block = 0;
    print;
    next;
}

/^+?+?======= / {
    print;
    next;
}

in_block {
  print
}
