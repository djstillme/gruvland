#!/bin/bash

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
grim -g "$(slurp)" ~/screenshot_$timestamp.png
