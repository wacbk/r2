#!/usr/bin/env bash

DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -ex

export RUSTFLAGS='--cfg reqwest_unstable'
export RUST_LOG=$RUST_LOG,watchexec=off,watchexec_cli=off,globset=warn

exec bunx concurrently --kill-others --raw -- \
  "watchexec -n --project-origin . -w ./coffee --exts coffee -- ./test.sh" \
  "watchexec -pn --project-origin . -w ./src --exts rs,toml -r -- ./run.sh"
