$urls = @(
    "https://www.instagram.com/reel/C-vv9DkPukQ",
    "https://www.instagram.com/reel/C-YKfCwyzUe",
    "https://www.instagram.com/reel/C-0I8WZyxwU",
    "https://www.instagram.com/reel/C8ru4e0oCuX",
    "https://www.instagram.com/reel/C9Nx2CbRIYj",
    "https://www.instagram.com/reel/C-xRjYrMkGJ",
    "https://www.instagram.com/reel/C-PcfPBpZzx",
    "https://www.instagram.com/reel/C-muG9tyXh2",
    "https://www.instagram.com/reel/C-kTLb_MILz",
    "https://www.instagram.com/reel/C-kWELKNz1y",
    "https://www.instagram.com/reel/C7xpBaZt4Zx",
    "https://www.instagram.com/reel/C-p0bcZocfS",
    "https://www.instagram.com/reel/C-uKvsloEkX",
    "https://www.instagram.com/reel/C-wrLKtMI2M",
    "https://www.instagram.com/reel/C-w9ZJioynN",
    "https://www.instagram.com/reel/C-hyFX6g26Q",
    "https://www.instagram.com/reel/C81nVsZJzir",
    "https://www.instagram.com/reel/C-soIt8OP0q"
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
