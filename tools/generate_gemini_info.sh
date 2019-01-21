#!/bin/sh
#
if [ "$1" ]
then
  file_path=$1
  file_dir=$(dirname "$file_path")/gemini
  file_name=$(basename "$file_path")
  build_date=$2
cat << EOF >> $file_dir
{
  "donate_url":"https:\/\/www.paypal.me\/ksrt12",
  "website_url":"https:\/\/github.com\/Havoc-OS",
  "news_url":"https:\/\/t.me\/havoc_os_gemini",
  "addons":[
    {
      "title":"Firmware",
      "summary":"Latest firmware for gemini",
      "url":"https:\/\/sourceforge.net\/projects\/xiaomi-firmware-updater\/files\/Developer\/8.11.22\/gemini\/"
    },
    {
      "title":"Official Open GApps",
      "summary":"arm64 | pico",
      "url":"http:\/\/opengapps.org\/?arch=arm64?api=9.0?variant=pico"
    },
    {
      "title":"Magisk",
      "summary":"Latest Stable v18.0",
      "url":"https:\/\/github.com\/topjohnwu\/Magisk\/releases\/download\/v18.0\/Magisk-v18.0.zip"
    },
    {
      "title":"Havoc Changelog",
      "summary":"View Havoc-OS changes",
      "url":"https:\/\/t.me\/Havoc_OS\/531"
    },
    {
      "title":"Device Changelog",
      "summary":"View gemini changes",
      "url":"https:\/\/raw.githubusercontent.com\/ksrt12\/OTA\/pie\/deviceChangelog"
    }
  ],
  "developer": "Stepan Kazakov (ksrt12)",
  "developer_url": "https:\/\/t.me\/HavocGeminiBugreport",
  "forum_url": "https:\/\/forum.xda-developers.com\/mi-5\/development\/rom-havoc-os-2-0-t3866995",
EOF

  if [ -f $file_path ]; then
    file_size=$(stat --printf="%s" "$file_path")
    md5=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    echo "  \"filename\":\"$file_name\"," >>  $file_dir
    echo "  \"build_date\":\"$build_date\"," >>  $file_dir
    echo "  \"filesize\":\"$file_size\"," >>  $file_dir
    echo "  \"md5\":\"$md5\"," >>  $file_dir
    echo "  \"url\":\"https:\/\/sourceforge.net\/projects\/havoc-os\/files\/gemini\/$file_name\/download\"" >>  $file_dir
    echo "}" >>  $file_dir
  fi
fi
