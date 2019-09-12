#!/bin/bash
if [ "$LDEV" == "gemini" ]; then BUILD_MSM4_4=true; else BUILD_MSM4_4=false; fi;
export BUILD_MSM4_4=$BUILD_MSM4_4
export USE_CCACHE=true;
export SKIP_ABI_CHECKS=true;
apply=patches/apply;
if [ ! -e $apply ]
then bash $apply.sh;
touch $apply; fi;
if [ -z $dtl ]; then dtl=1; fi
export changelog_days=$dtl;
export SDCLANG_PATH=/home/ksrt12/u/sdclang/toolchains/llvm-Snapdragon_LLVM_for_Android_8.0/prebuilt/linux-x86_64/bin;
export SDCLANG_LTO_DEFS=device/xiaomi/gemini/sdllvm-lto-defs.mk;
export SDCLANG_COMMON_FLAGS="-O3 -fvectorize -Wno-user-defined-warnings -Wno-vectorizer-no-neon -Wno-unknown-warning-option \
-Wno-deprecated-register -Wno-tautological-type-limit-compare -Wno-sign-compare -Wno-gnu-folding-constant \
-mllvm -arm-implicit-it=always -Wno-inline-asm -Wno-unused-command-line-argument -Wno-unused-variable";
# Enable based on host OS/availablitiy
case $(uname -s) in
 Linux)
  if [ -d "$SDCLANG_PATH" ]; then
   export SDCLANG=true;
   echo -e "\033[32m""sdclang founded: `$SDCLANG_PATH/clang --version | grep "Snapdragon " | cut -d 'f' -f 1`""\033[0m";
  fi
    ;;
 Darwin)
    ;;
 *)
    ;;
esac
