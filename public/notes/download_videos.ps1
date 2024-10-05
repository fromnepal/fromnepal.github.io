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

# Check if the tempDir exists, if not, create it
if (-Not (Test-Path -Path $tempDir)) {
    Write-Output $date
    Write-Output "Create new folder for yt-dlp"
    New-Item -ItemType Directory -Path $tempDir
}

foreach ($url in $urls) {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $date = Get-Date
    Write-Output $date
    Get-ChildItem $tempDir
    $date = Get-Date
    Write-Output $date
    yt-dlp.exe --verbose --restrict-filenames --add-metadata -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4" --sponsorblock-mark all --sponsorblock-remove all --merge-output-format mp4 -o "$tempDir\$timestamp.%(ext)s" $url
    $date = Get-Date
    Write-Output $date
    $videoFile = Get-ChildItem -Path $tempDir -Filter *.mp4 | Select-Object -First 1
    $date = Get-Date
    Write-Output $date
    $date = Get-Date
    Write-Output $date
    Get-ChildItem $tempDir
    $videoFile

    if ($videoFile) {
        $cleanVideoName = Clean-FileName -fileName $videoFile.Name
        Write-Output "Cleaned video name: $cleanVideoName"
        $cleanVideoPath = Join-Path -Path $tempDir -ChildPath $cleanVideoName
        Rename-Item -Path $videoFile.FullName -NewName $cleanVideoPath
        $videoFile = Get-Item -Path $cleanVideoPath
        Write-Output "Cleaned video path: $($videoFile.FullName)"
        Write-Output "Running ffmpeg"
        $ffmpegCommand = "ffmpeg -i `"$($videoFile.FullName)`" -c:v libx264 -c:a aac -strict experimental -movflags +faststart `"$tempDir\$($videoFile.BaseName)_reencoded.mp4`""
        Write-Output $ffmpegCommand
        Invoke-Expression $ffmpegCommand
        $date = Get-Date
        Write-Output $date
        Move-Item -Path "$tempDir\$($videoFile.BaseName)_reencoded.mp4" -Destination "\\TP-Share\G\shared\jellyfin\shows\downloaded"
        $date = Get-Date
        Write-Output $date
    } else {
        Write-Output "Failed to download video from $url"
    }
    Remove-Item -Path $tempDir -Recurse -Force
    $date = Get-Date
    Write-Output $date
}
