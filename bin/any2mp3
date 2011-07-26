#!/bin/sh -ex

test ! -e audiodump.wav

for i in "$@"
do
    newname=$(echo "$i"|sed 's/\(.*\)\.[^.]*$/\1.mp3/')
    mplayer -vo null -vc dummy -af resample=44100 -ao pcm:waveheader "$i"
    lame -m s audiodump.wav -o "$newname"
done

rm audiodump.wav
