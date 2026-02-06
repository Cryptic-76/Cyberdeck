<#
    Cyberdeck Installer Script v2.0
    Autor: Jörn Andre Peters
    Zweck: Installiert Cyberdeck + Starship + nmap + Profile aus einer einzigen ZIP
#>

Write-Host "=== CYBERDECK INSTALLER v2.0 ===" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# 1. Basispfade
# ------------------------------------------------------------

$InstallerLocation = Split-Path -Parent $MyInvocation.MyCommand.Path
$UserHome          = $env:USERPROFILE
$ModulesRoot       = Join-Path $UserHome "Documents\PowerShell\Modules"
$ConfigDir         = Join-Path $UserHome ".config"
$StarshipConfig    = Join-Path $ConfigDir "starship-ps7.toml"
$ProfilePath       = Join-Path $UserHome "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

$TempExtract       = Join-Path $env:TEMP "Cyberdeck_Install_Extract"
$ZipName           = "Cyberdeck_Package.zip"

# ------------------------------------------------------------
# 2. ZIP automatisch finden
# ------------------------------------------------------------

Write-Host "[INFO] Suche $ZipName..." -ForegroundColor Cyan

$ZipSource = $null

# 1. Installer-Ordner
$ZipSource = Get-ChildItem -Path $InstallerLocation -Filter $ZipName -ErrorAction SilentlyContinue | Select-Object -First 1

# 2. Benutzerprofil
if (-not $ZipSource) {
    Write-Host "[INFO] Suche im Benutzerprofil..." -ForegroundColor Yellow
    $ZipSource = Get-ChildItem -Path $UserHome -Filter $ZipName -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
}

# 3. Gesamtes System
if (-not $ZipSource) {
    Write-Host "[INFO] Suche auf C:\ ..." -ForegroundColor Yellow
    $ZipSource = Get-ChildItem -Path "C:\" -Filter $ZipName -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
}

if (-not $ZipSource) {
    Write-Host "[FEHLER] $ZipName wurde nicht gefunden." -ForegroundColor Red
    exit 1
}

Write-Host "[OK] ZIP gefunden unter: $($ZipSource.FullName)" -ForegroundColor Green

# ------------------------------------------------------------
# 3. Temp-Ordner vorbereiten & ZIP entpacken
# ------------------------------------------------------------

if (Test-Path $TempExtract) {
    Remove-Item -Recurse -Force $TempExtract -ErrorAction SilentlyContinue
}

New-Item -ItemType Directory -Path $TempExtract -Force | Out-Null

try {
    Expand-Archive -Path $ZipSource.FullName -DestinationPath $TempExtract -Force
    Write-Host "[OK] Paket entpackt." -ForegroundColor Green
}
catch {
    Write-Host "[FEHLER] Konnte Paket nicht entpacken: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# ------------------------------------------------------------
# 4. Starship installieren
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Prüfe Starship Installation..." -ForegroundColor Cyan

$StarshipInstalled = Get-Command starship -ErrorAction SilentlyContinue

if (-not $StarshipInstalled) {
    Write-Host "[INFO] Starship nicht gefunden. Versuche Installation..." -ForegroundColor Yellow

    $Winget = Get-Command winget -ErrorAction SilentlyContinue
    if ($Winget) {
        try {
            winget install --id Starship.Starship -e --source winget --accept-package-agreements --accept-source-agreements
        }
        catch {
            Write-Host "[WARNUNG] Starship konnte nicht installiert werden." -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "[WARNUNG] winget nicht verfügbar. Starship muss ggf. manuell installiert werden." -ForegroundColor Yellow
    }
}
else {
    Write-Host "[OK] Starship bereits installiert." -ForegroundColor Green
}

# ------------------------------------------------------------
# 5. Starship-Config deployen
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Deploye Starship-Konfiguration..." -ForegroundColor Cyan

$StarshipSource = Join-Path $TempExtract "starship-ps7.toml"

if (Test-Path $StarshipSource) {
    if (-not (Test-Path $ConfigDir)) {
        New-Item -ItemType Directory -Path $ConfigDir -Force | Out-Null
    }

    Copy-Item -Path $StarshipSource -Destination $StarshipConfig -Force
    Write-Host "[OK] Starship-Config installiert." -ForegroundColor Green
}
else {
    Write-Host "[WARNUNG] starship-ps7.toml nicht im Paket gefunden." -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 6. Cyberdeck-Modul deployen
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Installiere Cyberdeck-Modul..." -ForegroundColor Cyan

$CyberdeckSource = Join-Path $TempExtract "Cyberdeck"
$CyberdeckTarget = Join-Path $ModulesRoot "Cyberdeck"

if (-not (Test-Path $CyberdeckSource)) {
    Write-Host "[FEHLER] Cyberdeck-Ordner fehlt im Paket." -ForegroundColor Red
    exit 1
}

if (Test-Path $CyberdeckTarget) {
    Remove-Item -Recurse -Force $CyberdeckTarget -ErrorAction SilentlyContinue
}

if (-not (Test-Path $ModulesRoot)) {
    New-Item -ItemType Directory -Path $ModulesRoot -Force | Out-Null
}

Copy-Item -Path $CyberdeckSource -Destination $CyberdeckTarget -Recurse -Force
Write-Host "[OK] Cyberdeck installiert." -ForegroundColor Green

# ------------------------------------------------------------
# 7. PowerShellArsenal-Modul deployen (optional)
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Prüfe PowerShellArsenal..." -ForegroundColor Cyan

$ArsenalSource = Join-Path $TempExtract "PowerShellArsenal"
$ArsenalTarget = Join-Path $ModulesRoot "PowerShellArsenal"

if (Test-Path $ArsenalSource) {
    if (Test-Path $ArsenalTarget) {
        Remove-Item -Recurse -Force $ArsenalTarget -ErrorAction SilentlyContinue
    }

    Copy-Item -Path $ArsenalSource -Destination $ArsenalTarget -Recurse -Force
    Write-Host "[OK] PowerShellArsenal installiert." -ForegroundColor Green
}
else {
    Write-Host "[INFO] PowerShellArsenal nicht im Paket enthalten." -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 8. PowerShell-Profil deployen
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Installiere PowerShell-Profil..." -ForegroundColor Cyan

$ProfileSource = Join-Path $TempExtract "Microsoft.PowerShell_profile.ps1"

$ProfileDir = Split-Path -Parent $ProfilePath
if (-not (Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
}

if (Test-Path $ProfileSource) {
    Copy-Item -Path $ProfileSource -Destination $ProfilePath -Force
    Write-Host "[OK] Profil installiert." -ForegroundColor Green
}
else {
    Write-Host "[WARNUNG] Profil-Datei fehlt im Paket." -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 9. nmap installieren + PATH setzen
# ------------------------------------------------------------

Write-Host ""
Write-Host "[INFO] Prüfe nmap Installation..." -ForegroundColor Cyan

$nmapCmd = Get-Command nmap -ErrorAction SilentlyContinue
$NmapInstaller = Join-Path $TempExtract "nmap-7.98-setup.exe"

if (-not $nmapCmd -and (Test-Path $NmapInstaller)) {
    Write-Host "[INFO] Installiere nmap..." -ForegroundColor Cyan
    try {
        Start-Process -FilePath $NmapInstaller -ArgumentList "/S" -Wait
    }
    catch {
        Write-Host "[WARNUNG] nmap konnte nicht installiert werden: $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# PATH-Fix
$nmapPaths = @(
    "C:\Program Files (x86)\Nmap",
    "C:\Program Files\Nmap"
)

$envPathUser = [Environment]::GetEnvironmentVariable("Path", "User")
$envPathMachine = [Environment]::GetEnvironmentVariable("Path", "Machine")
$combinedPath = "$envPathMachine;$envPathUser"

foreach ($p in $nmapPaths) {
    if ((Test-Path $p) -and ($combinedPath -notlike "*$p*")) {
        Write-Host "[INFO] Ergänze PATH um: $p" -ForegroundColor Cyan
        $newUserPath = if ([string]::IsNullOrEmpty($envPathUser)) { $p } else { "$envPathUser;$p" }
        [Environment]::SetEnvironmentVariable("Path", $newUserPath, "User")
        $envPathUser = $newUserPath
        $combinedPath = "$envPathMachine;$envPathUser"
    }
}

$nmapCmd = Get-Command nmap -ErrorAction SilentlyContinue
if ($nmapCmd) {
    Write-Host "[OK] nmap ist verfügbar." -ForegroundColor Green
}
else {
    Write-Host "[WARNUNG] nmap ist nach Installation nicht im PATH auffindbar." -ForegroundColor Yellow
}

# ------------------------------------------------------------
# 10. Self-Check-System
# ------------------------------------------------------------

Write-Host ""
Write-Host "=== CYBERDECK SELF-CHECK ===" -ForegroundColor Cyan

$SelfCheck = [ordered]@{}

$SelfCheck["Starship"] = if (Get-Command starship -ErrorAction SilentlyContinue) { "OK" } else { "FEHLT" }
$SelfCheck["Starship-Config"] = if (Test-Path $StarshipConfig) { "OK" } else { "FEHLT" }

try {
    Import-Module Cyberdeck -ErrorAction Stop
    $SelfCheck["Cyberdeck-Modul"] = "OK"
}
catch {
    $SelfCheck["Cyberdeck-Modul"] = "FEHLER"
}

if (Get-Module -ListAvailable -Name PowerShellArsenal) {
    $SelfCheck["PowerShellArsenal-Modul"] = "OK"
}
else {
    $SelfCheck["PowerShellArsenal-Modul"] = "NICHT INSTALLIERT (optional)"
}

$SelfCheck["PowerShell-Profil"] = if (Test-Path $ProfilePath) { "OK" } else { "FEHLT" }
$SelfCheck["nmap"] = if (Get-Command nmap -ErrorAction SilentlyContinue) { "OK" } else { "FEHLT" }

foreach ($key in $SelfCheck.Keys) {
    $status = $SelfCheck[$key]
    $color = if ($status -eq "OK" -or $status -like "NICHT INSTALLIERT*") { "Green" } else { "Yellow" }
    Write-Host ("[CHECK] {0}: {1}" -f $key, $status) -ForegroundColor $color
}

# ------------------------------------------------------------
# 11. Aufräumen & Abschluss
# ------------------------------------------------------------

if (Test-Path $TempExtract) {
    Remove-Item -Recurse -Force $TempExtract -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "=== INSTALLATION ABGESCHLOSSEN ===" -ForegroundColor Green
Write-Host "Starte PowerShell neu, damit PATH & Profil vollständig aktiv sind." -ForegroundColor Cyan
Write-Host ""
