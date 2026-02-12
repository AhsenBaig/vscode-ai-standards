#!/usr/bin/env bash
# ============================================
# VS Code AI Standards - Bash Bootstrap
# Fortune 50 Best Practice Setup Script
# ============================================

set -euo pipefail

# ========== Configuration ==========
readonly REQUIRED_EXTENSIONS=(
    "github.copilot"
    "github.copilot-chat"
    "ms-vscode-remote.remote-wsl"
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-vscode.powershell"
    "eamodio.gitlens"
)

# ========== Colors ==========
readonly COLOR_RESET='\033[0m'
readonly COLOR_CYAN='\033[0;36m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_YELLOW='\033[0;33m'
readonly COLOR_RED='\033[0;31m'

# ========== Functions ==========

print_header() {
    echo -e "\n${COLOR_CYAN}========================================"
    echo -e " $1"
    echo -e "========================================${COLOR_RESET}\n"
}

print_success() {
    echo -e "${COLOR_GREEN}✓ $1${COLOR_RESET}"
}

print_warning() {
    echo -e "${COLOR_YELLOW}⚠ $1${COLOR_RESET}"
}

print_error() {
    echo -e "${COLOR_RED}✗ $1${COLOR_RESET}"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

report_vscode_missing() {
    print_error "VS Code CLI not found. Please ensure VS Code is installed and 'code' is in PATH."
}

check_vscode_installed() {
    if command_exists code; then
        print_success "VS Code CLI found"
        return 0
    else
        report_vscode_missing
        return 1
    fi
}

install_vscode_extensions() {
    print_header "Installing VS Code Extensions"
    
    for extension in "${REQUIRED_EXTENSIONS[@]}"; do
        echo -n "Installing: $extension... "
        if code --install-extension "$extension" --force >/dev/null 2>&1; then
            print_success "Installed"
        else
            print_warning "Already installed or failed"
        fi
    done
}

check_wsl_environment() {
    print_header "Checking WSL Environment"
    
    if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
        print_success "Running inside WSL: $WSL_DISTRO_NAME"
        
        # Check if VS Code Server is installed
        if [[ -d "$HOME/.vscode-server" ]]; then
            print_success "VS Code Server is installed"
        else
            print_warning "VS Code Server not found. Install it by opening this folder from VS Code on Windows."
        fi
    else
        print_warning "Not running in WSL. This script is optimized for WSL/Linux environments."
    fi
}

verify_vscode_config() {
    print_header "Verifying VS Code Configuration Files"
    
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local vscode_dir="$script_dir/../.vscode"
    
    if [[ -d "$vscode_dir" ]]; then
        if [[ -f "$vscode_dir/settings.json" ]]; then
            print_success "settings.json found"
        else
            print_warning "settings.json not found"
        fi
        
        if [[ -f "$vscode_dir/extensions.json" ]]; then
            print_success "extensions.json found"
        else
            print_warning "extensions.json not found"
        fi
        
        if [[ -f "$vscode_dir/tasks.json" ]]; then
            print_success "tasks.json found"
        else
            print_warning "tasks.json not found"
        fi
    else
        print_error ".vscode directory not found"
    fi
}

check_git_configuration() {
    print_header "Checking Git Configuration"
    
    if command_exists git; then
        print_success "Git is installed"
        
        local git_user
        local git_email
        git_user=$(git config user.name 2>/dev/null || echo "")
        git_email=$(git config user.email 2>/dev/null || echo "")
        
        if [[ -n "$git_user" && -n "$git_email" ]]; then
            print_success "Git user configured: $git_user <$git_email>"
        else
            print_warning "Git user not fully configured"
            echo "  Set user: git config --global user.name 'Your Name'"
            echo "  Set email: git config --global user.email 'your.email@example.com'"
        fi
    else
        print_warning "Git not found. Install Git for version control."
    fi
}

check_python_environment() {
    print_header "Checking Python Environment"
    
    if command_exists python3; then
        local python_version
        python_version=$(python3 --version 2>&1)
        print_success "Python found: $python_version"
        
        if command_exists pip3; then
            print_success "pip3 is available"
        else
            print_warning "pip3 not found"
        fi
    else
        print_warning "Python3 not found. Install Python for AI development."
    fi
}

check_node_environment() {
    print_header "Checking Node.js Environment"
    
    if command_exists node; then
        local node_version
        node_version=$(node --version 2>&1)
        print_success "Node.js found: $node_version"
        
        if command_exists npm; then
            local npm_version
            npm_version=$(npm --version 2>&1)
            print_success "npm found: $npm_version"
        else
            print_warning "npm not found"
        fi
    else
        print_warning "Node.js not found. Install Node.js for JavaScript development."
    fi
}

show_next_steps() {
    print_header "Setup Complete!"
    
    cat << 'EOF'
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
EOF
}

# ========== Main Execution ==========

main() {
    cat << 'EOF'
╔═══════════════════════════════════════════════════════════╗
║   VS Code AI Standards Bootstrap (Bash)                   ║
║   Fortune 50 Best Practices Setup                         ║
╚═══════════════════════════════════════════════════════════╝
EOF

    # Prerequisites check
    if ! check_vscode_installed; then
        print_error "Cannot continue without VS Code. Exiting."
        exit 1
    fi
    
    # Run setup steps
    verify_vscode_config
    install_vscode_extensions
    check_wsl_environment
    check_git_configuration
    check_python_environment
    check_node_environment
    show_next_steps
    
    echo ""
    print_success "Bootstrap completed successfully!"
}

# Run main function
main "$@"
