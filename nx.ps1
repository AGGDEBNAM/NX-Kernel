# ===================================================================
# NX Platform
# nx.ps1
# Entry Point
# ===================================================================

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [ValidateNotNullOrEmpty()]
    [string]$Command = "help"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$NxModule = Join-Path $PSScriptRoot "NX.psm1"

Import-Module $NxModule -Force

try {

    $Result = Start-NX -Command $Command

    if ($null -ne $Result) {
        $Result | Format-List *
    }

}
catch {

    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Red
    Write-Host " NX Kernel Error" -ForegroundColor Red
    Write-Host "==========================================" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
    Write-Host ""

    exit 1
}