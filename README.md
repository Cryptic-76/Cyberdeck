⚡ Cyberdeck PowerShell Environment v1.3

Ein vollständig modulares, cyberpunk‑inspiriertes PowerShell‑Framework mit animierter Startsequenz, Port‑Monitoring, Nmap‑Control‑Panel, Fingerprint‑Datenbank, Arsenal‑Forensik‑Subsystem, Malware‑Analyse‑Presets und einem maßgeschneiderten Starship‑Prompt.

<img width="1228" height="308" alt="2026-02-04 23_15_35-Greenshot" src="https://github.com/user-attachments/assets/583408af-7aeb-40f0-827b-8f7d7e200abb" />


🚀 Neu in Version 1.3

🔥 Arsenal‑Subsystem (PowerShellArsenal Integration)

- automatische Installation (falls lokal vorhanden)
- Vollständiges Arsenal‑Control‑Panel
- Arsenal‑Preset‑Menü mit automatisierten Workflows:
- Malware Deep Scan
- Process Deep Recon
- Shellcode Deep Analysis
- DLL Dependency Tree
- Packed/Obfuscated Detection
- Network Artifact Scan
- Quick IOC Extractor
- PE‑Analyse
- Memory‑Dump
- Strings‑Analyse
- Hash‑Analyse
- Syscall‑Mapping

<img width="1225" height="616" alt="2026-02-05 07_50_40-PowerShell Cyberpunk Terminal Script" src="https://github.com/user-attachments/assets/63e5160e-ad46-4a5c-a1e6-fb00ff30f55a" />


🔥 Verbesserter Installer v1.3
- Erkennt vorhandenes Arsenal
- Installiert Arsenal nur, wenn es fehlt
- Kopiert lokale Arsenal‑Version automatisch
- Vollständige Cyberdeck‑Modulinstallation
- Nmap‑Offline‑Installer
- Starship‑Auto‑Installer
- Profil‑Patch mit Alias‑Setup

🔥 Verbesserte Modulstruktur
- Public/Private‑Trennung
- Saubere Exports
- Fehlerfreie Startsequenz

🎬 Cyberdeck Startsequenz
Beim Start der PowerShell:
- Glitch‑Header
- Neon‑Gradient‑Bars
- Boot‑Sequence
- Öffentliche IP‑Anzeige
- Cyberpunk‑Starship‑Prompt

🛰 Port‑Monitor (Live)
- Echtzeit‑Überwachung aller TCP‑Ports
- Threat‑Level‑Analyse
- Anomaly‑Detection
- Fingerprint‑Persistenz (Signatur, Pfad, Zertifikat)
- Logging in:

$HOME\Cyberdeck-PortMonitor

<img width="1219" height="511" alt="2026-02-04 23_18_48-Cyberdeck_README md at main · Cryptic-76_Cyberdeck — Mozilla Firefox" src="https://github.com/user-attachments/assets/c23fb081-1c43-41f8-83bc-5ae6db09bfe2" />


🧠 Fingerprint‑Datenbank
- JSON‑basierte Prozess‑Fingerprint‑DB
- Automatische Signatur‑Analyse
- Persistente Prozess‑Historie
- Anomaly‑Scoring

🕶 Nmap Control Panel
- Vollständiges Nmap‑Frontend in PowerShell
- Presets:
- Quick Scan
- Full Scan
- Aggressive Scan
- Stealth Scan
- Vuln Scan
- Recon Scan
- Live‑Progress‑Animation
- Automatische XML → HTML‑Report‑Generierung

<img width="1235" height="405" alt="2026-02-05 00_12_05-Editing Cyberdeck_README md at main · Cryptic-76_Cyberdeck — Mozilla Firefox" src="https://github.com/user-attachments/assets/0a70e367-fa0f-4bc5-bf83-9b8d92103b6d" />


🧨 Arsenal‑Subsystem (Forensik & Malware‑Analyse)

🔥 Arsenal‑Control‑Panel
- Alle Arsenal‑Funktionen
- Automatische Parameter‑Abfrage
- Vollständige Integration

🔥 Arsenal‑Preset‑Menü (automatisierte Workflows)
- Malware Deep Scan
- Process Deep Recon
- Shellcode Deep Analysis
- DLL Dependency Tree
- Packed/Obfuscated Detection
- Network Artifact Scan
- Quick IOC Extractor
- PE‑Analyse
- Memory‑Dump
- Strings‑Analyse
- Hash‑Analyse
- Suspicious Sections Scan
- Syscall‑Mapping

🎨 Cyberpunk Starship Prompt
- PowerShell‑7 Theme
- Neon‑Segment‑Design
- Git‑Status
- Zeit
- Directory
- OS‑Badge
- Custom Cyberdeck‑Layout

📦 Installation
1. Dateien vorbereiten
Lege folgende Dateien in denselben Ordner:

Cyberdeck.zip
nmap-7.98-setup.exe
Cyberdeck_Installer_v1.3.ps1
(optional) C:\ProgramData\PowerShellArsenal\

2. Installer ausführen
Rechtsklick → Mit PowerShell ausführen
Der Installer:
- findet Cyberdeck.zip automatisch
- findet nmap‑Installer automatisch
- installiert Cyberdeck nach:

C:\Users\<USER>\Documents\PowerShell\Modules\Cyberdeck\

- installiert nmap offline
- installiert Starship (falls nicht vorhanden)
- installiert Arsenal (falls nicht vorhanden)
- patched dein PowerShell‑Profil
- aktiviert die Startsequenz
3. PowerShell neu starten

🛠 Voraussetzungen
- Windows 10/11
- PowerShell 7 empfohlen
- Administratorrechte für nmap
- Optional: Starship (wird automatisch installiert)
- Optional: PowerShellArsenal (wird automatisch installiert, falls lokal vorhanden)

🧩 Aliases
|  |  | 
| clear |  | 
| nmapp |  | 
| portm |  | 
| arsenal |  | 



📁 Ordnerstruktur nach Installation
Documents\PowerShell\Modules\Cyberdeck\
-    Public\
-    Private\
-    Cyberdeck.psd1
-    Cyberdeck.psm1

- $HOME\.config\
-    starship-ps7.toml
- Cyberdeck-PortMonitor\


🧨 Deinstallation
- Lösche den Ordner:
Documents\PowerShell\Modules\Cyberdeck
- Entferne die Cyberdeck‑Zeilen aus deinem $PROFILE
- Optional: lösche
.config\starship-ps7.toml



📜 Lizenz
Frei nutzbar und modifizierbar.

💬 Kontakt
Erstellt von Jörn Andre Peters
Cyberpunk Terminal Engineering
