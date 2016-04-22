#!/bin/bash

video_path=$1
start_time=$2
stop_time=$3
scene_ratio=$4
scene_prefix="vrsil_"
images_path=$HOME/Videos/snapshots

vlc "$video_path" --video-on-top \
  --video-filter=scene --vout=dummy \
  --start-time=$start_time --stop-time=$stop_time --scene-ratio=$scene_ratio \
  --scene-prefix="$scene_prefix" --scene-path=$images_path --no-scene-replace \
  vlc://quit





