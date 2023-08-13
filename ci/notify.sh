#!/usr/bin/env bash

rom_name=$(grep 'repo init' $TRAVIS_BUILD_DIR/build_rom.sh -m 1 | cut -d / -f 4)
branch_name=$(grep 'repo init' $TRAVIS_BUILD_DIR/build_rom.sh | awk -F "-b " '{print $2}' | awk '{print $1}')
rom_name=$rom_name-$branch_name
device=$(grep unch $TRAVIS_BUILD_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)
grep _jasmine_sprout $TRAVIS_BUILD_DIR/build_rom.sh > /dev/null && device=jasmine_sprout
grep _laurel_sprout $TRAVIS_BUILD_DIR/build_rom.sh > /dev/null && device=laurel_sprout
grep _GM8_sprout $TRAVIS_BUILD_DIR/build_rom.sh > /dev/null && device=GM8_sprout
grep _maple_dsds $TRAVIS_BUILD_DIR/build_rom.sh > /dev/null && device=maple_dsds
your_telegram_id=@build_updates
show=$(cat $TRAVIS_BUILD_DIR/build_rom.sh)
curl -s "https://api.telegram.org/bot${bot_api}/sendmessage" -d "text=<code>$device-$rom_name</code> Started
https://travis-ci.com/build/$CIRRUS_BUILD_ID $show" -d "chat_id=${your_telegram_id}" -d "parse_mode=HTML"

