#! /usr/bin/env bash
set -exo pipefail;

# Used information from these sources to figure out how to solve the issue.
# * https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
# * https://www.alecjacobson.com/weblog/?p=2601

# find . -type f -name '*.png' | xargs -P $(nproc) -I {} bash -c 'ff=$(basename -- "${1%.png}"); if [ ! -f "${ff}.mp4" ]; then mkdir -p "/tmp/${ff}-mp4" && ffmpeg -i "$1" -filter_complex "[0]split=2[bg][fg];[bg]drawbox=c=white@1:replace=1:t=fill[bg];[bg][fg]overlay=format=auto;[0:v] scale=w=408:h=-1,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" -y "/tmp/${ff}-mp4/%05d.png" && ffmpeg -i "/tmp/${ff}-mp4/%05d.png" -vcodec libx264 -crf 25 -pix_fmt yuv420p ${ff}.mp4 && rm -Rf "/tmp/${ff}-mp4"; fi;' _ {} \;
find . -type f -name '*.png' | xargs -P $(nproc) -I {} bash -c 'ff=$(basename -- "${1%.png}"); if [ ! -f "${ff}.mp4" ]; then ffmpeg -i "$1" -filter_complex "[0]split=2[bg][fg];[bg]drawbox=c=white@1:replace=1:t=fill[bg];[bg][fg]overlay=format=auto" -vcodec libx264 -crf 25 -pix_fmt yuv420p ${ff}.mp4; fi;' _ {} \;
