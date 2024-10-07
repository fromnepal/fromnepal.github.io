While ($True) {
    Get-Date;
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0"
    try {
        $result = Invoke-WebRequest -UseBasicParsing -Uri "https://nice.runasp.net/Analytics/GetAnalyticsData?key=hello" `
        -WebSession $session `
        -Headers @{
            "authority"="nice.runasp.net"
            "method"="GET"
            "path"="/Analytics/GetAnalyticsData?key=hello"
            "scheme"="https"
            "accept"="*/*"
            "accept-encoding"="gzip, deflate, br, zstd"
            "accept-language"="en-US,en;q=0.9"
            "priority"="u=1, i"
            "referer"="https://nice.runasp.net/swagger/index.html"
            "sec-ch-ua"="`"Microsoft Edge`";v=`"129`", `"Not=A?Brand`";v=`"8`", `"Chromium`";v=`"129`""
            "sec-ch-ua-mobile"="?0"
            "sec-ch-ua-platform"="`"Windows`""
            "sec-fetch-dest"="empty"
            "sec-fetch-mode"="cors"
            "sec-fetch-site"="same-origin"
        }
        $statusCode = $result.StatusCode
    } catch {
        $statusCode = $_.Exception.Response.StatusCode.Value__
    }
    $result;
    $statusCode | Out-File -FilePath "status_code.txt" -Append
    Get-Date;
    Start-Sleep -s 30;
}
