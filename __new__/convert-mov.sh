#! /usr/bin/env bash
set -exo pipefail;

find . -type f -name '*.mov' \
    | xargs -P $(nproc) -I {} bash -c '
        ff=$(basename -- "${1%.mov}");
        if [ ! -f "${ff}.gif" ]; then
            mkdir -p "/tmp/${ff}" && \
            ffmpeg \
                -i "$1" \
                -filter_complex "[0:v] fps=12,scale=w=128:h=-1,split [a][b];[a] palettegen=stats_mode=single [p];[b][p] paletteuse=new=1" \
                -y "/tmp/${ff}/%05d.png" && \
            convert -dispose 2 "/tmp/${ff}/*.png" "${ff}.gif" && \
            rm -Rf "/tmp/${ff}";
        fi;
    ' _ {} \;
