$env:DOTNET_CLI_TELEMETRY_OPTOUT='1'
$baseDir = "C:\Users\kushal\src\mydotnet\"
$configurations = @("Debug", "Release")
$osPlatforms = @("win-x64", "linux-x64", "osx-x64", "linux-arm64")

cd $baseDir

$baseDir *> dotnet.txt

foreach ($config in $configurations) {
    foreach ($os in $osPlatforms) {
        Write-Host "Building with configuration: $config, OS: $os" *>> dotnet.txt
        Get-Date *>> dotnet.txt
        dotnet clean *>> dotnet.txt
        Get-Date *>> dotnet.txt
        dotnet build -c $config *>> dotnet.txt
        Get-Date *>> dotnet.txt
        dotnet publish -c $config -r $os *>> dotnet.txt
        Get-Date *>> dotnet.txt
        dotnet test *>> dotnet.txt
        Get-Date *>> dotnet.txt
    }
}

cd "C:\Users\kushal\src\mydotnet\tests\"
Get-Date *>> dotnet.txt
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura *>> dotnet.txt
Get-Date *>> dotnet.txt
reportgenerator -reports:coverage.cobertura.xml -targetdir:coverage-report *>> dotnet.txt
Get-Date *>> dotnet.txt
Move-Item -Path "C:\Users\kushal\src\mydotnet\tests\coverage-report\*" -Destination "C:\Users\kushal\src\mydotnet\docs" -Force *>> dotnet.txt
Get-Date *>> dotnet.txt

cd "C:\Users\kushal\src\mydotnet\"
git add .
Get-Date
git status
Get-Date
git commit --message "build application" --message "from the terminal" --verbose
Get-Date
git pull --rebase origin master --verbose
Get-Date
git push origin master --verbose
Get-Date