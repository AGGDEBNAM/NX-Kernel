# ===================================================================
# NX Platform
# Bootstrap Service
# Version: 0.2.0
# ===================================================================

# -------------------------------------------------------------------
# Internal State
# -------------------------------------------------------------------

# Metadata describing the registered service.
$script:NXBootstrap = [PSCustomObject]@{
    Initialized           = $false
    State                 = "Created"
    Version               = $null
    StartTime             = $null
    Environment           = "Development"
    ServicesLoaded        = 0
    InitializationDuration = $null
}

$script:NXServices = @{}

# -------------------------------------------------------------------
# Bootstrap
# -------------------------------------------------------------------

function Initialize-NXBootstrap {

    [CmdletBinding()]
    param()

    if (-not $script:NXBootstrap.Initialized) {

        $script:NXBootstrap.State = "Initializing"
        $script:NXBootstrap.StartTime = Get-Date
        $VersionFile = Get-NXVersionFile
        if (Test-Path $VersionFile) {
            $script:NXBootstrap.Version = (Get-Content $VersionFile -Raw).Trim()
        }
        $script:NXBootstrap.Initialized = $true
        $script:NXBootstrap.State = "Ready"
        $script:NXBootstrap.InitializationDuration =
    (Get-Date) - $script:NXBootstrap.StartTime
    }
    return $script:NXBootstrap
}

function Get-NXBootstrap {

    [CmdletBinding()]
    param()

    return $script:NXBootstrap
}

function Get-NXVersionFile {

    return Join-Path $PSScriptRoot "..\..\VERSION"

}

# -------------------------------------------------------------------
# Service Registry
# -------------------------------------------------------------------

function Register-NXService {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [object]$Instance
    )

    if ($script:NXServices.ContainsKey($Name)) {

        throw "Service '$Name' is already registered."

    }

    $script:NXServices[$Name] = [PSCustomObject]@{
    Name         = $Name
    Instance     = $Instance
    Version      = $script:NXBootstrap.Version
    State        = "Running"
    Dependencies = @()
    LoadedAt     = Get-Date
    }

    $script:NXBootstrap.ServicesLoaded++

}

function Get-NXService {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name

    )

    if (-not $script:NXServices.ContainsKey($Name)) {

        throw "Service '$Name' is not registered."

    }

    return $script:NXServices[$Name]
}

function Get-NXServices {

    [CmdletBinding()]
    param()

    return $script:NXServices
}

function Test-NXService {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name

    )
    return $script:NXServices.ContainsKey($Name)
}

Export-ModuleMember `
    -Function `
        Initialize-NXBootstrap, `
        Get-NXBootstrap, `
        Register-NXService, `
        Get-NXService, `
        Get-NXServices, `
        Test-NXService