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
  match($0, /\+([0-9]+)/, m);
  if (m[1]) print file ":" m[1];
  start=1
  next;
}

{ if (start) print }
