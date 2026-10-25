<#
  Token Saver for Claude Code / Economia de Tokens — installer (Windows / PowerShell)

  Quick install (one command, no clone):
    Português: irm https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.ps1 | iex
    English:   $env:KIT_LANG='en'; irm https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.ps1 | iex

  Local:  .\install.ps1 [-Lang pt|en] [-Pasta "C:\path\to\your\obsidian-vault"]
  Safe to run more than once: nothing is duplicated or deleted.
#>
param(
    [ValidateSet('pt', 'en')][string]$Lang = $(if ($env:KIT_LANG -eq 'en') { 'en' } else { 'pt' }),
    [string]$Pasta = ''
)

$ErrorActionPreference = 'Stop'
$docs = [Environment]::GetFolderPath('MyDocuments')
if (-not $docs) { $docs = Join-Path $HOME 'Documents' }
if ($Lang -eq 'en') {
    $src = 'claude/en'; $cmdNames = 'handoff', 'pickup'; $sumDir = 'Handoffs'
    $note = 'nota/en/Token Saving.md'; $tpl = 'nota/en/Template.md'
    if (-not $Pasta) { $Pasta = Join-Path $docs 'Token Saving' }
} else {
    $src = 'claude'; $cmdNames = 'resumo', 'retomar'; $sumDir = 'Resumos'
    $note = 'nota/Economia de Tokens.md'; $tpl = 'nota/Modelo.md'
    if (-not $Pasta) { $Pasta = Join-Path $docs 'Economia de Tokens' }
}

$repo = $PSScriptRoot
if (-not $repo) {   # running via "irm | iex": download the kit to a temp folder
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ("economia-tokens-" + [guid]::NewGuid())
    New-Item -ItemType Directory -Force $tmp | Out-Null
    Invoke-WebRequest 'https://github.com/MathewsOliveir4/economia-de-tokens-claude/archive/refs/heads/main.zip' -OutFile "$tmp/kit.zip" -UseBasicParsing
    Expand-Archive "$tmp/kit.zip" $tmp -Force
    $repo = Join-Path $tmp 'economia-de-tokens-claude-main'
}

$claude  = Join-Path $HOME '.claude'
$cmds    = Join-Path $claude 'commands'
$resumos = Join-Path $Pasta $sumDir
$utf8    = New-Object System.Text.UTF8Encoding($false)
New-Item -ItemType Directory -Force $cmds, $resumos | Out-Null

# 1) Economy mode in the global CLAUDE.md (no duplicates, keeps existing content)
$md    = Join-Path $claude 'CLAUDE.md'
$bloco = [IO.File]::ReadAllText((Join-Path $repo "$src/CLAUDE-global.md"), $utf8)
$atual = if (Test-Path $md) { [IO.File]::ReadAllText($md, $utf8) } else { '' }
if ($atual -notmatch 'economia-de-tokens:inicio') {
    [IO.File]::WriteAllText($md, ($atual.TrimEnd() + "`n`n" + $bloco).TrimStart(), $utf8)
    Write-Host "OK  Economy mode -> $md"
} else { Write-Host "--  Economy mode already in CLAUDE.md" }

# 2) Slash commands
$dir = $resumos -replace '\\', '/'
foreach ($c in $cmdNames) {
    $txt = [IO.File]::ReadAllText((Join-Path $repo "$src/commands/$c.md"), $utf8).Replace('{{RESUMOS_DIR}}', $dir)
    [IO.File]::WriteAllText((Join-Path $cmds "$c.md"), $txt, $utf8)
    Write-Host "OK  /$c"
}

# 3) Reference note and template
Copy-Item (Join-Path $repo $note) $Pasta -Force
Copy-Item (Join-Path $repo $tpl) $resumos -Force
Write-Host "OK  Note -> $Pasta"
Write-Host "`nDone! Reopen VS Code / Claude Code and type / to see /$($cmdNames[0]) and /$($cmdNames[1])."
