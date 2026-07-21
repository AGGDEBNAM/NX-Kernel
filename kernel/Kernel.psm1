# ===================================================================
# NX Platform
# Kernel.psm1
# ===================================================================

function Get-NXVersion {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Version
    )

    return [PSCustomObject]@{
        Name          = "NX Platform"
        KernelVersion = $Version
        Environment   = "Development"
        PowerShell    = $PSVersionTable.PSVersion.ToString()
        Platform      = $PSVersionTable.Platform
        BuildDate     = "2026-07-20"
    }
}

function Start-NXKernel {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Command,

        [Parameter(Mandatory = $false)]
        [string]$PlatformVersion,

        [Parameter(Mandatory)]
        [pscustomobject]$Context
    )

    $Context.Kernel.Status = "Running"

    switch ($Command.ToLower()) {

        "context" {
            return $Context
        }

        "version" {
            if ([string]::IsNullOrWhiteSpace($PlatformVersion)) {
                throw "Platform version must be provided for the version command."
            }

            return Get-NXVersion -Version $PlatformVersion
        }

        default {
            throw "Unknown command: $Command"
        }
    }
}

Export-ModuleMember `
    -Function Get-NXVersion, Start-NXKernel