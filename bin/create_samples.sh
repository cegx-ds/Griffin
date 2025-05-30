#!/bin/bash

# loop over input dir and create samples yaml 

INPUT_DIR=$1

if [ -z "$INPUT_DIR" ]; then
    echo "Usage: $0 <input_dir>"
    exit 1
fi

if [ ! -d "$INPUT_DIR" ]; then
    echo "Input directory does not exist: $INPUT_DIR"
    exit 1
fi

OUT_SAMPLES_YAML=$2
if [ -z "$OUT_SAMPLES_YAML" ]; then
    echo "Usage: $0 <input_dir> <out_samples_yaml>"
    exit 1
fi

if [ -f "$OUT_SAMPLES_YAML" ]; then
    echo "Output file already exists: $OUT_SAMPLES_YAML"
    exit 1
fi

echo "samples:" > "$OUT_SAMPLES_YAML"

for file in "$INPUT_DIR"/*.bam; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        sample_name="${filename%%.*}"
        echo -e "    $sample_name: ../../$INPUT_DIR/$filename" >> "$OUT_SAMPLES_YAML"
    fi
done