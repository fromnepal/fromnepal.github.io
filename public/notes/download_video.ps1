param (
    [string]$url
)

$tempDir = "C:\Temp\yt-dlp"
date;
New-Item -ItemType Directory -Path $tempDir -Force
dir $tempDir
date;
yt-dlp.exe --verbose --write-sub --sub-lang en --restrict-filenames --add-metadata -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --sponsorblock-mark all --sponsorblock-remove all --merge-output-format mp4 -o "$tempDir\%(id)s.%(ext)s" $url
date;
$videoFile = Get-ChildItem -Path $tempDir -Filter *.mp4 | Select-Object -First 1
date;
$subtitleFile = Get-ChildItem -Path $tempDir -Filter *.vtt | Select-Object -First 1
date;
dir $tempDir;
ls $tempDir;
$videoFile;
$subtitleFile;
# Function to clean file names
function Clean-FileName {
    param (
        [string]$fileName
    )
    return $fileName -replace '[^A-Za-z0-9]', ''
}

if ($subtitleFile) {
    $subtitlePath = $subtitleFile.FullName
    $cleanSubtitleName = Clean-FileName -fileName $subtitleFile.Name
    $cleanSubtitlePath = Join-Path -Path $tempDir -ChildPath $cleanSubtitleName
    Rename-Item -Path $subtitlePath -NewName $cleanSubtitlePath
    $subtitlePath = $cleanSubtitlePath
    echo "Cleaned subtitle path: $subtitlePath"
}

$cleanVideoName = Clean-FileName -fileName $videoFile.Name
echo "Cleaned video name: $cleanVideoName"
$cleanVideoPath = Join-Path -Path $tempDir -ChildPath $cleanVideoName
Rename-Item -Path $videoFile.FullName -NewName $cleanVideoPath
$videoFile = Get-Item -Path $cleanVideoPath
echo "Cleaned video path: $($videoFile.FullName)"

if ($subtitleFile) {
    echo "Running ffmpeg with subtitles"
    $ffmpegCommand = "ffmpeg -loglevel debug -i `"$($videoFile.FullName)`" -vf `subtitles='C\\:Temp\\yt-dlp\\$($subtitleFile.Name)':force_style='FontName=Arial,FontSize=24'` -c:v libx264 -c:a aac -strict experimental -movflags +faststart `"$tempDir\$($videoFile.BaseName)_reencoded.mp4`""
    echo $ffmpegCommand
    Invoke-Expression $ffmpegCommand
} else {
    echo "Running ffmpeg without subtitles"
    $ffmpegCommand = "ffmpeg -i `"$($videoFile.FullName)`" -c:v libx264 -c:a aac -strict experimental -movflags +faststart `"$tempDir\$($videoFile.BaseName)_reencoded.mp4`""
    echo $ffmpegCommand
    Invoke-Expression $ffmpegCommand
}
date;
Move-Item -Path "$tempDir\$($videoFile.BaseName)_reencoded.mp4" -Destination "\\TP-Share\G\shared\jellyfin\shows\downloaded"
date;
Remove-Item -Path $tempDir -Recurse -Force
date;
