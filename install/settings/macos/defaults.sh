#!/usr/bin/env bash

set -euo pipefail

defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool NO


