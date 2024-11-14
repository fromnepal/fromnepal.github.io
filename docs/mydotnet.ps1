cd "C:\Users\kushal\src\mydotnet\"
Get-Date
dotnet clean
Get-Date
dotnet build
Get-Date
dotnet test
Get-Date

cd "C:\Users\kushal\src\mydotnet\tests\"
Get-Date
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura
reportgenerator -reports:coverage.cobertura.xml -targetdir:coverage-report
Get-Date
Move-Item -Path "C:\Users\kushal\src\mydotnet\tests\coverage-report\*" -Destination "C:\Users\kushal\src\mydotnet\docs" -Force
Get-Date

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