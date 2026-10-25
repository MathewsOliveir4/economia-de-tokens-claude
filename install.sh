#!/usr/bin/env bash
# Economia de Tokens para Claude Code — instalador (macOS / Linux)
# Uso rápido: curl -fsSL https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.sh | bash
# Uso local: ./install.sh                         (salva em ~/Documents/Economia de Tokens)
#      ./install.sh "/caminho/do/seu/cofre"
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
if [ ! -f "$REPO/claude/CLAUDE-global.md" ]; then   # executado via "curl | bash"
  TMP="$(mktemp -d)"
  curl -fsSL https://github.com/MathewsOliveir4/economia-de-tokens-claude/archive/refs/heads/main.tar.gz | tar xz -C "$TMP"
  REPO="$TMP/economia-de-tokens-claude-main"
fi
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
