#!/usr/bin/env bash
# Economia de Tokens para Claude Code — desinstalador (macOS / Linux)
# Uso: curl -fsSL https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/uninstall.sh | bash
# Suas notas e resumos salvos NÃO são apagados.
C="$HOME/.claude"
for c in resumo retomar; do [ -f "$C/commands/$c.md" ] && rm -f "$C/commands/$c.md" && echo "OK  Comando /$c removido"; done
if [ -f "$C/CLAUDE.md" ] && grep -q "economia-de-tokens:inicio\|# Modo econômico (padrão)" "$C/CLAUDE.md"; then
  python3 - "$C/CLAUDE.md" << 'PY'
import re,sys,os
p=sys.argv[1]; s=open(p,encoding='utf-8').read()
s=re.sub(r'\s*<!-- economia-de-tokens:inicio -->.*?<!-- economia-de-tokens:fim -->','',s,flags=re.S)
s=re.sub(r'\s*# Modo econômico \(padrão\).*?- Exceção:[^\n]*','',s,flags=re.S).strip()
open(p,'w',encoding='utf-8').write(s+'\n') if s else os.remove(p)
PY
  echo "OK  Modo econômico removido do CLAUDE.md"
fi
echo "Pronto. Reabra o Claude Code. (Notas e resumos salvos foram mantidos.)"
