#!/usr/bin/env bash

set -euo pipefail

exec perl -ne 'print unless $seen{$_}++'