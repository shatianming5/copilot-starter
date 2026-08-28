$ErrorActionPreference = "Stop"
$CopilotDir = if ($env:COPILOT_HOME) {
    $env:COPILOT_HOME
} else {
    Join-Path $HOME ".copilot"
}
$Passed = 0
$Failed = 0

function Pass {
    param([string]$Message)
    Write-Host "PASS  $Message" -ForegroundColor Green
    $script:Passed++
}

function Fail {
    param([string]$Message)
    Write-Host "FAIL  $Message" -ForegroundColor Red
    $script:Failed++
}

if (Get-Command copilot -ErrorAction SilentlyContinue) {
    Pass "Copilot CLI is installed"
} else {
    Fail "Copilot CLI is not installed"
}

$Instruction = Join-Path $CopilotDir "instructions/starter.instructions.md"
if (Test-Path $Instruction -PathType Leaf) {
    Pass "starter instructions are installed"
} else {
    Fail "missing $Instruction"
}

foreach ($Name in @("debugging-basics", "review-basics", "simplify-basics")) {
    $Skill = Join-Path $CopilotDir "skills/$Name/SKILL.md"
    if ((Test-Path $Skill -PathType Leaf) -and
        (Select-String -Path $Skill -Pattern "^name:" -Quiet) -and
        (Select-String -Path $Skill -Pattern "^description:" -Quiet)) {
        Pass "skill $Name is installed"
    } else {
        Fail "missing or invalid $Skill"
    }
}

$Settings = Join-Path $CopilotDir "settings.json"
if (Test-Path $Settings -PathType Leaf) {
    try {
        Get-Content $Settings -Raw | ConvertFrom-Json | Out-Null
        Pass "settings.json is valid JSON"
    } catch {
        Fail "settings.json is invalid JSON"
    }
} else {
    Fail "missing $Settings"
}

Write-Host ""
Write-Host "$Passed passed, $Failed failed"
if ($Failed -gt 0) {
    exit 1
}
