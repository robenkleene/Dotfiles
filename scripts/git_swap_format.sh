#!/usr/bin/env bash

sed 's/https\:\/\//git@/g' | perl -pe 's|(git@.*?)/|\1:|'
