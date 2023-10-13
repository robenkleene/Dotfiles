%

# `csplit`

Split a file based on a regular expression:

	gcsplit -b "%04d.md" -k Weather.md "/^# /" "{*}"
