#!/bin/bash

# Configuration
TEXT_FILE="input.txt"  # The text file containing the content to be typed
FONT_SIZE=24           # Font size for the terminal text
FONT_COLOR="white"     # Font color
FONT_FILE="Montserrat-Black.ttf"  # Path to the TTF font file
OUTPUT_FILE="output.mp4"  # Output video file name
FRAME_RATE=30          # Frame rate of the video
BLINK_INTERVAL=0.5     # Blink interval for the cursor in seconds
TYPE_SPEED=0.1         # Typing speed in seconds per character

# Calculate the total number of characters in the text file
TOTAL_CHARS=$(wc -m < ${TEXT_FILE})

# Calculate the total duration of the video
TOTAL_DURATION=$(echo "scale=2; $TOTAL_CHARS * $TYPE_SPEED + 2" | bc)

# Generating a filter complex for FFmpeg
FILTER_COMPLEX=""

# Adding blinking cursor
FILTER_COMPLEX+="drawtext=fontsize=${FONT_SIZE}:fontfile=${FONT_FILE}:fontcolor=${FONT_COLOR}:x=10:y=10:text='_':rate=${FRAME_RATE}:enable='lt(mod(t,${BLINK_INTERVAL}*2),${BLINK_INTERVAL})',"

# Typing out the text
CHARS_PER_FRAME=$(echo "scale=2; 1 / $TYPE_SPEED" | bc)
FILTER_COMPLEX+="drawtext=fontsize=${FONT_SIZE}:fontfile=${FONT_FILE}:fontcolor=${FONT_COLOR}:x=30:y=10:text='%{eif\:trunc(n/${CHARS_PER_FRAME})\:${TEXT_FILE}}':rate=${FRAME_RATE}:enable='gte(t,2)'"

# Run FFmpeg
ffmpeg -f lavfi -i color=s=640x480:r=${FRAME_RATE} -vf "${FILTER_COMPLEX}" -c:v libx264 -tune stillimage -pix_fmt yuv420p -r ${FRAME_RATE} -t ${TOTAL_DURATION} ${OUTPUT_FILE}