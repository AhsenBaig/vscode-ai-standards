#!/usr/bin/env pwsh
# ============================================
# VS Code AI Standards - PowerShell Bootstrap
# Fortune 50 Best Practice Setup Script
# ============================================

<#
.SYNOPSIS
    Bootstrap script for VS Code AI Standards configuration on Windows/PowerShell.

.DESCRIPTION
    This script sets up VS Code with AI tooling (Copilot, Claude Code), WSL integration,
    and recommended extensions following Fortune 50 best practices.

.EXAMPLE
    .\setup_vscode_ai.ps1
#>

[CmdletBinding()]
param()

# Set strict mode
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ========== Configuration ==========
$REQUIRED_EXTENSIONS = @(
    "github.copilot",
    "github.copilot-chat",
    "ms-vscode-remote.remote-wsl",
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "ms-python.python",
    "ms-python.vscode-pylance",
    "ms-vscode.powershell",
    "eamodio.gitlens"
)

# ========== Functions ==========

function Write-Header {
    param([string]$Message)
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host " $Message" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-WarningMessage {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Write-ErrorMessage {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Test-Command {
    param([string]$Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

function Test-VSCodeInstalled {
    if (Test-Command "code") {
        Write-Success "VS Code CLI found"
        return $true
    } else {
        Write-ErrorMessage "VS Code CLI not found. Please ensure VS Code is installed and 'code' is in PATH."
        return $false
    }
}

function Install-VSCodeExtensions {
    Write-Header "Installing VS Code Extensions"
    
    foreach ($extension in $REQUIRED_EXTENSIONS) {
        Write-Host "Installing: $extension..." -NoNewline
        try {
            $output = & code --install-extension $extension --force 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Success " Installed"
            } else {
                Write-WarningMessage " Already installed or failed"
            }
        } catch {
            Write-WarningMessage " Error: $_"
        }
    }
}

function Test-WSL {
    Write-Header "Checking WSL Installation"
    
    if (Test-Command "wsl") {
        Write-Host "Checking WSL status..." -NoNewline
        try {
            $wslStatus = & wsl --status 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Success " WSL is installed and configured"
                Write-Host $wslStatus
            } else {
                Write-WarningMessage " WSL may not be fully configured"
            }
        } catch {
            Write-WarningMessage " Unable to verify WSL status"
        }
    } else {
        Write-WarningMessage "WSL not found. Install WSL for full AI development experience."
        Write-Host "  Run: wsl --install"
    }
}

function Copy-VSCodeSettings {
    Write-Header "Verifying VS Code Configuration Files"
    
    $vscodeDir = Join-Path $PSScriptRoot ".." ".vscode"
    
    if (Test-Path $vscodeDir) {
        $settingsFile = Join-Path $vscodeDir "settings.json"
        $extensionsFile = Join-Path $vscodeDir "extensions.json"
        $tasksFile = Join-Path $vscodeDir "tasks.json"
        
        if (Test-Path $settingsFile) {
            Write-Success "settings.json found"
        } else {
            Write-WarningMessage "settings.json not found"
        }
        
        if (Test-Path $extensionsFile) {
            Write-Success "extensions.json found"
        } else {
            Write-WarningMessage "extensions.json not found"
        }
        
        if (Test-Path $tasksFile) {
            Write-Success "tasks.json found"
        } else {
            Write-WarningMessage "tasks.json not found"
        }
    } else {
        Write-ErrorMessage ".vscode directory not found"
    }
}

function Test-GitConfiguration {
    Write-Header "Checking Git Configuration"
    
    if (Test-Command "git") {
        Write-Success "Git is installed"
        
        $gitUser = & git config user.name 2>$null
        $gitEmail = & git config user.email 2>$null
        
        if ($gitUser -and $gitEmail) {
            Write-Success "Git user configured: $gitUser <$gitEmail>"
        } else {
            Write-WarningMessage "Git user not fully configured"
            Write-Host "  Set user: git config --global user.name 'Your Name'"
            Write-Host "  Set email: git config --global user.email 'your.email@example.com'"
        }
    } else {
        Write-WarningMessage "Git not found. Install Git for version control."
    }
}

function Show-NextSteps {
    Write-Header "Setup Complete!"
    
    Write-Host @"
Next Steps:
  1. Restart VS Code to apply all changes
  2. Configure GitHub Copilot:
     - Sign in to GitHub via VS Code
     - Activate Copilot in VS Code settings
  3. Configure Claude Code (if using):
     - Set ANTHROPIC_API_KEY environment variable
     - Restart VS Code
  4. For WSL development:
     - Open folder in WSL: Remote-WSL: Open Folder in WSL
     - Extensions will auto-install in WSL environment
  5. Run validation tasks:
     - Ctrl+Shift+P > Tasks: Run Task > Validate: All Checks

Documentation: See README.md for detailed configuration guides
"@
}

# ========== Main Execution ==========

function Main {
    Write-Host @"
╔═══════════════════════════════════════════════════════════╗
║   VS Code AI Standards Bootstrap (PowerShell)             ║
║   Fortune 50 Best Practices Setup                         ║
╚═══════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

    # Prerequisites check
    if (-not (Test-VSCodeInstalled)) {
        Write-ErrorMessage "Cannot continue without VS Code. Exiting."
        exit 1
    }
    
    # Run setup steps
    Copy-VSCodeSettings
    Install-VSCodeExtensions
    Test-WSL
    Test-GitConfiguration
    Show-NextSteps
    
    Write-Host "`n" -NoNewline
    Write-Success "Bootstrap completed successfully!"
}

# Run main function
Main
