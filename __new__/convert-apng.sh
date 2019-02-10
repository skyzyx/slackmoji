#! /usr/bin/env bash
set -exo pipefail;

# Used information from these sources to figure out how to solve the issue.
# * https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/
# * https://www.alecjacobson.com/weblog/?p=2601

find . -type f -name '*.png' | xargs -P $(nproc) -I {} bash -c 'ff=$(basename -- "${1%.png}"); if [ ! -f "${ff}.gif" ]; then mkdir -p "/tmp/${ff}" && ffmpeg -i "$1" -filter_complex "[0:v] fps=12,scale=w=128:h=-1,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" -y "/tmp/${ff}/%05d.png" && convert -dispose 2 "/tmp/${ff}/*.png" "${ff}.gif" && rm -Rf "/tmp/${ff}"; fi;' _ {} \;
