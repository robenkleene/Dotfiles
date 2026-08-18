# Convert

- `-c:v copy`: Pass through embedded artwork (Note this is required for `m4a` output when
  the source has cover art)

## To MP3

```
ffmpeg -i input.m4a -c:v copy -q:a 0 output.mp3
```

`-q:a 0` uses LAME's highest VBR quality (`V0`, `~245 kbps`, the default
is `128 kbps` CBR)

## To WebM

```
ffmpeg -i input.mp4 output.webm
```

## To Apple Lossless

```
ffmpeg -i input.flac -c:v copy -c:a alac output.m4a
```

# Join `flac`

Create an `inputs.txt` file:

```
printf "file '%s'\n" *.flac > inputs.txt
```

Then convert:

```
ffmpeg -f concat -i inputs.txt -c:a alac output.m4a
```

# Inspect Metadata

```
ffprobe file.mkv
```
