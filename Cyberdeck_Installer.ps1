# ───────────────────────────────────────────────────────────────
#   CYBERDECK INSTALLER SCRIPT
#   Installiert Starship, PS7-Profil, PS5-Profil, TOML-Dateien
#   Erstellt Backups, schreibt alle Dateien automatisch
# ───────────────────────────────────────────────────────────────

Write-Host "`n[INSTALL] Starship Cyberdeck Installer gestartet..." -ForegroundColor Cyan

# ───────────────────────────────────────────────────────────────
#   1) Starship installieren
# ───────────────────────────────────────────────────────────────
Write-Host "[INSTALL] Installiere Starship..." -ForegroundColor Magenta
winget install --id Starship.Starship -e --source winget

# ───────────────────────────────────────────────────────────────
#   2) Pfade definieren
# ───────────────────────────────────────────────────────────────
$PS7Profile = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$PS5Profile = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

$StarshipPS7 = "$HOME\starship-ps7.toml"
$StarshipPS5 = "$HOME\starship-ps5.toml"

# Ordner anlegen
New-Item -ItemType Directory -Force -Path "$HOME\Documents\PowerShell" | Out-Null
New-Item -ItemType Directory -Force -Path "$HOME\Documents\WindowsPowerShell" | Out-Null

# ───────────────────────────────────────────────────────────────
#   3) Backups erstellen
# ───────────────────────────────────────────────────────────────
foreach ($file in @($PS7Profile, $PS5Profile, $StarshipPS7, $StarshipPS5)) {
    if (Test-Path $file) {
        Copy-Item $file "$file.bak_$(Get-Date -Format 'yyyyMMdd_HHmmss')" -Force
        Write-Host "[BACKUP] Backup erstellt für $file" -ForegroundColor Yellow
    }
}

# ───────────────────────────────────────────────────────────────
#   4) Starship TOML Dateien schreiben
# ───────────────────────────────────────────────────────────────

# PS7 TOML
@"
# ───────────────────────────────────────────────────────────────
#   CYBERPUNK STARSHIP THEME (PowerShell 7)
#   Ohne Network/VPN Module
# ───────────────────────────────────────────────────────────────

format = """
[](#ff00ff)$os$username[](bg:#00eaff fg:#ff00ff)$directory[](bg:#1a1a1a fg:#00eaff)$git_branch$git_status[](bg:#ff0099 fg:#1a1a1a)$time[](fg:#ff0099)$character
"""

[os]
format = "[ ](bg:#ff00ff fg:#000000)"
disabled = false

[username]
style_user = "bg:#ff00ff fg:#000000"
style_root = "bg:#ff00ff fg:#000000"
format = "[ $user ]($style)"
disabled = false

[directory]
style = "bg:#00eaff fg:#000000"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
style = "bg:#1a1a1a fg:#00eaff"
format = "[  $branch ]($style)"

[git_status]
style = "bg:#1a1a1a fg:#faff00"
format = "[ $all_status ]($style)"

[time]
disabled = false
time_format = "%H:%M:%S"
style = "bg:#ff0099 fg:#000000"
format = "[  $time ]($style)"

[character]
success_symbol = "[❯](fg:#ff00ff)"
error_symbol   = "[❯](fg:#ff0033)"
vicmd_symbol   = "[❮](fg:#00eaff)"
"@ | Set-Content $StarshipPS7 -Encoding UTF8

# PS5 TOML (Unicode-bereinigt)
@"
# ───────────────────────────────────────────────────────────────
#   CYBERPUNK STARSHIP THEME (PowerShell 5)
#   PS5-kompatibel
# ───────────────────────────────────────────────────────────────

format = """
[](#ff00ff)$os$username[](bg:#00eaff fg:#ff00ff)$directory[](bg:#1a1a1a fg:#00eaff)$git_branch$git_status[](bg:#ff0099 fg:#1a1a1a)$time[](fg:#ff0099)$character
"""

[os]
format = "[OS ](bg:#ff00ff fg:#000000)"
disabled = false

[username]
style_user = "bg:#ff00ff fg:#000000"
style_root = "bg:#ff00ff fg:#000000"
format = "[ $user ]($style)"
disabled = false

[directory]
style = "bg:#00eaff fg:#000000"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = ".../"

[git_branch]
style = "bg:#1a1a1a fg:#00eaff"
format = "[ BR $branch ]($style)"

[git_status]
style = "bg:#1a1a1a fg:#faff00"
format = "[ $all_status ]($style)"

[time]
disabled = false
time_format = "%H:%M:%S"
style = "bg:#ff0099 fg:#000000"
format = "[ TIME $time ]($style)"

[character]
success_symbol = "[>](fg:#ff00ff)"
error_symbol   = "[>](fg:#ff0033)"
vicmd_symbol   = "[<](fg:#00eaff)"
"@ | Set-Content $StarshipPS5 -Encoding UTF8

# ───────────────────────────────────────────────────────────────
#   5) PowerShell 7 Profil schreiben
# ───────────────────────────────────────────────────────────────

@"
# ───────────────────────────────────────────────────────────────
#   PowerShell 7 Cyberdeck Profil
# ───────────────────────────────────────────────────────────────

Invoke-Expression (&starship init powershell --config="$HOME\starship-ps7.toml")

function Show-GlitchHeader {
    $gl = @("▒","░","▓","█","≡","≣","⟡","✦","✧","⟊","⟍","⟐")
    $pick = { $gl[(Get-Random -Min 0 -Max $gl.Count)] }

    $g1 = & $pick; $g2 = & $pick; $g3 = & $pick; $g4 = & $pick
    $g5 = & $pick; $g6 = & $pick; $g7 = & $pick; $g8 = & $pick

    Write-Host " $g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4 " -ForegroundColor Magenta
    Write-Host " $g4   C R Y P T I C   T E R M I N A L   $g4 " -ForegroundColor Cyan
    Write-Host " $g4     C Y B E R P U N K   N O D E     $g4 " -ForegroundColor Yellow
    Write-Host " $g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4$g4 " -ForegroundColor Magenta
}

Show-GlitchHeader

function Show-GradientBars {
    $frames = @(
        "███▒▒▒░░░░░░░░░░░░░░░░░░░░",
        "█████▒▒▒░░░░░░░░░░░░░░░░░░",
        "███████▒▒▒░░░░░░░░░░░░░░░░",
        "█████████▒▒▒░░░░░░░░░░░░░░",
        "███████████▒▒▒░░░░░░░░░░░░",
        "█████████████▒▒▒░░░░░░░░░░",
        "███████████████▒▒▒░░░░░░░░",
        "█████████████████▒▒▒░░░░░░",
        "███████████████████▒▒▒░░░░",
        "█████████████████████▒▒▒░░",
        "███████████████████████▒▒▒",
        "██████████████████████████"
    )

    $colors = @(
        "Magenta",
        "DarkMagenta",
        "Blue",
        "Cyan",
        "DarkCyan"
    )

    foreach ($i in 0..($frames.Count - 1)) {
        $color = $colors[$i % $colors.Count]
        Write-Host $frames[$i] -ForegroundColor $color
        Start-Sleep -Milliseconds 80
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
        Write-Host (" " * ($frames[$i].Length + 5))
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
    }

    # Final neon bar stehen lassen
    Write-Host ""
    Write-Host "██████████████████████████████████" -ForegroundColor Magenta
    Write-Host ""
}

function Show-BootSequence {
    $frames = @(
        " [BOOT] Initializing cyberdeck modules .",
        " [BOOT] Initializing cyberdeck modules ..",
        " [BOOT] Initializing cyberdeck modules ...",
        " [BOOT] Initializing cyberdeck modules ....",
        " [BOOT] Loading neural interface .",
        " [BOOT] Loading neural interface ..",
        " [BOOT] Loading neural interface ...",
        " [BOOT] Loading neural interface ....",
        " [BOOT] Establishing terminal link .",
        " [BOOT] Establishing terminal link ..",
        " [BOOT] Establishing terminal link ..."
        " [BOOT] Establishing terminal link ...."
    )

    foreach ($f in $frames) {
        Write-Host $f -ForegroundColor Cyan
        Start-Sleep -Milliseconds 180
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
        Write-Host (" " * ($f.Length + 5))
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
    }

    # Final line stays stehen
    Write-Host " [BOOT] Terminal link established." -ForegroundColor Green
}

function Show-GlitchIP {
    $gl = @("▒","░","▓","█","≡","≣","⟡","✦","✧","⟊","⟍","⟐")
    $pick = { $gl[(Get-Random -Min 0 -Max $gl.Count)] }

    try {
        $ip = (Invoke-RestMethod "https://api.ipify.org?format=json").ip
    }
    catch {
        $ip = "n/a"
    }

    $g1 = & $pick; $g2 = & $pick; $g3 = & $pick

    Write-Host ""
    Write-Host "$g3$g3$g3 IP: $ip $g3$g3$g3" -ForegroundColor Green
}

Show-GlitchIP

function Clear-Glitch {
    [console]::Clear()
    Show-GlitchHeader
    Write-Host ""
    Show-GradientBars
    Show-BootSequence
    Show-GlitchIP
}

Set-Alias clear Clear-Glitch

"@ | Set-Content $PS7Profile -Encoding UTF8

# ───────────────────────────────────────────────────────────────
#   6) PowerShell 5 Profil schreiben
# ───────────────────────────────────────────────────────────────

@"
# ───────────────────────────────────────────────────────────────
#   PowerShell 5 Cyberdeck Profil
# ───────────────────────────────────────────────────────────────

Invoke-Expression (&starship init powershell --config="$HOME\starship-ps5.toml")

function Show-GlitchHeader {
    Write-Host "CYBERDECK NODE" -ForegroundColor Magenta
    Write-Host ""
}

function Show-GlitchIP {
    try {
        $ip = (Invoke-RestMethod -Uri "https://api.ipify.org?format=json").ip
        Write-Host "IP: $ip" -ForegroundColor Magenta
    } catch {
        Write-Host "IP: OFFLINE" -ForegroundColor DarkRed
    }
}

function Show-BootSequence {
    $frames = @(
        " [BOOT] Initializing .",
        " [BOOT] Initializing ..",
        " [BOOT] Initializing ...",
        " [BOOT] Loading .",
        " [BOOT] Loading ..",
        " [BOOT] Loading ...",
        " [BOOT] Linking .",
        " [BOOT] Linking ..",
        " [BOOT] Linking ..."
    )

    foreach ($f in $frames) {
        Write-Host $f -ForegroundColor Cyan
        Start-Sleep -Milliseconds 90
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
        Write-Host (" " * ($f.Length + 5))
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
    }

    Write-Host " [BOOT] Ready." -ForegroundColor Green
    Write-Host ""
}

function Show-GradientBars {
    $frames = @(
        "###------------------------",
        "#####----------------------",
        "#######--------------------",
        "#########------------------",
        "###########----------------",
        "#############--------------",
        "###############------------",
        "#################----------",
        "###################--------",
        "#####################------",
        "#######################----",
        "#########################--",
        "###########################"
    )

    $colors = @("Magenta","DarkMagenta","Blue","Cyan","DarkCyan")

    foreach ($i in 0..($frames.Count - 1)) {
        $color = $colors[$i % $colors.Count]
        Write-Host $frames[$i] -ForegroundColor $color
        Start-Sleep -Milliseconds 40
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
        Write-Host (" " * ($frames[$i].Length + 5))
        [console]::SetCursorPosition(0, [console]::CursorTop - 1)
    }

    Write-Host "###############################" -ForegroundColor Magenta
    Write-Host ""
}

function Clear-Glitch {
    [console]::Clear()
    Show-GlitchHeader
    Show-GradientBars
    Show-BootSequence
    Show-GlitchIP
}

Set-Alias cg Clear-Glitch
"@ | Set-Content $PS5Profile -Encoding UTF8

# ───────────────────────────────────────────────────────────────
#   Fertig
# ───────────────────────────────────────────────────────────────

Write-Host "`n[INSTALL] Cyberdeck erfolgreich installiert!" -ForegroundColor Green
Write-Host "[INSTALL] PS7: clear" -ForegroundColor Cyan
Write-Host "[INSTALL] PS5: cg" -ForegroundColor Cyan
Write-Host "[INSTALL] Starship TOMLs wurden erstellt." -ForegroundColor Cyan