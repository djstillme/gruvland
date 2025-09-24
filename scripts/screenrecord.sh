#!/bin/bash

# Default output directory
output_dir=~
mkdir -p "$output_dir"

# Generate a timestamped filename if not provided
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
filename="${1:-recording_$timestamp.mp4}"
output_file="$output_dir/$filename"

# Optional region select (uncomment to enable slurp)
# region=$(slurp)
# wf-recorder -g "$region" -f "$output_file"

# Fullscreen recording
notify-send "Recording... Press Ctrl+C to stop."
wf-recorder -f "$output_file"

notify-send "Recording saved to $output_file"
