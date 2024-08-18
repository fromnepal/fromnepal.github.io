$urls = @(
    "https://www.instagram.com/reel/C-OlF11tQ0T",
    "https://www.instagram.com/reel/C-qUuPFxDg1",
    "https://www.instagram.com/reel/C-SvuHFvV1t",
    "https://www.instagram.com/reel/C8ZZQsZCBXS",
    "https://www.instagram.com/reel/C-vbW3gxIfv",
    "https://www.instagram.com/reel/C-vrdvePUbP",
    "https://www.instagram.com/reel/C-xJrzGPxKR",
    "https://www.instagram.com/reel/C9kftDZBdxw",
    "https://www.instagram.com/reel/C-z_HoNJeSq",
    "https://www.instagram.com/reel/C-v-4nioBim",
    "https://www.instagram.com/reel/C-s9X8_vg6h",
    "https://www.instagram.com/reel/C-zS61nSTAD",
    "https://www.instagram.com/reel/C-0EqfLNU2T",
    "https://www.instagram.com/reel/C98ekIkOdIg",
    "https://www.instagram.com/reel/C6eK77eI0Zq",
    "https://www.instagram.com/reel/C-OlSlDspPr",
    "https://www.instagram.com/reel/C7wS3JapkSw",
    "https://www.instagram.com/reel/C9nEiR6uMp_",
    "https://www.instagram.com/reel/C9uXZU-BYqw",
    "https://www.instagram.com/reel/C6ZIr8ENLKn",
    "https://www.instagram.com/reel/C8pBGwGse0Q",
    "https://www.instagram.com/reel/C8YaPk5vQMo",
    "https://www.instagram.com/reel/C-s7VQRyHx8",
    "https://www.instagram.com/reel/C-uhzj3ojTf",
    "https://www.instagram.com/reel/C-aeRNpS4Mw",
    "https://www.instagram.com/reel/C-ufB09SwzT",
    "https://www.instagram.com/reel/C-VRMH2ut1X",
    "https://www.instagram.com/reel/C-wFu3uhKnL",
    "https://www.instagram.com/reel/C-z6CohM_YE",
    "https://www.instagram.com/reel/C9vFMRFB_so",
    "https://www.instagram.com/reel/C32wmP1rHOI",
    "https://www.instagram.com/reel/C7UpqmRtkcI",
    "https://www.instagram.com/reel/C72yfXMoYZl",
    "https://www.instagram.com/reel/C9rpCivJRBL",
    "https://www.instagram.com/reel/C-wgIjTtLn-",
    "https://www.instagram.com/reel/C3zMOhLrrMt",
    "https://www.instagram.com/reel/C-F8GpyyqHZ",
    "https://www.instagram.com/reel/C7PGzItOxCN",
    "https://www.instagram.com/reel/C-Cqdc_C6hO",
    "https://www.instagram.com/reel/C4JTnyyMtdH",
    "https://www.instagram.com/reel/C6rkPcsvSGW",
    "https://www.instagram.com/reel/C-OAMcOx3xv",
    "https://www.instagram.com/reel/C71m2TcSy1L",
    "https://www.instagram.com/reel/C-XegJapX7K",
    "https://www.instagram.com/reel/C9tWBOGK4nW",
    "https://www.instagram.com/reel/C-tqfryvlRR",
    "https://www.instagram.com/reel/C-m7cP0y9ow"
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
