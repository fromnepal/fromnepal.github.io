$env:DOTNET_CLI_TELEMETRY_OPTOUT='1'
$baseDir = "C:\Users\kushal\src\mydotnet\"
$configurations = @("Debug", "Release")
$osPlatforms = @("win-x64", "linux-x64", "osx-x64", "linux-arm64")

cd $baseDir

Start-Transcript -Path "output.txt"

foreach ($config in $configurations) {
    foreach ($os in $osPlatforms) {
        Write-Host "Building with configuration: $config, OS: $os"
        Get-Date
        dotnet clean
        Get-Date
        dotnet build -c $config
        Get-Date
        dotnet publish -c $config -r $os
        Get-Date
        dotnet test
        Get-Date
    }
}

cd "C:\Users\kushal\src\mydotnet\tests\"
Get-Date
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
Get-Date
reportgenerator -reports:coverage.cobertura.xml -targetdir:coverage-report
Get-Date
Move-Item -Path "C:\Users\kushal\src\mydotnet\tests\coverage-report\*" -Destination "C:\Users\kushal\src\mydotnet\docs" -Force
Get-Date

Stop-Transcript

cd "C:\Users\kushal\src\mydotnet\"
git add .
Get-Date
git status
Get-Date
git commit --message "build application" --message "from the terminal" --verbose
Get-Date
git pull --rebase origin master --verbose
Get-Date
# git push origin master --verbose
Get-Date