#!/bin/bash

TEXT_FILE="input.txt"
FONT_FILE="./fonts/PressStart2P-Regular.ttf"
FRAME_RATE=30
TYPE_SPEED=0.2
OUTPUT_DIR="frames"
mkdir -p $OUTPUT_DIR
TOTAL_CHARS=$(wc -m < ${TEXT_FILE})
OUTPUT_FILE="output.mp4"



for ((i=1; i<=TOTAL_CHARS; i++)); do
    CURRENT_TEXT=$(head -c $i $TEXT_FILE)
    ffmpeg -f lavfi -i color=s=640x480:d=1:r=$FRAME_RATE \
           -vf "drawtext=fontsize=24:fontfile=${FONT_FILE}:text='${CURRENT_TEXT}_':x=10:y=10:fontcolor=white" \
           -frames:v 1 ${OUTPUT_DIR}/frame_$(printf "%03d" $i).png
done

ffmpeg -framerate $FRAME_RATE -i ${OUTPUT_DIR}/frame_%03d.png -c:v libx264 -pix_fmt yuv420p -r $FRAME_RATE -y $OUTPUT_FILE
