$logFile = "C:\Users\kushal\src\myhtml\fromnepal\public\notes\silence.log"
$silenceIntervals = @()
$currentSilence = $null

Get-Content $logFile | ForEach-Object {
    if ($_ -match "silence_start: (\d+\.\d+)") {
        $currentSilence = [PSCustomObject]@{ Start = [double]$matches }
    } elseif ($_ -match "silence_end: (\d+\.\d+)") {
        $currentSilence.End = [double]$matches
        $silenceIntervals += $currentSilence
        $currentSilence = $null
    }
}

$silenceIntervals | ForEach-Object {
    Write-Output "Silence from $($_.Start) to $($_.End)"
}

# $inputFile = "C:\Users\kushal\Music\2024-10-14\gPZigJcJBMQ.mp3"
# $outputDir = "C:\Users\kushal\Music\2024-10-14"
# $index = 0

# $silenceIntervals | ForEach-Object {
#     $start = $_.Start
#     $end = $_.End
#     $duration = $end - $start
#     $outputFile = "$outputDir\split$($index++).mp3"

#     ffmpeg -i $inputFile -ss $start -t $duration -c copy $outputFile
# }
