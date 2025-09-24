#!/bin/bash

output_dir=~
mkdir -p "$output_dir"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
filename="${1:-recording_$timestamp.mp4}"
output_file="$output_dir/$filename"

notify-send "Recording... Press Ctrl+C to stop."
wf-recorder -f "$output_file"

notify-send "Recording saved to $output_file"
