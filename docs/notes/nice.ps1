While ($True) {
    Get-Date;
    cd "C:\Users\kushal\src\myhtml\fromnepal\public\notes\"
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
        Write-Output $result.Content
    } catch {
        $statusCode = $_.Exception.Response.StatusCode.Value__
        Write-Output "Error: $($_.Exception.Message)"
    }
    $result;
    $statusCode | Out-File -FilePath "C:\\Users\\kushal\\src\\myhtml\\fromnepal\\public\\notes\\status_code.txt" -Append
    Get-Date;
    Start-Sleep -s 30;
    date; 
    cd "C:\Users\kushal\src\myhtml\fromnepal"; 
    date; 
    yarn; 
    date; 
    yarn run build; 
    date; 
    git add .; 
    date; 
    git status; 
    date; 
    git commit --message "build application" --message "from the terminal" --verbose; 
    date;
}
