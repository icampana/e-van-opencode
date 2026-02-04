#!/usr/bin/env bash

# OpenCode Config Sync Script
# Syncs this repository to ~/.config/opencode/

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

CONFIG_DIR="$HOME/.config/opencode"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_header() {
    echo "================================================"
    echo "  OpenCode Config Sync"
    echo "================================================"
    echo ""
    log_info "Source: $REPO_DIR"
    log_info "Target: $CONFIG_DIR"
    echo ""
}

backup_existing() {
    if [ -f "$CONFIG_DIR/AGENTS.md" ] || [ -d "$CONFIG_DIR/agents" ]; then
        log_warning "Backing up existing configuration..."
        BACKUP_DIR="$CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        [ -f "$CONFIG_DIR/AGENTS.md" ] && cp "$CONFIG_DIR/AGENTS.md" "$BACKUP_DIR/"
        [ -d "$CONFIG_DIR/agents" ] && cp -r "$CONFIG_DIR/agents" "$BACKUP_DIR/"
        log_success "Backup created: $BACKUP_DIR"
    fi
}

sync_config() {
    log_info "Syncing configuration..."
    
    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"
    
    # Copy opencode.json
    if [ -f "$REPO_DIR/opencode.json" ]; then
        cp "$REPO_DIR/opencode.json" "$CONFIG_DIR/"
        log_success "Synced opencode.json"
    fi
    
    # Copy AGENTS.md
    if [ -f "$REPO_DIR/docs/AGENTS.md" ]; then
        cp "$REPO_DIR/docs/AGENTS.md" "$CONFIG_DIR/"
        log_success "Synced AGENTS.md"
    fi
    
    # Copy agents
    if [ -d "$REPO_DIR/.opencode/agents" ]; then
        mkdir -p "$CONFIG_DIR/agents"
        cp "$REPO_DIR/.opencode/agents"/*.md "$CONFIG_DIR/agents/"
        log_success "Synced agents"
    fi
}

show_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --no-backup    Skip backup of existing config"
    echo "  --symlink      Use symlinks instead of copying (stays in sync)"
    echo ""
}

main() {
    show_header
    
    SKIP_BACKUP=false
    USE_SYMLINKS=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --no-backup)
                SKIP_BACKUP=true
                shift
                ;;
            --symlink)
                USE_SYMLINKS=true
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    if [ "$USE_SYMLINKS" = true ]; then
        log_info "Using symlink mode..."
        [ "$SKIP_BACKUP" = false ] && backup_existing
        
        rm -f "$CONFIG_DIR/opencode.json"
        rm -f "$CONFIG_DIR/AGENTS.md"
        rm -rf "$CONFIG_DIR/agents"
        
        ln -s "$REPO_DIR/opencode.json" "$CONFIG_DIR/opencode.json"
        ln -s "$REPO_DIR/docs/AGENTS.md" "$CONFIG_DIR/AGENTS.md"
        ln -s "$REPO_DIR/.opencode/agents" "$CONFIG_DIR/agents"
        
        log_success "Symlinks created"
    else
        log_info "Using copy mode..."
        [ "$SKIP_BACKUP" = false ] && backup_existing
        sync_config
    fi
    
    echo ""
    log_success "Configuration synced successfully!"
    echo ""
    echo "To update in the future:"
    echo "  cd $REPO_DIR"
    echo "  git pull"
    echo "  ./sync-config.sh"
}

main "$@"
