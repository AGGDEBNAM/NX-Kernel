# ===================================================================
# NX Platform
# Composition Root
# ===================================================================

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# -------------------------------------------------------------------
# Module Imports
# -------------------------------------------------------------------

Import-Module "$PSScriptRoot\kernel\Bootstrap\Bootstrap.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Services\Configuration.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Services\Context.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Services\Logger.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Services\Runtime.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Services\Manifest.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Services\ModuleLoader.psm1" -Force
Import-Module "$PSScriptRoot\kernel\Kernel.psm1" -Force

# -------------------------------------------------------------------
# Internal Functions
# -------------------------------------------------------------------

function Initialize-NXPlatform {

    [CmdletBinding()]
    param()

    $Bootstrap = Initialize-NXBootstrap

    if (-not (Test-NXService -Name "Bootstrap")) {
        Register-NXService -Name "Bootstrap" -Instance $Bootstrap
    }

    if (-not (Test-NXService -Name "Configuration")) {
        $configurationService = [PSCustomObject]@{
            Name      = "Configuration"
            Version   = $Bootstrap.Version
            State     = "Registered"
            LoadedAt  = Get-Date
        }

        Register-NXService `
            -Name "Configuration" `
            -Instance $configurationService
    }

    if (-not (Test-NXService -Name "Context")) {
        $contextService = New-NXContext

        Register-NXService `
            -Name "Context" `
            -Instance $contextService
    }

    if (-not (Test-NXService -Name "Logger")) {
        $loggerService = [PSCustomObject]@{
            Name      = "Logger"
            Version   = $Bootstrap.Version
            State     = "Registered"
            LoadedAt  = Get-Date
        }

        Register-NXService `
            -Name "Logger" `
            -Instance $loggerService
    }

    if (-not (Test-NXService -Name "Runtime")) {
        $runtimeService = [PSCustomObject]@{
            Name      = "Runtime"
            Version   = $Bootstrap.Version
            State     = "Registered"
            LoadedAt  = Get-Date
        }

        Register-NXService `
            -Name "Runtime" `
            -Instance $runtimeService
    }

    if (-not (Test-NXService -Name "Manifest")) {
        $manifestService = [PSCustomObject]@{
            Name      = "Manifest"
            Version   = $Bootstrap.Version
            State     = "Registered"
            LoadedAt  = Get-Date
        }

        Register-NXService `
            -Name "Manifest" `
            -Instance $manifestService
    }

    if (-not (Test-NXService -Name "Kernel")) {
        $kernelService = [PSCustomObject]@{
            Name      = "Kernel"
            Version   = $Bootstrap.Version
            State     = "Ready"
            LoadedAt  = Get-Date
        }

        Register-NXService `
            -Name "Kernel" `
            -Instance $kernelService
    }

    return $Bootstrap
}

function Get-NXVersion {

    [CmdletBinding()]
    param()

    $Bootstrap = Get-NXBootstrap

    return [PSCustomObject]@{
        Name        = "NX Platform"
        Version     = $Bootstrap.Version
        Environment = $Bootstrap.Environment
        PowerShell  = $PSVersionTable.PSVersion.ToString()
        Platform    = $PSVersionTable.Platform
        BuildDate   = "2026-07-20"
    }
}

function Get-NXContext {

    [CmdletBinding()]
    param()

    return (Get-NXService -Name "Context").Instance
}

function Start-NX {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Command
    )

    $Bootstrap = Initialize-NXPlatform
    $Context = (Get-NXService -Name "Context").Instance

    return Start-NXKernel -Command $Command -PlatformVersion $Bootstrap.Version -Context $Context
}

# -------------------------------------------------------------------
# Public API
# -------------------------------------------------------------------

Export-ModuleMember -Function @(
    'Start-NX',
    'Get-NXVersion',
    'Get-NXContext'
)
