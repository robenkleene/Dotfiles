#!/usr/bin/env bash

/usr/bin/python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$1"
