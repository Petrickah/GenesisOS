# 🛡️ AGENTS.md — Protocolul de Colaborare GenesisOS

> **Versiune:** 2.0 | **Data:** 2026-03-13 | **Status:** Activ
> **Target:** NixOS Bare-Metal (Laptop NVIDIA)

---

## 🤖 CONTEXTUL OPERAȚIONAL

Acest repo urmează **The Nix Way**: o structură modulară, declarativă și curată. Orice agent AI (Gemini, Antigravity, Claude) trebuie să respecte această ierarhie.

### 🗺️ STRUCTURA MODULARĂ
```
GenesisOS/
├── flake.nix              # Management inputs/outputs (Nixpkgs Unstable)
├── hosts/
│   └── asgard-laptop/     # Configurație specifică hardware (Kernel Fix, NVIDIA)
│       ├── default.nix
│       └── hardware.nix   # Generat local pe host
├── modules/
│   ├── core/              # SSH, Boot, Users, Nix Settings
│   └── desktop/           # Hyprland, Waybar, Fonts (Inspired by Omarchy)
└── users/
    └── tiberiu/           # Home-manager (Dotfiles, Apps)
```

---

## 📜 REGULI DE AUR (BEAST'S RIGOUR)

1. **Puritate:** Nu folosi framework-uri care ascund logica (ex: nu importa module flake întregi fără a extrage părțile necesare).
2. **NVIDIA Safety:** Toate variabilele de mediu NVIDIA se injectează prin Home Manager în `modules/desktop/`.
3. **Kernel Artificiu:** Folosește funcția `myKernelPackages` din `configuration.nix` pentru a asigura compatibilitatea ZFS/NVIDIA.
4. **Non-Destructiv:** Rulează `dry-build` înainte de a propune un `switch`.

---

## ⚡ COMENZI CANONICE

```bash
# Aplicare remote (de pe alt PC)
nixos-rebuild switch --flake '.#asgard-laptop' --target-host tiberiu@ip --use-remote-sudo

# Curățare Store
nix-collect-garbage -d
```

---

## 📡 SYNC PROTOCOL (VAULT <-> REPO)

- Strategia High-Level se găsește în **[[GEN-0170_GenesisOS-Master-Protocol]]**.
- Modificările de cod în repo trebuie să reflecte statusul din Protocol.
- Orice bug major se înregistrează în Vault, nu doar în commit messages.

---
> *"Construiește-ți propria temelie. Nu locui în casa altuia."*
