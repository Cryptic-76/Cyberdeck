# Cyberdeck
Ein Cyperpunk Mod für das Windows-Terminal

 CYBERDECK INSTALLER — README.md
 
⚡ Überblick
Der Cyberdeck Installer richtet eine vollständig personalisierte, neon‑knallige PowerShell‑Umgebung ein — optimiert für PowerShell 7 und PowerShell 5.

Das Tool installiert automatisch:

- Starship Prompt
- PS7‑Profil (mit Unicode‑Glitch‑Header, animierten Gradient‑Bars, animierter Boot‑Sequence)
- PS5‑Profil (ASCII‑kompatibel, gleiche Features)
- starship-ps7.toml (voller Cyberpunk‑Look)
- starship-ps5.toml (PS5‑kompatibel, identisch aufgebaut)
- automatische Backups aller bestehenden Dateien

Damit wird jede PowerShell‑Session zu einem Cinematic Cyberpunk Terminal.

🚀 Features

🔥 PowerShell 7

- Glitch‑Header mit Unicode‑Symbolen
- Neon‑Gradient‑Bars (animiert)
- Boot‑Sequence (animiert)
- Öffentliche IP‑Anzeige
- Voller Starship‑Neon‑Prompt

🔥 PowerShell 5

- ASCII‑kompatible Gradient‑Bars (animiert)
- Boot‑Sequence (animiert)
- Glitch‑Header (ASCII‑Version)
- Öffentliche IP‑Anzeige
- PS5‑kompatible Starship‑Config

🔧 Installer‑Funktionen

- Automatische Starship‑Installation via
- Automatische Erstellung aller benötigten Ordner
- Automatische Backups vorhandener Profile & TOMLs
- Vollständige Neuinstallation in einem einzigen Durchlauf

1. Installation
git clone <REPO_URL>
cd cyberdeck-installer

2. Script ausführen

3. Terminal neu starten

Nach der Installation:
- PowerShell 7: clear schreiben
- PowerShell 5: cl schreiben

Und dein Cyberdeck fährt hoch.

Anpassung

Starship‑Config ändern

Bearbeite einfach:

- $HOME\\.config\starship-ps7.toml
- $HOME\\.config\starship-ps5.toml

Profile ändern

- PS7: $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
- PS5: $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

<img width="1240" height="662" alt="2026-02-01 22_33_29-Greenshot" src="https://github.com/user-attachments/assets/7964789d-7199-4072-a959-ac8775213d30" />



