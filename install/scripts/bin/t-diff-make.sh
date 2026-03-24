#!/usr/bin/awk -f

/^index|^\-\-\-|^\+\+\+/ {
  next;
}

/^diff --git a\// {
  split($0, parts, " ");
  file=substr(parts[3], 3);
  next;
}

/^@@ / {
  if (start) { print "" }
  match($0, /\+[0-9]+/);
  if (RSTART) {
    num=substr($0, RSTART + 1, RLENGTH - 1);
    print file ":" num;
  }
  start=1
  next;
}

{ if (start) print }
