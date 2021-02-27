#!/usr/bin/env bash
set -euo pipefail
DIR=~/media/music

cd $DIR || exit 1;
mpc --quiet update
mpc --quiet clear
mpc --quiet random off
fd --min-depth 2 --max-depth 2 -t d | shuf | mpc add
