param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$CopilotDir = if ($env:COPILOT_HOME) {
    $env:COPILOT_HOME
} else {
    Join-Path $HOME ".copilot"
}
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

function Write-Step {
    param([string]$Message)
    Write-Host "  $Message"
}

function Ensure-Directory {
    param([string]$Path)

    if ($DryRun) {
        Write-Step "would create $Path"
        return
    }

    New-Item -ItemType Directory -Path $Path -Force | Out-Null
}

function Install-StarterFile {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (Test-Path $Destination) {
        $SourceHash = (Get-FileHash $Source).Hash
        $DestinationHash = (Get-FileHash $Destination).Hash
        if ($SourceHash -eq $DestinationHash) {
            Write-Step "unchanged $Destination"
            return
        }
    }

    if ($DryRun) {
        if (Test-Path $Destination) {
            Write-Step "would back up $Destination"
        }
        Write-Step "would install $Destination"
        return
    }

    $Parent = Split-Path -Parent $Destination
    New-Item -ItemType Directory -Path $Parent -Force | Out-Null
    if (Test-Path $Destination) {
        Copy-Item $Destination "$Destination.pre-copilot-starter-$Stamp"
        Write-Step "backed up $Destination"
    }
    Copy-Item $Source $Destination
    Write-Step "installed $Destination"
}

function Test-DirectoryMatches {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path $Destination -PathType Container)) {
        return $false
    }

    $SourceFiles = @(Get-ChildItem $Source -File -Recurse)
    $DestinationFiles = @(Get-ChildItem $Destination -File -Recurse)
    if ($SourceFiles.Count -ne $DestinationFiles.Count) {
        return $false
    }

    foreach ($File in $SourceFiles) {
        $RelativePath = [System.IO.Path]::GetRelativePath($Source, $File.FullName)
        $DestinationFile = Join-Path $Destination $RelativePath
        if (-not (Test-Path $DestinationFile -PathType Leaf)) {
            return $false
        }
        if ((Get-FileHash $File.FullName).Hash -ne
            (Get-FileHash $DestinationFile).Hash) {
            return $false
        }
    }

    return $true
}

function Install-StarterSkill {
    param([string]$Source)

    $Name = Split-Path -Leaf $Source
    $Destination = Join-Path (Join-Path $CopilotDir "skills") $Name

    if (Test-DirectoryMatches $Source $Destination) {
        Write-Step "unchanged skill $Name"
        return
    }

    if ($DryRun) {
        if (Test-Path $Destination) {
            Write-Step "would back up $Destination"
        }
        Write-Step "would install skill $Name"
        return
    }

    New-Item -ItemType Directory -Path (Split-Path -Parent $Destination) -Force | Out-Null
    if (Test-Path $Destination) {
        Copy-Item $Destination "$Destination.pre-copilot-starter-$Stamp" -Recurse
        Write-Step "backed up skill $Name"
    }
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    Copy-Item (Join-Path $Source "*") $Destination -Recurse -Force
    Write-Step "installed skill $Name"
}

Write-Host "Copilot Starter installer"
Write-Host "Target: $CopilotDir"
if ($DryRun) {
    Write-Host "DRY RUN - no files will change"
}

Ensure-Directory (Join-Path $CopilotDir "instructions")
Ensure-Directory (Join-Path $CopilotDir "skills")

Install-StarterFile `
    (Join-Path $Root "copilot/instructions/starter.instructions.md") `
    (Join-Path $CopilotDir "instructions/starter.instructions.md")

Get-ChildItem (Join-Path $Root "copilot/skills") -Directory |
    ForEach-Object { Install-StarterSkill $_.FullName }

$SettingsDestination = Join-Path $CopilotDir "settings.json"
if (Test-Path $SettingsDestination) {
    Write-Step "kept existing $SettingsDestination"
    Write-Step "starter settings remain at $(Join-Path $Root 'copilot/settings.json')"
} else {
    Install-StarterFile `
        (Join-Path $Root "copilot/settings.json") `
        $SettingsDestination
}

Write-Host ""
Write-Host "Done."
Write-Host "Start Copilot with: copilot"
Write-Host "Authenticate inside Copilot with: /login"
Write-Host "Inspect loaded configuration with: /instructions and /skills"
