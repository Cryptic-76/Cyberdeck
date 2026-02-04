<#
    Cyberdeck Installer Script v1.2
    Autor: Jörn Andre Peters
    Zweck: Installiert das Cyberdeck PowerShell Modul + nmap + Starship + Profilpatch
#>

Write-Host "=== CYBERDECK INSTALLER v1.2 ===" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# 1. Basispfade & Installer-Ordner
# ------------------------------------------------------------

$InstallerLocation = Split-Path -Parent $MyInvocation.MyCommand.Path
$UserHome          = $env:USERPROFILE
$ModuleRoot        = Join-Path $UserHome "Documents\PowerShell\Modules\Cyberdeck"
$StarshipConfigDir = Join-Path $UserHome ".config"
$StarshipConfigFile= Join-Path $StarshipConfigDir "starship-ps7.toml"
$ProfilePath       = $PROFILE

# ------------------------------------------------------------
# 2. Cyberdeck.zip automatisch finden
# ------------------------------------------------------------

Write-Host "[INFO] Suche Cyberdeck.zip..." -ForegroundColor Cyan

$ZipSource = Get-ChildItem -Path $InstallerLocation -Filter "Cyberdeck.zip" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

if (-not $ZipSource) {
    Write-Host "[FEHLER] Cyberdeck.zip wurde nicht gefunden." -ForegroundColor Red
    Write-Host "Lege Cyberdeck.zip in denselben Ordner wie diesen Installer." -ForegroundColor Yellow
    exit 1
}

Write-Host "[OK] Cyberdeck.zip gefunden unter:" -ForegroundColor Green
Write-Host "     $($ZipSource.FullName)"

# ------------------------------------------------------------
# 3. Modulordner vorbereiten & ZIP entpacken
# ------------------------------------------------------------

if (Test-Path $ModuleRoot) {
    Write-Host "[INFO] Entferne alte Cyberdeck-Version..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $ModuleRoot
}

Write-Host "[INFO] Erstelle Modulordner..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $ModuleRoot -Force | Out-Null

Write-Host "[INFO] Entpacke Cyberdeck.zip..." -ForegroundColor Cyan
Expand-Archive -Path $ZipSource.FullName -DestinationPath $ModuleRoot -Force

Write-Host "[OK] Modul erfolgreich installiert nach:" -ForegroundColor Green
Write-Host "     $ModuleRoot"

# ------------------------------------------------------------
# 4. nmap installieren (lokaler Installer nmap-7.98-setup.exe)
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Prüfe nmap Installation..." -ForegroundColor Cyan

$nmapCmd = Get-Command nmap -ErrorAction SilentlyContinue

if (-not $nmapCmd) {
    Write-Host "[INFO] nmap nicht gefunden. Suche lokalen Installer nmap-7.98-setup.exe..." -ForegroundColor Yellow

    $NmapInstaller = Get-ChildItem -Path $InstallerLocation -Filter "nmap-7.98-setup.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

    if (-not $NmapInstaller) {
        Write-Host "[FEHLER] nmap-7.98-setup.exe wurde nicht gefunden." -ForegroundColor Red
        Write-Host "Lege nmap-7.98-setup.exe in denselben Ordner wie diesen Installer." -ForegroundColor Yellow
        exit 1
    }

    Write-Host "[OK] nmap Installer gefunden unter:" -ForegroundColor Green
    Write-Host "     $($NmapInstaller.FullName)"

    Write-Host "[INFO] Starte nmap Setup (Silent, falls unterstützt)..." -ForegroundColor Cyan

    try {
        Start-Process -FilePath $NmapInstaller.FullName -ArgumentList "/S" -Wait
    }
    catch {
        Write-Host "[FEHLER] Konnte nmap-Installer nicht ausführen: $($_.Exception.Message)" -ForegroundColor Red
        exit 1
    }

    $nmapCmd = Get-Command nmap -ErrorAction SilentlyContinue
    if (-not $nmapCmd) {
        Write-Host "[FEHLER] nmap scheint nach der Installation nicht im PATH zu sein." -ForegroundColor Red
        Write-Host "Bitte prüfe die nmap-Installation manuell und starte den Installer erneut." -ForegroundColor Yellow
        exit 1
    }

    Write-Host "[OK] nmap erfolgreich installiert." -ForegroundColor Green
}
else {
    Write-Host "[OK] nmap bereits installiert." -ForegroundColor Green
}

# ------------------------------------------------------------
# 5. Starship installieren (über winget)
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Prüfe Starship Installation..." -ForegroundColor Cyan

$StarshipInstalled = Get-Command starship -ErrorAction SilentlyContinue

if (-not $StarshipInstalled) {

    Write-Host "[INFO] Starship nicht gefunden. Installiere über winget..." -ForegroundColor Yellow

    $Winget = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $Winget) {
        Write-Host "[FEHLER] winget ist nicht verfügbar. Starship kann nicht automatisch installiert werden." -ForegroundColor Red
        Write-Host "Bitte installiere Starship manuell von https://starship.rs" -ForegroundColor Yellow
    }
    else {
        try {
            winget install --id Starship.Starship -e --source winget --accept-package-agreements --accept-source-agreements
        }
        catch {
            Write-Host "[FEHLER] winget konnte Starship nicht installieren." -ForegroundColor Red
            Write-Host "Bitte installiere Starship manuell von https://starship.rs" -ForegroundColor Yellow
        }
    }

    $StarshipInstalled = Get-Command starship -ErrorAction SilentlyContinue
    if ($StarshipInstalled) {
        Write-Host "[OK] Starship erfolgreich installiert." -ForegroundColor Green
    }
    else {
        Write-Host "[WARNUNG] Starship ist weiterhin nicht installiert." -ForegroundColor Yellow
    }
}
else {
    Write-Host "[OK] Starship bereits installiert." -ForegroundColor Green
}

# ------------------------------------------------------------
# 6. Starship Config erzeugen (Cyberpunk Theme)
# ------------------------------------------------------------

if (-not (Test-Path $StarshipConfigDir)) {
    New-Item -ItemType Directory -Path $StarshipConfigDir | Out-Null
}

Write-Host "[INFO] Erstelle Cyberpunk Starship Theme..." -ForegroundColor Cyan

@"
# ───────────────────────────────────────────────────────────────
#   CYBERPUNK STARSHIP THEME (PowerShell 7)
#   Ohne Network/VPN Module
# ───────────────────────────────────────────────────────────────

format = \"\"\"
[](#ff00ff)\$os\$username[](bg:#00eaff fg:#ff00ff)\$directory[](bg:#1a1a1a fg:#00eaff)\$git_branch\$git_status[](bg:#ff0099 fg:#1a1a1a)\$time[](fg:#ff0099)\$character
\"\"\"

[os]
format = "[ ](bg:#ff00ff fg:#000000)"
disabled = false

[username]
style_user = "bg:#ff00ff fg:#000000"
style_root = "bg:#ff00ff fg:#000000"
format = "[ \$user ](\$style)"
disabled = false

[directory]
style = "bg:#00eaff fg:#000000"
format = "[ \$path ](\$style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
style = "bg:#1a1a1a fg:#00eaff"
format = "[  \$branch ](\$style)"

[git_status]
style = "bg:#1a1a1a fg:#faff00"
format = "[ \$all_status ](\$style)"

[time]
disabled = false
time_format = "%H:%M:%S"
style = "bg:#ff0099 fg:#000000"
format = "[  \$time ](\$style)"

[character]
success_symbol = "[❯](fg:#ff00ff)"
error_symbol   = "[❯](fg:#ff0033)"
vicmd_symbol   = "[❮](fg:#00eaff)"
"@ | Set-Content $StarshipConfigFile

Write-Host "[OK] Cyberpunk Starship Theme installiert." -ForegroundColor Green

# ------------------------------------------------------------
# 7. PowerShell Profil patchen
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Patche PowerShell Profil..." -ForegroundColor Cyan

if (-not (Test-Path $ProfilePath)) {
    Write-Host "[INFO] Profil existiert nicht. Erstelle Datei..." -ForegroundColor Yellow
    New-Item -ItemType File -Path $ProfilePath | Out-Null
}

$ProfileContent = @"
# ============================
# Cyberdeck PowerShell Profile
# ============================

Import-Module Cyberdeck

Show-GlitchHeader
Show-GradientBars
Show-BootSequence
Show-GlitchIP

Set-Alias clear Clear-Glitch
Set-Alias nmapp Show-CyberdeckNmapPanel
Set-Alias portm Start-PortMonitor

\$env:STARSHIP_CONFIG = "\$HOME\.config\starship-ps7.toml"
Invoke-Expression (&starship init powershell)
"@

Set-Content -Path $ProfilePath -Value $ProfileContent

Write-Host "[OK] Profil erfolgreich gepatcht." -ForegroundColor Green

# ------------------------------------------------------------
# 8. Abschluss
# ------------------------------------------------------------

Write-Host ""
Write-Host "=== INSTALLATION ABGESCHLOSSEN ===" -ForegroundColor Green
Write-Host "Starte PowerShell neu, um das Cyberdeck zu aktivieren." -ForegroundColor Cyan
Write-Host ""
