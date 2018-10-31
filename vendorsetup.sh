#!/bin/bash
export WITH_SU=true;
export USE_CCACHE=true;
export WITH_ROOT_METHOD=rootless;

apply=device/xiaomi/gemini/patches/apply
if [ ! -e $apply ]
then sh $apply.sh;
touch $apply; fi;

# Set SDClang defaults
export SDCLANG=false
export SDCLANG_PATH=/home/ksrt12/u/sdclang/toolchains/llvm-Snapdragon_LLVM_for_Android_6.0/prebuilt/linux-x86_64/bin
export SDCLANG_LTO_DEFS=device/xiaomi/gemini/sdllvm-lto-defs.mk
export SDCLANG_COMMON_FLAGS="-O3 -fvectorize -Wno-user-defined-warnings -Wno-vectorizer-no-neon -Wno-unknown-warning-option \
-Wno-deprecated-register -Wno-tautological-type-limit-compare -Wno-sign-compare -Wno-gnu-folding-constant \
-mllvm -arm-implicit-it=always -Wno-inline-asm -Wno-unused-command-line-argument -Wno-unused-variable"

# Enable based on host OS/availablitiy
case $(uname -s) in
    Linux)
        if [ -d "$SDCLANG_PATH" ]; then
            export SDCLANG=true
        fi
        ;;
    Darwin)
        ;;
    *)
        ;;
esac
