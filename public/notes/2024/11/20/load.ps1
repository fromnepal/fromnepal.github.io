# Infinite loop to repeatedly measure the time taken for a web request
while ($true) {
    # Measure the time taken to perform the web request
    $timing = Measure-Command {
        Invoke-WebRequest -UseBasicParsing -Uri "http://colorado:5000/api/Contact"
    }
    
    # Output the total seconds taken for the request
    Write-Host "Request time: $($timing.TotalSeconds) seconds"
}
