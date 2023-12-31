# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorOS/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/Zeref-Igris/local_manifest.git --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch superior_RMX2061-user
export TZ=Asia/Kolkata #put before last build command
m bacon -j$(nproc --all)

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $TRAVIS_BUILD_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip travis:$(grep unch $TRAVIS_BUILD_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}
