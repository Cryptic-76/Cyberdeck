# ⚡ Cyberdeck PowerShell Environment v1.2
Ein vollständig modulares, cyberpunk‑inspiriertes PowerShell‑Framework mit animierter Startsequenz, Port‑Monitoring, Nmap‑Control‑Panel, Fingerprint‑Datenbank und einem maßgeschneiderten Starship‑Prompt.

Version **1.2** enthält:
- automatischen Modul‑Installer
- integrierten **nmap‑Installer (lokal, offline)**
- Cyberpunk‑Starship‑Theme
- automatisches Profil‑Patching
- vollständige Cyberdeck‑Startsequenz

---

## 🚀 Features

### 🔥 Cyberdeck Startsequenz
Beim Start der PowerShell:
- Glitch‑Header  
- Neon‑Gradient‑Bars  
- Boot‑Sequence  
- Öffentliche IP‑Anzeige  

### 🛰 Port‑Monitor (Live)
- Echtzeit‑Überwachung aller TCP‑Ports  
- Threat‑Level‑Analyse  
- Anomaly‑Detection  
- Fingerprint‑Persistenz (Signatur, Pfad, Zertifikat)  
- Logging in `$HOME\Cyberdeck-PortMonitor`  

### 🧠 Fingerprint‑Datenbank
- JSON‑basierte Prozess‑Fingerprint‑DB  
- Automatische Signatur‑Analyse  
- Persistente Prozess‑Historie  

### 🕶 Nmap Control Panel
- Vollständiges Nmap‑Frontend in PowerShell  
- Presets (Quick, Full, Aggressive, Stealth, Vuln, Recon)  
- Live‑Progress‑Animation  
- Automatische XML → HTML‑Report‑Generierung  

### 🎨 Cyberpunk Starship Prompt
- PowerShell‑7 Theme  
- Neon‑Segment‑Design  
- Git‑Status, Zeit, Directory, OS‑Badge  

---

## 📦 Installation

### 1. ZIP herunterladen
Lade die Release‑ZIP herunter und entpacke sie **in einen beliebigen Ordner**.

### 2. Stelle sicher, dass folgende Dateien im selben Ordner liegen:
- `Cyberdeck.zip`  
- `nmap-7.98-setup.exe`  
- `Install-Cyberdeck.ps1`  

### 3. Installer ausführen
Rechtsklick → **Mit PowerShell ausführen**

Der Installer:
- findet `Cyberdeck.zip` automatisch  
- findet `nmap-7.98-setup.exe` automatisch  
- installiert das Modul nach  
  `C:\Users\<USER>\Documents\PowerShell\Modules\Cyberdeck\`
- installiert nmap lokal  
- erzeugt das Starship‑Theme  
- patched dein PowerShell‑Profil  
- aktiviert die Startsequenz  

### 4. PowerShell neu starten

---

## 🛠 Voraussetzungen

- Windows 10/11  
- PowerShell 7 empfohlen  
- Administratorrechte für nmap‑Installation  
- Optional: Starship (wird erkannt, aber nicht automatisch installiert)

---

## 🧩 Aliases

| Alias | Funktion |
|-------|----------|
| `clear` | Clear‑Glitch (Cyberdeck‑Clear) |
| `nmapp` | Nmap‑Control‑Panel |
| `portm` | Port‑Monitor starten |

---

## 📁 Ordnerstruktur nach Installation
