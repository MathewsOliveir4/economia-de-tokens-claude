# Economia de Tokens para Claude Code — desinstalador (Windows / PowerShell)
# Uso (um comando só, sem baixar nada):
#   irm https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/uninstall.ps1 | iex
# Remove o modo econômico do ~/.claude/CLAUDE.md e os comandos /resumo e /retomar.
# Suas notas e resumos salvos NÃO são apagados.

$claude = Join-Path $HOME '.claude'
$md     = Join-Path $claude 'CLAUDE.md'
$utf8   = New-Object System.Text.UTF8Encoding($false)

foreach ($c in 'resumo', 'retomar') {
    $f = Join-Path (Join-Path $claude 'commands') "$c.md"
    if (Test-Path $f) { Remove-Item $f -Force; Write-Host "OK  Comando /$c removido" }
}

if (Test-Path $md) {
    $txt  = [IO.File]::ReadAllText($md, $utf8)
    $novo = $txt -replace '(?s)\s*<!-- economia-de-tokens:inicio -->.*?<!-- economia-de-tokens:fim -->', ''
    # versões antigas, sem marcação
    $novo = $novo -replace '(?s)\s*# Modo econ.mico \(padr.o\).*?- Exce..o:[^\r\n]*', ''
    if ($novo -ne $txt) {
        $novo = $novo.Trim()
        if ($novo) { [IO.File]::WriteAllText($md, $novo + "`n", $utf8) } else { Remove-Item $md -Force }
        Write-Host "OK  Modo economico removido do CLAUDE.md"
    }
}
Write-Host "Pronto. Reabra o Claude Code. (Notas e resumos salvos foram mantidos.)"
