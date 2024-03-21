[CmdletBinding()]

Param (
    #use the paramenter -c in case the deploy folder needs to be cleared and sitecore logs cleared with it
    [switch]
    $c = $false,

    #use the parameter -f in case all dangling containers need to be cleared. This will execute a docker system prune
    [switch]
    $f = $false
)

docker compose down

if ($c -eq $true) {
    Write-Host "Removing all cm logs..." -ForegroundColor Yellow
    Get-ChildItem -Path (Join-Path $PSScriptRoot "docker\data\cm") -Exclude ".gitkeep" -Recurse | Remove-Item -Force -Recurse -Verbose
}

if($f -eq $true){
    Write-Host "Removing all dangling containers..." -ForegroundColor Yellow
    docker system prune -f
}

Write-Host "Done..." -ForegroundColor Green