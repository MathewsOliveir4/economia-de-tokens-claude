#!/usr/bin/env bash
# Economia de Tokens para Claude Code — instalador (macOS / Linux)
# Uso: ./install.sh                         (salva em ~/Documents/Economia de Tokens)
#      ./install.sh "/caminho/do/seu/cofre"
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"
PASTA="${1:-$HOME/Documents/Economia de Tokens}"
CLAUDE="$HOME/.claude"; RESUMOS="$PASTA/Resumos"
mkdir -p "$CLAUDE/commands" "$RESUMOS"

if ! grep -q "economia-de-tokens:inicio" "$CLAUDE/CLAUDE.md" 2>/dev/null; then
  { [ -s "$CLAUDE/CLAUDE.md" ] && printf '\n\n'; cat "$REPO/claude/CLAUDE-global.md"; } >> "$CLAUDE/CLAUDE.md"
  echo "OK  Modo econômico adicionado a $CLAUDE/CLAUDE.md"
else echo "--  Modo econômico já estava no CLAUDE.md"; fi

for c in resumo retomar; do
  sed "s|{{RESUMOS_DIR}}|$RESUMOS|g" "$REPO/claude/commands/$c.md" > "$CLAUDE/commands/$c.md"
  echo "OK  Comando /$c instalado"
done

cp "$REPO/nota/Economia de Tokens.md" "$PASTA/"; cp "$REPO/nota/Modelo.md" "$RESUMOS/"
echo "OK  Nota e modelo salvos em $PASTA"
echo; echo "Pronto! Reabra o Claude Code e digite / para ver /resumo e /retomar."
