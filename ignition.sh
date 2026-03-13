#!/usr/bin/env bash

# ============================================================
# 🔨 GENESIS-OS IGNITION — Bootstrap Script
# Obiectiv: Sincronizare hardware și deploy automat.
# ============================================================

# Culori pentru output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Mesaje
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# ── VERIFICĂRI INIȚIALE ───────────────────────────────────────

# Verifică dacă rulează pe NixOS
if [[ ! "$(grep -i nixos </etc/os-release)" ]]; then
    error "Acest script rulează doar pe NixOS!"
fi

# Verifică dacă Git este instalat
if ! command -v git &> /dev/null; then
    info "Git nu este instalat. Îl instalăm temporar..."
    nix-shell -p git --run "git --version" || error "Eșec la activarea Git."
fi

# ── CONFIGURAȚIE TARGET ───────────────────────────────────────

HOST="asgard-laptop"
REPO_DIR="$HOME/genesis-os"

info "Pornim Ignition pentru Host: ${HOST}..."

# ── SINCRONIZARE HARDWARE ─────────────────────────────────────

HW_CONFIG="./hosts/${HOST}/hardware.nix"

if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
    info "Sincronizăm configurația hardware de pe mașina locală..."
    cp /etc/nixos/hardware-configuration.nix "$HW_CONFIG"
    success "Hardware configuration sincronizat."
else
    warn "Nu am găsit /etc/nixos/hardware-configuration.nix. Generăm unul nou..."
    nixos-generate-config --show-hardware-config > "$HW_CONFIG"
fi

# ── PREGĂTIRE REPO (GIT) ──────────────────────────────────────

# Nix Flakes cer ca fișierele să fie înregistrate în Git pentru a fi văzute
info "Înregistrăm fișierele noi în Git..."
git add .

# ── EXECUTARE REBUILD ─────────────────────────────────────────

info "Lansăm Marea Fuziune (nixos-rebuild)..."
sudo nixos-rebuild switch --flake ".#${HOST}"

if [ $? -eq 0 ]; then
    success "GenesisOS a fost desfășurat cu succes pe ${HOST}!"
    echo -e "${GREEN}Bine ai venit în Asgard, Arhitectule.${NC}"
else
    error "Rebuild-ul a eșuat. Verifică erorile de mai sus."
fi
