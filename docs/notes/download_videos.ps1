param (
    [string[]]$urls
)

$tempDir = "C:\Temp\yt-dlp"

# Function to clean file names
function Clean-FileName {
    param (
        [string]$fileName
    )
    return $fileName -replace '[^A-Za-z0-9]', ''
}

foreach ($url in $urls) {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $date = Get-Date
    Write-Output $date
    New-Item -ItemType Directory -Path $tempDir -Force
    Get-ChildItem $tempDir
    $date = Get-Date
    Write-Output $date
    yt-dlp.exe --verbose --write-sub --sub-lang en --restrict-filenames --add-metadata -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --sponsorblock-mark all --sponsorblock-remove all --merge-output-format mp4 -o "$tempDir\$timestamp.%(ext)s" $url
    $date = Get-Date
    Write-Output $date
    $videoFile = Get-ChildItem -Path $tempDir -Filter *.mp4 | Select-Object -First 1
    $date = Get-Date
    Write-Output $date
    $subtitleFile = Get-ChildItem -Path $tempDir -Filter *.vtt | Select-Object -First 1
    $date = Get-Date
    Write-Output $date
    Get-ChildItem $tempDir
    $videoFile
    $subtitleFile

    if ($subtitleFile) {
        $subtitlePath = $subtitleFile.FullName
        $cleanSubtitleName = Clean-FileName -fileName $subtitleFile.Name
        $cleanSubtitlePath = Join-Path -Path $tempDir -ChildPath $cleanSubtitleName
        Rename-Item -Path $subtitlePath -NewName $cleanSubtitlePath
        $subtitlePath = $cleanSubtitlePath
        Write-Output "Cleaned subtitle path: $subtitlePath"
    }

    $cleanVideoName = Clean-FileName -fileName $videoFile.Name
    Write-Output "Cleaned video name: $cleanVideoName"
    $cleanVideoPath = Join-Path -Path $tempDir -ChildPath $cleanVideoName
    Rename-Item -Path $videoFile.FullName -NewName $cleanVideoPath
    $videoFile = Get-Item -Path $cleanVideoPath
    Write-Output "Cleaned video path: $($videoFile.FullName)"

    if ($subtitleFile) {
        Write-Output "Running ffmpeg with subtitles"
        $ffmpegCommand = "ffmpeg -loglevel debug -i `"$($videoFile.FullName)`" -vf `subtitles='$($subtitlePath)':force_style='FontName=Arial,FontSize=24'` -c:v libx264 -c:a aac -strict experimental -movflags +faststart `"$tempDir\$($videoFile.BaseName)_reencoded.mp4`""
        Write-Output $ffmpegCommand
        Invoke-Expression $ffmpegCommand
    } else {
        Write-Output "Running ffmpeg without subtitles"
        $ffmpegCommand = "ffmpeg -i `"$($videoFile.FullName)`" -c:v libx264 -c:a aac -strict experimental -movflags +faststart `"$tempDir\$($videoFile.BaseName)_reencoded.mp4`""
        Write-Output $ffmpegCommand
        Invoke-Expression $ffmpegCommand
    }
    $date = Get-Date
    Write-Output $date
    Move-Item -Path "$tempDir\$($videoFile.BaseName)_reencoded.mp4" -Destination "\\TP-Share\G\shared\jellyfin\shows\downloaded"
    $date = Get-Date
    Write-Output $date
    Remove-Item -Path $tempDir -Recurse -Force
    $date = Get-Date
    Write-Output $date
}
