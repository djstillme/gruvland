#!/bin/bash

FILE=$(zenity --file-selection --title="Select a file to burn with Caligula")

if [ -z "$FILE" ]; then
    echo "No file selected."
    exit 1
fi

echo "Selected file: $FILE"

echo "Running: caligula burn \"$FILE\""
caligula burn "$FILE"
