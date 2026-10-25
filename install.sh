#!/usr/bin/env bash
# Token Saver for Claude Code / Economia de Tokens — installer (macOS / Linux)
# Quick install (one command, no clone):
#   Português: curl -fsSL https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.sh | bash
#   English:   curl -fsSL https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.sh | bash -s -- --lang en
# Local: ./install.sh [--lang pt|en] ["/path/to/your/vault"]
set -euo pipefail
LANG_KIT="${KIT_LANG:-pt}"; PASTA=""
while [ $# -gt 0 ]; do
  case "$1" in --lang) LANG_KIT="$2"; shift 2;; --lang=*) LANG_KIT="${1#*=}"; shift;; *) PASTA="$1"; shift;; esac
done
if [ "$LANG_KIT" = "en" ]; then
  SRC="claude/en"; CMDS="handoff pickup"; SUM="Handoffs"; NOTE="nota/en/Token Saving.md"; TPL="nota/en/Template.md"
  PASTA="${PASTA:-$HOME/Documents/Token Saving}"
else
  SRC="claude"; CMDS="resumo retomar"; SUM="Resumos"; NOTE="nota/Economia de Tokens.md"; TPL="nota/Modelo.md"
  PASTA="${PASTA:-$HOME/Documents/Economia de Tokens}"
fi

REPO="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
if [ ! -f "$REPO/claude/CLAUDE-global.md" ]; then   # running via "curl | bash"
  TMP="$(mktemp -d)"
  curl -fsSL https://github.com/MathewsOliveir4/economia-de-tokens-claude/archive/refs/heads/main.tar.gz | tar xz -C "$TMP"
  REPO="$TMP/economia-de-tokens-claude-main"
fi

CLAUDE="$HOME/.claude"; RESUMOS="$PASTA/$SUM"
mkdir -p "$CLAUDE/commands" "$RESUMOS"

if ! grep -q "economia-de-tokens:inicio" "$CLAUDE/CLAUDE.md" 2>/dev/null; then
  { [ -s "$CLAUDE/CLAUDE.md" ] && printf '\n\n'; cat "$REPO/$SRC/CLAUDE-global.md"; } >> "$CLAUDE/CLAUDE.md"
  echo "OK  Economy mode -> $CLAUDE/CLAUDE.md"
else echo "--  Economy mode already in CLAUDE.md"; fi

for c in $CMDS; do
  sed "s|{{RESUMOS_DIR}}|$RESUMOS|g" "$REPO/$SRC/commands/$c.md" > "$CLAUDE/commands/$c.md"
  echo "OK  /$c"
done

cp "$REPO/$NOTE" "$PASTA/"; cp "$REPO/$TPL" "$RESUMOS/"
echo "OK  Note -> $PASTA"
echo; echo "Done! Reopen Claude Code and type / to see the new commands."
