#!/usr/bin/env bash

sed s/”/\"/g | sed s/“/\"/g | sed s/\’/\'/g | sed s/–/-/g | sed s/—/-/g
