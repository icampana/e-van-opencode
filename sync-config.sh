#!/usr/bin/env bash

# OpenCode Config Sync Script
# Syncs this repository to ~/.config/opencode/
# Safe for GSD: Preserves existing files in target directories.

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
    # Only backup if we haven't backed up recently (simple check could be added, but mostly harmless)
    if [ -f "$CONFIG_DIR/AGENTS.md" ] || [ -d "$CONFIG_DIR/agents" ]; then
        log_warning "Backing up existing configuration..."
        BACKUP_DIR="$CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        mkdir -p "$BACKUP_DIR"
        
        # Backup core files if they exist
        [ -f "$CONFIG_DIR/AGENTS.md" ] && cp "$CONFIG_DIR/AGENTS.md" "$BACKUP_DIR/"
        [ -f "$CONFIG_DIR/opencode.json" ] && cp "$CONFIG_DIR/opencode.json" "$BACKUP_DIR/"
        
        # Backup agents directory if it exists
        if [ -d "$CONFIG_DIR/agents" ]; then
            mkdir -p "$BACKUP_DIR/agents"
            cp -r "$CONFIG_DIR/agents/"* "$BACKUP_DIR/agents/"
        fi
        
        log_success "Backup created: $BACKUP_DIR"
    fi
}

# Copy Mode: Overwrites specific files, preserves others in directory
sync_copy() {
    log_info "Syncing configuration (Copy Mode)..."
    
    mkdir -p "$CONFIG_DIR/agents"
    
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
    
    # Copy agents individually
    if [ -d "$REPO_DIR/.opencode/agents" ]; then
        count=0
        for agent in "$REPO_DIR/.opencode/agents"/*.md; do
            [ -e "$agent" ] || continue
            cp "$agent" "$CONFIG_DIR/agents/"
            ((count++))
        done
        log_success "Synced $count agents"
    fi
}

# Symlink Mode: Links specific files, preserves others in directory
sync_symlink() {
    log_info "Syncing configuration (Symlink Mode)..."
    
    mkdir -p "$CONFIG_DIR/agents"
    
    # Link opencode.json
    ln -sf "$REPO_DIR/opencode.json" "$CONFIG_DIR/opencode.json"
    
    # Link AGENTS.md
    ln -sf "$REPO_DIR/docs/AGENTS.md" "$CONFIG_DIR/AGENTS.md"
    
    # Link agents individually
    if [ -d "$REPO_DIR/.opencode/agents" ]; then
        count=0
        for agent in "$REPO_DIR/.opencode/agents"/*.md; do
            [ -e "$agent" ] || continue
            filename=$(basename "$agent")
            ln -sf "$agent" "$CONFIG_DIR/agents/$filename"
            ((count++))
        done
        log_success "Linked $count agents"
    fi
    
    log_success "Symlinks created/updated"
}

show_usage() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --no-backup    Skip backup of existing config"
    echo "  --symlink      Use symlinks instead of copying (Recommended for dev)"
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
    
    # Always backup unless explicitly skipped
    [ "$SKIP_BACKUP" = false ] && backup_existing
    
    if [ "$USE_SYMLINKS" = true ]; then
        sync_symlink
    else
        sync_copy
    fi
    
    echo ""
    log_success "Configuration synced successfully!"
    echo -e "${YELLOW}Note: External files (like GSD agents) in target directory were preserved.${NC}"
    echo ""
}

main "$@"