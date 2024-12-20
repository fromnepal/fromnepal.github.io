$urls = @(
    "https://player.vimeo.com/video/906163902",
    "https://www.youtube.com/watch?v=s19nBOA2k_Y"
)

$tempDir = "C:\Temp\yt-dlp"
New-Item -ItemType Directory -Path $tempDir -Force

foreach ($url in $urls) {
    yt-dlp.exe --verbose --write-sub --sub-lang en --restrict-filenames --add-metadata -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --sponsorblock-mark all --sponsorblock-remove all --merge-output-format mp4 -o "$tempDir\%(title)s.%(ext)s" $url
}

$videoFiles = Get-ChildItem -Path $tempDir -Filter *.mp4
foreach ($videoFile in $videoFiles) {
    $subtitleFile = Get-ChildItem -Path $tempDir -Filter *.vtt | Where-Object { $_.BaseName -eq $videoFile.BaseName }
    if ($subtitleFile) {
        $subtitlePath = $subtitleFile.FullName
        ffmpeg -i "$($videoFile.FullName)" -vf "subtitles='$subtitlePath':force_style='FontName=Arial,FontSize=24'" -c:v libx264 -c:a aac -strict experimental -movflags +faststart "$tempDir\$($videoFile.BaseName)_reencoded.mp4"
    } else {
        ffmpeg -i "$($videoFile.FullName)" -c:v libx264 -c:a aac -strict experimental -movflags +faststart "$tempDir\$($videoFile.BaseName)_reencoded.mp4"
    }
    Move-Item -Path "$tempDir\$($videoFile.BaseName)_reencoded.mp4" -Destination "\\TP-Share\G\shared\jellyfin\shows\downloaded"
}

Remove-Item -Path $tempDir -Recurse -Force
