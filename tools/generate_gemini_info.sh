#!/bin/sh
#
if [ "$1" ]
then
  file_path=$1
  file_dir=$(dirname "$file_path")
  filename=$(basename "$file_path")
  romtype=$HAVOC_BUILD_TYPE
  version=$HAVOC_BASE_VERSION
  size=`stat -c "%s" "$file_path"`
  datetime=`cat $file_dir/system/build.prop | grep "ro.build.date.utc=" | cut -d '=' -f2`
  id=`sha256sum $file_path | cut -d ' ' -f1`

if [ -e $file_dir/$HAVOC_BUILD.json ]; then rm $file_dir/$HAVOC_BUILD.json; fi

cat << EOF >> $file_dir/$HAVOC_BUILD.json
{
  "response": [
    {
      "filename": "$filename",
      "romtype": "$romtype",
      "version": "$version",
      "size": "$size",
      "datetime": $datetime,
      "id": "$id",
      "url": "https://sourceforge.net/projects/havoc-gemini/files/$HAVOC_BUILD/$filename/download"
    }
  ]
}
EOF

  cp $file_dir/$HAVOC_BUILD.json $TOP/OTA/$HAVOC_BUILD.json;
fi
