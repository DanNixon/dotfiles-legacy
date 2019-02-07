#!/bin/sh

cat configs/standard.conf

echo "conky.text = [["
cat "sections/time"
cat "sections/separator"
cat "sections/system"
cat "sections/separator"
./templates/filesystem /
./templates/drive /dev/sda
cat "sections/separator"
./templates/wireless interface
cat "sections/separator"
./templates/process_checker syncthing  Syncthing
cat "sections/separator"
cat "sections/mpd"
echo "]]"
