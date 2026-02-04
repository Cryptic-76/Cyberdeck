# ⚡ Cyberdeck PowerShell Environment v1.2

<img width="1228" height="308" alt="2026-02-04 23_15_35-Greenshot" src="https://github.com/user-attachments/assets/1f6e13a1-150e-4003-b55c-08939a53a7b2" />


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

<img width="1219" height="511" alt="2026-02-04 23_18_48-Cyberdeck_README md at main · Cryptic-76_Cyberdeck — Mozilla Firefox" src="https://github.com/user-attachments/assets/11cf9579-6477-4398-8e23-590dd0ea6968" />


### 🧠 Fingerprint‑Datenbank
- JSON‑basierte Prozess‑Fingerprint‑DB  
- Automatische Signatur‑Analyse  
- Persistente Prozess‑Historie  

### 🕶 Nmap Control Panel
- Vollständiges Nmap‑Frontend in PowerShell  
- Presets (Quick, Full, Aggressive, Stealth, Vuln, Recon)  
- Live‑Progress‑Animation  
- Automatische XML → HTML‑Report‑Generierung

<img width="1232" height="417" alt="2026-02-04 23_13_11-Cryptic-76_Cyberdeck_ Ein Cyperpunk Mod für das Windows-Terminal — Mozilla Firef" src="https://github.com/user-attachments/assets/b8219325-064b-4741-b02e-87b25c817015" />


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
- `Cyberdeck_Installer_v1.2.ps1`  

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


---

## 🧨 Deinstallation (manuell)

1. Lösche den Ordner:  
   `Documents\PowerShell\Modules\Cyberdeck`
2. Entferne die Cyberdeck‑Zeilen aus deinem `$PROFILE`
3. Optional: lösche  
   `.config\starship-ps7.toml`

---

## 📜 Lizenz
Dieses Projekt ist frei nutzbar und modifizierbar.

---

## 💬 Kontakt
Erstellt von **Jörn Andre Peters** – Cyberpunk Terminal Engineering  
