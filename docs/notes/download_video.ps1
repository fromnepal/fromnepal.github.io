param (
    [string]$url
)

$tempDir = "C:\Temp\yt-dlp"
date;
New-Item -ItemType Directory -Path $tempDir -Force
yt-dlp.exe --verbose --write-sub --sub-lang en --restrict-filenames --add-metadata -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --sponsorblock-mark all --sponsorblock-remove all --merge-output-format mp4 -o "$tempDir\%(id)s.%(ext)s" $url
date;
$videoFile = Get-ChildItem -Path $tempDir -Filter *.mp4 | Select-Object -First 1
date;
$subtitleFile = Get-ChildItem -Path $tempDir -Filter *.vtt | Select-Object -First 1
date;

# Function to clean file names
function Clean-FileName {
    param (
        [string]$fileName
    )
    return $fileName -replace '[^A-Za-z0-9]', ''
}

if ($subtitleFile) {
    $subtitlePath = $subtitleFile.FullName
    $cleanSubtitlePath = Join-Path -Path $tempDir -ChildPath (Clean-FileName -fileName $subtitleFile.Name)
    Rename-Item -Path $subtitlePath -NewName $cleanSubtitlePath
    $subtitlePath = $cleanSubtitlePath
}

$cleanVideoPath = Join-Path -Path $tempDir -ChildPath (Clean-FileName -fileName $videoFile.Name)
Rename-Item -Path $videoFile.FullName -NewName $cleanVideoPath
$videoFile = Get-Item -Path $cleanVideoPath

if ($subtitleFile) {
    ffmpeg -loglevel debug -i "$($videoFile.FullName)" -vf "subtitles='$subtitlePath':force_style='FontName=Arial,FontSize=24'" -c:v libx264 -c:a aac -strict experimental -movflags +faststart "$tempDir\$($videoFile.BaseName)_reencoded.mp4"
} else {
    ffmpeg -i "$($videoFile.FullName)" -c:v libx264 -c:a aac -strict experimental -movflags +faststart "$tempDir\$($videoFile.BaseName)_reencoded.mp4"
}
date;
Move-Item -Path "$tempDir\$($videoFile.BaseName)_reencoded.mp4" -Destination "\\TP-Share\G\shared\jellyfin\shows\downloaded"
date;
Remove-Item -Path $tempDir -Recurse -Force
date;
