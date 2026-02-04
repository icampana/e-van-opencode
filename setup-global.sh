#!/usr/bin/env bash

# OpenCode Global Configuration Setup
# Sets up this repository as a global OpenCode configuration
# that can be referenced by all your projects

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Default installation directory
DEFAULT_GLOBAL_DIR="$HOME/.opencode"
GLOBAL_DIR="${OPENCODE_GLOBAL_DIR:-$DEFAULT_GLOBAL_DIR}"

# Show header
show_header() {
    echo "================================================"
    echo "  OpenCode Global Configuration Setup"
    echo "================================================"
    echo ""
}

# Check if git is available
check_git() {
    if ! command -v git >/dev/null 2>&1; then
        log_error "git is not installed. Please install git first."
        exit 1
    fi
}

# Setup global configuration
setup_global_config() {
    log_info "Setting up global OpenCode configuration..."
    
    # Create directory if it doesn't exist
    if [ ! -d "$GLOBAL_DIR" ]; then
        log_info "Creating global config directory: $GLOBAL_DIR"
        mkdir -p "$GLOBAL_DIR"
    fi
    
    # If we're already in the e-van-opencode repo, copy from here
    if [ -d ".github/agents" ]; then
        log_info "Copying configuration from current repository..."
        cp -r .github "$GLOBAL_DIR/"
        cp -r README.md GETTING_STARTED.md EXAMPLES.md CONTRIBUTING.md "$GLOBAL_DIR/" 2>/dev/null || true
        log_success "Configuration copied to $GLOBAL_DIR"
    else
        # Clone the repository
        if [ -d "$GLOBAL_DIR/.git" ]; then
            log_info "Global config already exists, updating..."
            cd "$GLOBAL_DIR"
            git pull origin main
        else
            log_info "Cloning e-van-opencode repository to $GLOBAL_DIR..."
            rm -rf "$GLOBAL_DIR"
            git clone https://github.com/icampana/e-van-opencode.git "$GLOBAL_DIR"
        fi
        log_success "Global configuration installed to $GLOBAL_DIR"
    fi
}

# Create shell environment setup
setup_shell_env() {
    log_info "Setting up shell environment..."
    
    # Detect shell
    local shell_rc=""
    if [ -n "$BASH_VERSION" ]; then
        shell_rc="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        shell_rc="$HOME/.zshrc"
    else
        log_warning "Could not detect shell type. Skipping shell configuration."
        return
    fi
    
    # Check if already configured
    if grep -q "OPENCODE_GLOBAL_DIR" "$shell_rc" 2>/dev/null; then
        log_warning "Shell environment already configured"
        return
    fi
    
    log_info "Adding OPENCODE_GLOBAL_DIR to $shell_rc"
    
    cat >> "$shell_rc" << EOF

# OpenCode Global Configuration
export OPENCODE_GLOBAL_DIR="$GLOBAL_DIR"

# Optional: Add opencode alias for quick access
alias opencode-docs="cat \$OPENCODE_GLOBAL_DIR/.github/agents/INDEX.md"
alias opencode-update="cd \$OPENCODE_GLOBAL_DIR && git pull"
EOF
    
    log_success "Shell environment configured"
    log_info "Run 'source $shell_rc' or restart your terminal to apply changes"
}

# Create symlink helper script
create_symlink_helper() {
    log_info "Creating project setup helper script..."
    
    cat > "$GLOBAL_DIR/setup-project.sh" << 'EOF'
#!/usr/bin/env bash

# OpenCode Project Setup Helper
# Links or copies global config to a project

set -e

GLOBAL_DIR="${OPENCODE_GLOBAL_DIR:-$HOME/.opencode}"

if [ ! -d "$GLOBAL_DIR" ]; then
    echo "Error: Global config not found at $GLOBAL_DIR"
    echo "Run setup-global.sh first"
    exit 1
fi

PROJECT_DIR="${1:-.}"

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory not found: $PROJECT_DIR"
    exit 1
fi

cd "$PROJECT_DIR"

echo "Setting up OpenCode configuration for project: $(basename "$(pwd)")"
echo ""

# Option 1: Symlink (recommended for staying in sync with global config)
echo "Choose setup method:"
echo "1) Symlink (recommended - stays in sync with global config)"
echo "2) Copy (allows per-project customization)"
echo "3) Reference only (just use global config, no local files)"
read -p "Enter choice [1-3]: " choice

case "$choice" in
    1)
        echo "Creating symlink to global config..."
        if [ -e ".github/agents" ]; then
            echo "Warning: .github/agents already exists"
            read -p "Replace it? [y/N]: " replace
            if [ "$replace" = "y" ] || [ "$replace" = "Y" ]; then
                rm -rf .github/agents
            else
                echo "Skipping..."
                exit 0
            fi
        fi
        mkdir -p .github
        ln -s "$GLOBAL_DIR/.github/agents" .github/agents
        echo "✓ Symlink created: .github/agents -> $GLOBAL_DIR/.github/agents"
        echo ""
        echo "Note: Changes to global config will automatically apply to this project"
        ;;
    2)
        echo "Copying global config to project..."
        mkdir -p .github
        cp -r "$GLOBAL_DIR/.github/agents" .github/
        echo "✓ Configuration copied to .github/agents"
        echo ""
        echo "Note: You can now customize this config for your project"
        echo "To update from global config, run this script again"
        ;;
    3)
        echo "Using global config without local files"
        echo "✓ Global config at: $GLOBAL_DIR/.github/agents"
        echo ""
        echo "Note: Your project will reference the global config"
        echo "Set OPENCODE_GLOBAL_DIR environment variable to use it"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "Setup complete! You can now:"
echo "  - View config: cat .github/agents/AGENTS.md"
echo "  - Browse docs: cat $GLOBAL_DIR/.github/agents/INDEX.md"
echo "  - See examples: cat $GLOBAL_DIR/EXAMPLES.md"
EOF
    
    chmod +x "$GLOBAL_DIR/setup-project.sh"
    log_success "Project setup helper created: $GLOBAL_DIR/setup-project.sh"
}

# Show usage instructions
show_usage() {
    echo ""
    echo "================================================"
    log_success "Global configuration setup complete!"
    echo "================================================"
    echo ""
    echo "📁 Global config location: $GLOBAL_DIR"
    echo ""
    echo "🚀 Next steps:"
    echo ""
    echo "1. Reload your shell configuration:"
    echo "   source ~/.bashrc  # or ~/.zshrc"
    echo ""
    echo "2. Set up a project to use this config:"
    echo "   cd /path/to/your/project"
    echo "   $GLOBAL_DIR/setup-project.sh"
    echo ""
    echo "3. Browse the documentation:"
    echo "   cat $GLOBAL_DIR/.github/agents/INDEX.md"
    echo "   cat $GLOBAL_DIR/GETTING_STARTED.md"
    echo ""
    echo "📚 Quick commands:"
    echo "   opencode-docs    # View the index"
    echo "   opencode-update  # Update global config"
    echo ""
    echo "💡 Per-project customization:"
    echo "   You can create .github/agents/AGENTS_PROJECT.md in any project"
    echo "   to extend or override the global configuration."
    echo ""
}

# Main setup flow
main() {
    show_header
    
    log_info "This will set up OpenCode configuration globally"
    log_info "Installation directory: $GLOBAL_DIR"
    echo ""
    
    read -p "Continue? [Y/n]: " confirm
    if [ "$confirm" = "n" ] || [ "$confirm" = "N" ]; then
        echo "Setup cancelled"
        exit 0
    fi
    
    echo ""
    check_git
    setup_global_config
    setup_shell_env
    create_symlink_helper
    show_usage
}

# Run main function
main "$@"
