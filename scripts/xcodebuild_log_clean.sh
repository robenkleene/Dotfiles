#!/bin/bash

sed -E 's/0x.{11}/0x/g' | sed -E 's/.*[0-9]+:[0-9]+\] //'
