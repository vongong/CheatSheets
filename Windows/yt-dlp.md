
# Yt-dlp
A feature-rich command-line audio/video downloader

## examples
```sh
# Download video
yt-dlp mp3 https://www.youtube.com/watch?v=WOg93THAyE0
yt-dlp mp3 https://www.youtube.com/watch?v=WOg93THAyE0 -o m:\new.mp4
yt-dlp mp3 https://www.youtube.com/watch?v=WOg93THAyE0 --no-mtime

# Download & convert to mp3 (assume ffmpeg is installed)
yt-dlp -x --audio-format mp3 https://www.youtube.com/watch?v=WOg93THAyE0

# get version
yt-dlp --version

# get help
yt-dlp --help

# update to current version
yt-dlp --update

# update to version (Channel@Version)
yt-dlp --update-to stable@2024.04.09

```