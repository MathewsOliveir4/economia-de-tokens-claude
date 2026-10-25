<#
  Economia de Tokens para Claude Code — instalador (Windows / PowerShell)
  Uso rápido (um comando só, sem clonar):
        irm https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.ps1 | iex
  Uso local:  .\install.ps1                      # salva a nota e os resumos em Documentos\Economia de Tokens
        .\install.ps1 -Pasta "C:\caminho\do\seu\cofre-obsidian"
  Pode ser executado mais de uma vez sem duplicar nada.
#>
param([string]$Pasta = "$([Environment]::GetFolderPath('MyDocuments'))\Economia de Tokens")

$ErrorActionPreference = 'Stop'
$repo    = $PSScriptRoot
if (-not $repo) {   # executado via "irm | iex": baixa o kit para uma pasta temporária
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ("economia-tokens-" + [guid]::NewGuid())
    New-Item -ItemType Directory -Force $tmp | Out-Null
    Invoke-WebRequest 'https://github.com/MathewsOliveir4/economia-de-tokens-claude/archive/refs/heads/main.zip' -OutFile "$tmp/kit.zip" -UseBasicParsing
    Expand-Archive "$tmp/kit.zip" $tmp -Force
    $repo = Join-Path $tmp 'economia-de-tokens-claude-main'
}
$claude  = Join-Path $HOME '.claude'
$cmds    = Join-Path $claude 'commands'
$resumos = Join-Path $Pasta 'Resumos'
$utf8    = New-Object System.Text.UTF8Encoding($false)

New-Item -ItemType Directory -Force $cmds, $resumos | Out-Null

# 1) Modo econômico no CLAUDE.md global (sem duplicar e sem apagar o que já existe)
$md    = Join-Path $claude 'CLAUDE.md'
$bloco = [IO.File]::ReadAllText((Join-Path $repo 'claude/CLAUDE-global.md'), $utf8)
$atual = if (Test-Path $md) { [IO.File]::ReadAllText($md, $utf8) } else { '' }
if ($atual -notmatch 'economia-de-tokens:inicio') {
    [IO.File]::WriteAllText($md, ($atual.TrimEnd() + "`n`n" + $bloco).TrimStart(), $utf8)
    Write-Host "OK  Modo economico adicionado a $md"
} else { Write-Host "--  Modo economico ja estava no CLAUDE.md" }

# 2) Comandos /resumo e /retomar
$dir = $resumos -replace '\\', '/'
foreach ($c in 'resumo', 'retomar') {
    $txt = [IO.File]::ReadAllText((Join-Path $repo "claude/commands/$c.md"), $utf8).Replace('{{RESUMOS_DIR}}', $dir)
    [IO.File]::WriteAllText((Join-Path $cmds "$c.md"), $txt, $utf8)
    Write-Host "OK  Comando /$c instalado"
}

# 3) Nota de consulta e modelo de resumo
Copy-Item (Join-Path $repo 'nota/Economia de Tokens.md') $Pasta -Force
Copy-Item (Join-Path $repo 'nota/Modelo.md') $resumos -Force
Write-Host "OK  Nota e modelo salvos em $Pasta"
Write-Host "`nPronto! Reabra o VS Code / Claude Code e digite / para ver /resumo e /retomar."
