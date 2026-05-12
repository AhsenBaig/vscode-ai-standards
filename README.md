(append)
---
**🔗 Workspace Baseline & Standards**

This repository follows the [cosgiant/infra-meta workspace baseline](https://github.com/cosgiant/infra-meta) for:
- Fortune 500 DevSecOps standards
- Directory structure and repo roles
- AI/automation agent context
- Compliance and documentation

See `.workspace-baseline.yaml` in [infra-meta](https://github.com/cosgiant/infra-meta) for the single source of truth.
# VS Code AI Standards

[![Validate VS Code Configuration](https://github.com/AhsenBaig/vscode-ai-standards/actions/workflows/validate-vscode.yml/badge.svg)](https://github.com/AhsenBaig/vscode-ai-standards/actions/workflows/validate-vscode.yml)

Single source of truth for AI‑optimized VS Code configuration across all repositories. Includes Claude Code + Copilot settings, WSL integration, recommended extensions, workspace tasks, bootstrap scripts, and a GitHub Action for validation.

## 🎯 Overview

This repository provides **Fortune 50 best-practice** VS Code configurations optimized for AI-assisted development with:

- **GitHub Copilot** - AI pair programming
- **Claude Code** - Advanced AI assistance  
- **WSL Integration** - Seamless Windows/Linux development
- **Automated Setup** - Bootstrap scripts for quick configuration
- **CI/CD Validation** - GitHub Actions workflow to ensure standards compliance

## 📁 Repository Structure

```
vscode-ai-standards/
├── .vscode/
│   ├── settings.json      # VS Code editor & AI tool settings
│   ├── extensions.json    # Recommended extensions list
│   └── tasks.json         # Automated tasks for validation & setup
├── bootstrap/
│   ├── setup_vscode_ai.ps1  # PowerShell setup script (Windows)
│   └── setup_vscode_ai.sh   # Bash setup script (Linux/WSL/macOS)
├── .github/
│   └── workflows/
│       └── validate-vscode.yml  # CI/CD validation workflow
└── README.md              # This file
```

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

#### Windows (PowerShell)
```powershell
# Clone the repository
git clone https://github.com/AhsenBaig/vscode-ai-standards.git
cd vscode-ai-standards

# Run bootstrap script
.\bootstrap\setup_vscode_ai.ps1
```

#### Linux/WSL/macOS (Bash)
```bash
# Clone the repository
git clone https://github.com/AhsenBaig/vscode-ai-standards.git
cd vscode-ai-standards

# Run bootstrap script
bash bootstrap/setup_vscode_ai.sh
```

### Option 2: Manual Setup

1. **Clone this repository**
   ```bash
   git clone https://github.com/AhsenBaig/vscode-ai-standards.git
   ```

2. **Copy `.vscode` folder** to your project
   ```bash
   cp -r vscode-ai-standards/.vscode /path/to/your/project/
   ```

3. **Install recommended extensions**
   - Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
   - Type: `Extensions: Show Recommended Extensions`
   - Click "Install All"

4. **Restart VS Code** to apply all settings

## ⚙️ Configuration Details

### Settings (`.vscode/settings.json`)

Our configuration includes:

- **Editor Preferences**: Format on save, auto-save on focus change, 80/120 column rulers
- **GitHub Copilot**: Enabled for most file types with auto-completions and code actions
- **Claude Code Integration**: API key from environment variable, optimized model settings
- **WSL Support**: Terminal profiles, file watcher settings
- **Language-Specific**: Formatters and linters for JavaScript, TypeScript, Python, YAML, etc.
- **Security**: Telemetry disabled, workspace trust enabled

### Extensions (`.vscode/extensions.json`)

Required extensions include:

**AI & Copilot**
- GitHub Copilot & Copilot Chat

**Code Quality**
- Prettier, ESLint, EditorConfig

**Language Support**
- Python (Pylance, Black, isort)
- PowerShell
- YAML, TOML

**WSL & Remote Development**
- Remote - WSL
- Remote - Containers
- Remote - SSH

**Git & Version Control**
- GitLens, Git Graph

**Utilities**
- Path IntelliSense, Error Lens, TODO Tree

### Tasks (`.vscode/tasks.json`)

Pre-configured tasks for:
- Installing VS Code extensions
- Running bootstrap scripts
- Validating VS Code settings
- Testing WSL connection
- Git operations

Access tasks via Command Palette: `Tasks: Run Task`

## 🔧 Bootstrap Scripts

### PowerShell Script (`setup_vscode_ai.ps1`)

Features:
- ✅ Checks VS Code CLI availability
- ✅ Installs required extensions
- ✅ Validates WSL installation
- ✅ Verifies Git configuration
- ✅ Checks `.vscode` configuration files

### Bash Script (`setup_vscode_ai.sh`)

Features:
- ✅ Checks VS Code CLI availability
- ✅ Installs required extensions  
- ✅ Detects WSL environment
- ✅ Verifies Git configuration
- ✅ Checks Python & Node.js environments
- ✅ Validates `.vscode` configuration files

Both scripts are idempotent and safe to run multiple times.

## 🔐 Security & Privacy

- **Telemetry Disabled**: VS Code telemetry is turned off
- **Workspace Trust**: Enabled for security
- **Environment Variables**: Sensitive data (API keys) loaded from environment
- **No Hardcoded Secrets**: All credentials use environment variables

### Setting up Claude Code API Key

```bash
# Linux/WSL/macOS
export ANTHROPIC_API_KEY="your-api-key-here"

# Windows PowerShell
$env:ANTHROPIC_API_KEY = "your-api-key-here"

# Add to your shell profile for persistence
echo 'export ANTHROPIC_API_KEY="your-api-key-here"' >> ~/.bashrc  # Linux/WSL
echo '$env:ANTHROPIC_API_KEY = "your-api-key-here"' >> $PROFILE  # PowerShell
```

## 🧪 GitHub Actions Validation

The included workflow (`.github/workflows/validate-vscode.yml`) automatically validates:

- ✅ Required files exist
- ✅ JSON syntax is valid
- ✅ Required settings are present
- ✅ Required extensions are listed
- ✅ Bootstrap scripts have valid syntax
- ✅ README documentation exists

Run manually via: Actions → Validate VS Code Configuration → Run workflow

## 💡 Usage Examples

### Use in Your Project

1. **Copy configuration to your project**:
   ```bash
   # From your project root
   cp -r /path/to/vscode-ai-standards/.vscode .
   ```

2. **Customize settings** (optional):
   - Modify `.vscode/settings.json` for project-specific needs
   - Add/remove extensions in `.vscode/extensions.json`
   - Update tasks in `.vscode/tasks.json`

3. **Commit to your repository**:
   ```bash
   git add .vscode/
   git commit -m "Add VS Code AI standards configuration"
   git push
   ```

### Team Setup

For teams, ensure all members:
1. Clone the project
2. Open in VS Code
3. Install recommended extensions when prompted
4. Configure their API keys (Copilot, Claude)

## 🌐 WSL Integration

### Opening Project in WSL

1. **From Windows**: 
   - Open Command Palette (`Ctrl+Shift+P`)
   - Type: `Remote-WSL: Open Folder in WSL`
   - Select your project folder

2. **From WSL Terminal**:
   ```bash
   cd /path/to/project
   code .
   ```

Extensions will automatically install in the WSL environment.

### WSL Best Practices

- Store code in WSL filesystem (`~/projects/`) for better performance
- Use WSL terminal for git operations
- VS Code settings sync automatically between Windows and WSL

## 📝 DRY Principles & Code Smell Prevention

This configuration follows **Don't Repeat Yourself (DRY)** principles:

✅ **Single Source of Truth**: One repository for all VS Code AI configurations  
✅ **Reusable**: Copy to any project without modification  
✅ **Maintainable**: Update once, apply everywhere  
✅ **Automated**: Scripts handle setup, reducing manual errors  
✅ **Validated**: CI/CD ensures standards compliance  
✅ **Documented**: Comprehensive guides prevent knowledge silos  

## 🏢 Fortune 50 Standards Compliance

This configuration adheres to enterprise-grade standards:

- **Consistency**: Standardized settings across all projects
- **Security**: No hardcoded secrets, workspace trust enabled
- **Automation**: Bootstrap scripts and CI/CD validation
- **Documentation**: Comprehensive README and inline comments
- **Version Control**: All configurations in Git
- **Extensibility**: Easy to customize per project needs
- **Maintainability**: Clear structure and naming conventions

## 🛠️ Troubleshooting

### VS Code CLI Not Found
```bash
# Add VS Code to PATH (Linux/WSL)
echo 'export PATH="$PATH:/mnt/c/Users/YOUR_USERNAME/AppData/Local/Programs/Microsoft VS Code/bin"' >> ~/.bashrc

# Windows: Reinstall VS Code and select "Add to PATH"
```

### Extensions Not Installing
- Check internet connection
- Restart VS Code
- Install manually: `code --install-extension <extension-id>`

### Copilot Not Working
1. Sign in to GitHub in VS Code
2. Ensure Copilot subscription is active
3. Check settings: `github.copilot.enable` is `true`

### WSL Issues
```bash
# Check WSL status (Windows)
wsl --status

# Update WSL
wsl --update

# Set default WSL version
wsl --set-default-version 2
```

## 📚 Additional Resources

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [Anthropic Claude Docs](https://docs.anthropic.com/)

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Make your changes
4. Test with validation workflow
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 🙏 Acknowledgments

- GitHub Copilot team for AI pair programming
- Anthropic for Claude AI assistance
- Microsoft for VS Code and WSL
- Open source community for extensions

---

**Note**: This is a living document. Standards and tools evolve. Keep this configuration updated with latest best practices.
