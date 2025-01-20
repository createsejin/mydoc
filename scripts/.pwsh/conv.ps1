# ffmpeg -i "$args[0]" -b:a 192k -q:a 2 -ar 44100 -ac 2 -acodec libmp3lame -vn -map_metadata 0 -id3v2_version 3 "output/$args[0].mp3"
Write-Output $args[0]