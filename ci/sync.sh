#!/usr/bin/env bash

set -e
mkdir -p ~/roms/$rom_name
cd ~/roms/$rom_name
rm -rf .repo/local_manifests
command=$(head $TRAVIS_WORKING_DIR/build_rom.sh -n $(expr $(grep 'build/envsetup.sh' $TRAVIS_WORKING_DIR/build_rom.sh -n | cut -f1 -d:) - 1))
only_sync=$(grep 'repo sync' $TRAVIS_WORKING_DIR/build_rom.sh)
bash -c "$command" || true
