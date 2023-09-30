#!/bin/sh

# Define the wallpaper directory
wallpaperdir="/home/nemi/Downloads/wallpapers"

# Use find to get a list of all image files (recursively) in the wallpaperdir
image_files=$(find "$wallpaperdir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \))

# Count the number of image files
num_files=$(echo "$image_files" | wc -l)

# Generate a random number between 1 and num_files (POSIX compliant)
random_index=$(awk -v min=1 -v max="$num_files" 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')

# Get the randomly selected wallpaper using sed
random_wallpaper=$(echo "$image_files" | sed -n "${random_index}p")

# Set the random_wallpaper as the desktop background using feh
feh --bg-scale --no-fehbg "$random_wallpaper"

# Display a dmenu prompt to select a wallpaper manually
selected_wallpaper=$(echo "$image_files" | dmenu -l 30)

# If a wallpaper was selected from dmenu, set it as the desktop background
if [ -n "$selected_wallpaper" ]; then
    feh --bg-fill --no-fehbg "$selected_wallpaper"
    exit 0
fi

