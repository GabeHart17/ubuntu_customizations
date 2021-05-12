#!/usr/bin/env bash

FOUND=1
DEVICE=""
while IFS= read -r line; do
  if [ $FOUND -eq 0 ]; then
    DEVICE=$line
    break
  fi
  echo $line | grep "C920" > /dev/null
  FOUND=$?
done <<< $(v4l2-ctl --list-devices)

test -z $DEVICE && exit 1
v4l2-ctl -d $DEVICE --set-ctrl focus_auto=0
v4l2-ctl -d $DEVICE --set-ctrl focus_absolute=30
