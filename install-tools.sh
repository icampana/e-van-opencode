#!/usr/bin/env bash

# OpenCode Tools Installer
# Installs recommended CLI tools: bat, ripgrep (rg), sd, eza
# Supports: macOS (brew), Ubuntu/Debian (apt), Fedora/RHEL (dnf), Arch (pacman)

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

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS and package manager
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        PKG_MANAGER="brew"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                OS="debian"
                PKG_MANAGER="apt"
                ;;
            fedora|rhel|centos)
                OS="fedora"
                if command_exists dnf; then
                    PKG_MANAGER="dnf"
                else
                    PKG_MANAGER="yum"
                fi
                ;;
            arch|manjaro)
                OS="arch"
                PKG_MANAGER="pacman"
                ;;
            *)
                OS="unknown"
                PKG_MANAGER="unknown"
                ;;
        esac
    else
        OS="unknown"
        PKG_MANAGER="unknown"
    fi
}

# Check if package manager is available
check_package_manager() {
    if [ "$PKG_MANAGER" = "unknown" ]; then
        log_error "Could not detect package manager"
        log_info "Please install tools manually:"
        echo "  - bat: https://github.com/sharkdp/bat"
        echo "  - ripgrep: https://github.com/BurntSushi/ripgrep"
        echo "  - sd: https://github.com/chmln/sd"
        echo "  - eza: https://github.com/eza-community/eza"
        exit 1
    fi

    if ! command_exists "$PKG_MANAGER"; then
        log_error "$PKG_MANAGER is not available"
        if [ "$PKG_MANAGER" = "brew" ]; then
            log_info "Install Homebrew from: https://brew.sh"
        fi
        exit 1
    fi
}

# Install package based on OS
install_package() {
    local package=$1
    local pkg_name=$2  # Alternative package name if different

    if [ -z "$pkg_name" ]; then
        pkg_name=$package
    fi

    if command_exists "$package"; then
        log_warning "$package is already installed"
        return 0
    fi

    log_info "Installing $package..."

    case "$PKG_MANAGER" in
        brew)
            brew install "$pkg_name"
            ;;
        apt)
            sudo apt update -qq
            sudo apt install -y "$pkg_name"
            ;;
        dnf)
            sudo dnf install -y "$pkg_name"
            ;;
        yum)
            sudo yum install -y "$pkg_name"
            ;;
        pacman)
            sudo pacman -S --noconfirm "$pkg_name"
            ;;
        *)
            log_error "Unsupported package manager: $PKG_MANAGER"
            return 1
            ;;
    esac

    if command_exists "$package"; then
        log_success "$package installed successfully"
    else
        log_error "Failed to install $package"
        return 1
    fi
}

# Install bat
install_bat() {
    log_info "Installing bat..."
    
    case "$OS" in
        macos)
            install_package "bat" "bat"
            ;;
        debian)
            # On Ubuntu/Debian, the package might be called 'batcat'
            if ! command_exists bat && ! command_exists batcat; then
                install_package "bat" "bat"
            fi
            # Create symlink if batcat exists but bat doesn't
            if command_exists batcat && ! command_exists bat; then
                log_info "Creating symlink: bat -> batcat"
                sudo ln -sf "$(which batcat)" /usr/local/bin/bat
            fi
            ;;
        *)
            install_package "bat" "bat"
            ;;
    esac
}

# Install ripgrep
install_ripgrep() {
    log_info "Installing ripgrep..."
    install_package "rg" "ripgrep"
}

# Install sd
install_sd() {
    log_info "Installing sd..."
    
    case "$OS" in
        macos|debian|arch)
            install_package "sd" "sd"
            ;;
        fedora)
            # sd might not be in default repos, try cargo
            if ! install_package "sd" "sd"; then
                log_warning "sd not found in repos, attempting to install via cargo..."
                if command_exists cargo; then
                    cargo install sd
                else
                    log_error "cargo not found. Install Rust from https://rustup.rs/ and run: cargo install sd"
                    return 1
                fi
            fi
            ;;
        *)
            install_package "sd" "sd"
            ;;
    esac
}

# Install eza
install_eza() {
    log_info "Installing eza..."
    
    case "$OS" in
        macos)
            install_package "eza" "eza"
            ;;
        debian)
            # eza might not be in default Ubuntu repos
            if ! install_package "eza" "eza"; then
                log_warning "eza not found in default repos"
                log_info "For Ubuntu 22.04+, you can install via:"
                echo "  sudo mkdir -p /etc/apt/keyrings"
                echo "  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg"
                echo "  echo \"deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main\" | sudo tee /etc/apt/sources.list.d/gierens.list"
                echo "  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list"
                echo "  sudo apt update && sudo apt install eza"
                log_info "Or install via cargo: cargo install eza"
            fi
            ;;
        arch)
            install_package "eza" "eza"
            ;;
        fedora)
            # eza might need cargo installation
            if ! install_package "eza" "eza"; then
                log_warning "eza not found in repos, attempting to install via cargo..."
                if command_exists cargo; then
                    cargo install eza
                else
                    log_error "cargo not found. Install Rust from https://rustup.rs/ and run: cargo install eza"
                    return 1
                fi
            fi
            ;;
        *)
            install_package "eza" "eza"
            ;;
    esac
}

# Verify installations
verify_installations() {
    log_info "Verifying installations..."
    echo ""
    
    local all_installed=true
    
    for tool in bat rg sd eza; do
        if command_exists "$tool"; then
            local version=$($tool --version 2>/dev/null | head -n1 || echo "unknown")
            log_success "$tool: $version"
        else
            log_error "$tool: NOT FOUND"
            all_installed=false
        fi
    done
    
    echo ""
    if [ "$all_installed" = true ]; then
        log_success "All tools installed successfully!"
        return 0
    else
        log_warning "Some tools failed to install"
        return 1
    fi
}

# Main installation flow
main() {
    echo "================================================"
    echo "  OpenCode Recommended Tools Installer"
    echo "================================================"
    echo ""
    
    log_info "Detecting operating system..."
    detect_os
    log_success "Detected: $OS (using $PKG_MANAGER)"
    echo ""
    
    check_package_manager
    
    log_info "Installing required tools..."
    echo ""
    
    # Install each tool
    install_bat
    install_ripgrep
    install_sd
    install_eza
    
    echo ""
    echo "================================================"
    verify_installations
    echo "================================================"
    echo ""
    
    log_info "Tools are ready to use! See .github/agents/AGENTS.md for usage."
    echo ""
    echo "Quick examples:"
    echo "  bat -p file.txt          # View file with syntax highlighting"
    echo "  rg -C 5 'pattern'        # Search with 5 lines of context"
    echo "  sd 'old' 'new' file.txt  # Replace text in file"
    echo "  eza --tree -L 2          # List directory tree"
    echo ""
}

# Run main function
main "$@"
