# ===================================================================
# NX Platform
# Context.psm1
# ===================================================================

Set-StrictMode -Version Latest

$script:NXContext = $null

function New-NXContext {

    [CmdletBinding()]
    param()

    $script:NXContext = [PSCustomObject]@{

        Kernel = [PSCustomObject]@{

            Name        = "NX Platform"
            Version     = "1.0.0"
            Environment = "Development"
            Status      = "Initializing"

        }

        Host = [PSCustomObject]@{

            ComputerName = $env:COMPUTERNAME
            UserName     = $env:USERNAME
            PowerShell   = $PSVersionTable.PSVersion.ToString()
            Platform     = $PSVersionTable.Platform
            OS           = [System.Environment]::OSVersion.VersionString

        }

        Runtime = [PSCustomObject]@{

            ExecutionId = [guid]::NewGuid().ToString()
            StartTime   = Get-Date
            EndTime     = $null
            ExitCode    = 0

        }

        Configuration = @{}

        Manifest = @{}

        Modules = @()

        Events = @()

        Reports = @()

        Errors = @()

    }

    return $script:NXContext

}

function Get-NXContext {

    [CmdletBinding()]
    param()

    if ($null -eq $script:NXContext) {
        throw "NX Context has not been initialized."
    }

    return $script:NXContext

}

function Set-NXContext {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [pscustomobject]$Context
    )

    $script:NXContext = $Context

}

function Remove-NXContext {

    [CmdletBinding()]
    param()

    $script:NXContext = $null

}

Export-ModuleMember -Function `
New-NXContext,
Get-NXContext,
Set-NXContext,
Remove-NXContext