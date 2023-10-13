%

# `ffmpeg`

## Convert to MP3

    ffmpeg -i input.m4a -q:a 0 output.mp3

## Convert to WebM

    ffmpeg -i Hand\ Movement.mp4 Hand\ Movement.webm

## Convert to Apple Lossless

    ffmpeg -i input.flac -c:v copy -acodec alac output.m4a

The `-c:v` seems to be added to deal with artwork metadata.

## Join `flac`

Create an `inputs.txt` file:

    for f in ./*.flac; do echo "file '$f'" >> inputs.txt; done

Then convert:

    ffmpeg -safe 0 -f concat -i inputs.txt -acodec alac output.m4a

## Inspect Metadata

    ffprobe 2020-08-07\ 17-39-49.mkv
