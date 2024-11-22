# Number of concurrent requests
$numberOfRequests = 10

# Array to hold job results
$jobs = @()

# Function to perform the web request and measure time
function Invoke-LoadTest {
    param (
        [string]$url
    )
    Measure-Command {
        Invoke-WebRequest -UseBasicParsing -Uri $url
    }
}

# Start multiple background jobs for load testing
for ($i = 1; $i -le $numberOfRequests; $i++) {
    $jobs += Start-Job -ScriptBlock {
        param ($url)
        Invoke-LoadTest -url $url
    } -ArgumentList "http://colorado:5000/api/Contact"
}

# Wait for all jobs to complete and collect results
$results = $jobs | ForEach-Object {
    Receive-Job -Job $_
    Remove-Job -Job $_
}

# Output the results
$results | ForEach-Object {
    Write-Host "Request time: $($_.TotalSeconds) seconds"
}
