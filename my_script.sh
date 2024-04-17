#!/bin/bash

input_dir=$1
output_dir=$2

copy_file(){
	local src=$1
	local dst_dir=$2
	local filename=$(basename -- "$src")
	local extension="${filename##*.}"
	local basename="${filename%.*}"

	local counter=1
	local dest_file="${dest_path}/${basename}.${extension}"
	while [-f "$dest_file" ]; do
		dest_file="${dest_path}/${basename}_${counter}.${extension}"
		let counter+=1
	done

	cp -p "$src_path" "$dest_file"
}

find "$input_dir" -type f -print | while IFS= read -r -d $'\0' file; do
	copy_with_unique_name "$file" "$output_dir"
done

