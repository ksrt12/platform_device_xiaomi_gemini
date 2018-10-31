#!/bin/bash
export WITH_SU=true;
export USE_CCACHE=true;
export WITH_ROOT_METHOD=rootless;

apply=device/xiaomi/gemini/patches/apply
if [ ! -e $apply ]
then sh $apply.sh;
touch $apply; fi;
