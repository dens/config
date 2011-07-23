#!/bin/sh -e

usage="$0 INFILE OUTFILE"

src=${1?$usage}
dst=${2?$usage}

# eval $(midentify "$src")
# vbitrate=${ID_VIDEO_BITRATE?"error identify ID_VIDEO_BITRATE"}
# abitrate=${ID_AUDIO_BITRATE?"error identity ID_AUDIO_BITRATE"}
# echo "abitrate: ${abitrate}"
# echo "vbitrate: ${vbitrate}"

encode_pass()
{
    mencoder "$src" \
        -ofps 23.976 \
        -ovc xvid \
        -xvidencopts pass=$1:bitrate=800 \
        -oac mp3lame \
        -lameopts abr:br=64 \
        -o $2
}

encode_pass 1 /dev/null
encode_pass 2 "$dst"
