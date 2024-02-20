#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if the provided directory exists
if [ ! -d "$1" ]; then
    echo "Error: Directory '$1' not found."
    exit 1
fi

# Create the "converted" folder if it doesn't exist
converted_dir="$1/converted"
mkdir -p "$converted_dir"

# Iterate over each PowerPoint file in the specified directory
for ppt_file in "$1"/*.ppt*; do
    # Check if the file is a PowerPoint file
    if [ -f "$ppt_file" ]; then
        # Get the base name of the file
        base_name=$(basename "$ppt_file")
        # Remove the extension from the base name
        base_name_no_ext="${base_name%.*}"
        # Convert the PowerPoint file to PDF
        libreoffice --headless --convert-to pdf --outdir "$converted_dir" "$ppt_file"
        echo "Converted $base_name to PDF."
    fi
done

echo "Conversion completed."

