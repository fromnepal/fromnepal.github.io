# Number of concurrent requests
$numberOfRequests = 10000

# Array to hold job results
$jobs = @()

# Start multiple background jobs for load testing
for ($i = 1; $i -le $numberOfRequests; $i++) {
    $jobs += Start-Job -ScriptBlock {
        param ($url)

        # Function to perform the web request and measure time
        function Invoke-LoadTest {
            param (
                [string]$url
            )
            Measure-Command {
                Invoke-WebRequest -UseBasicParsing -Uri $url
            }
        }

        # Call the function and return the result
        Invoke-LoadTest -url $url
    } -ArgumentList "http://colorado:5000/api/Contact"
}

# Wait for all jobs to complete and collect results
$results = $jobs | ForEach-Object {
    Receive-Job -Job $_
    Remove-Job -Job $_ -Force
}

# Output the results
$results | ForEach-Object {
    Write-Host "Request time: $($_.TotalSeconds) seconds"
}
