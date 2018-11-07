#!/bin/bash
export WITH_SU=true;
export USE_CCACHE=true;
export SKIP_ABI_CHECKS=true;
#export INC_ZIP="-i thi/havoc_gemini-target_files-fb721505ac.zip";
apply=device/xiaomi/gemini/patches/apply;
if [ ! -e $apply ]
then sh $apply.sh;
touch $apply; fi;

export SDCLANG_PATH=/home/ksrt12/u/sdclang/toolchains/llvm-Snapdragon_LLVM_for_Android_6.0/prebuilt/linux-x86_64/bin;
export SDCLANG_COMMON_FLAGS="-O3 -fvectorize -Wno-user-defined-warnings -Wno-vectorizer-no-neon -Wno-unknown-warning-option \
-Wno-deprecated-register -Wno-tautological-type-limit-compare -Wno-sign-compare -Wno-gnu-folding-constant \
-mllvm -arm-implicit-it=always -Wno-inline-asm -Wno-unused-command-line-argument -Wno-unused-variable";
