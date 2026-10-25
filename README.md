<div align="center">

# 🪙 Economia de Tokens para Claude Code

**Gaste menos tokens no Claude Code sem perder qualidade.**
Um prompt testado, dois comandos (`/resumo` e `/retomar`) e uma nota de consulta para o Obsidian, com instalação em 1 minuto.

![Respostas](https://img.shields.io/badge/respostas-até%2069%25%20menores-2ea44f)
![Custo](https://img.shields.io/badge/custo%20por%20pedido-22–42%25%20menor-2ea44f)
![Conversas longas](https://img.shields.io/badge/conversas%20longas-57%25%20mais%20baratas-2ea44f)
![Oficial](https://img.shields.io/badge/100%25-recursos%20oficiais-blueviolet)
![Licença](https://img.shields.io/badge/licença-MIT-blue)

</div>

---

## Por que existe

Em cada mensagem, o Claude Code relê **todo o histórico** da conversa. A maior parte do gasto vem da **entrada** (histórico, arquivos lidos, instruções), não do tamanho da resposta. Prompts que só deixam a resposta "telegráfica" ajudam, mas pouco.

Este kit ataca os dois lados:

| Problema | Solução do kit |
|---|---|
| Respostas longas, com enrolação | **Modo econômico** automático em todos os projetos |
| Conversas longas carregam um histórico enorme | **`/resumo`** comprime a conversa em até 15 linhas e salva em arquivo |
| Recomeçar do zero numa conversa nova | **`/retomar`** continua exatamente de onde parou |
| Esquecer as boas práticas | **Nota de consulta** pronta para o Obsidian (ou qualquer pasta) |

## 📊 Resultados medidos

Testado com o Claude Code real (modelo Sonnet 5.5), mesmas tarefas com e sem o kit, 2 repetições cada. Os scripts estão em [`teste/`](teste/), então dá para reproduzir.

| Tarefa | Tamanho da resposta | Custo por pedido |
|---|---|---|
| Explicar git merge × rebase | 906 → 314 tokens (**−65%**) | **−42%** |
| Escrever código (CSV de gastos) | 876 → 376 (**−57%**) | **−30%** |
| Resolver erro de Python | 636 → 198 (**−69%**) | **−31%** |
| Normas ABNT (texto acadêmico) | 884 → 501 (**−43%**) | **−22%** |

**Resumo de passagem:** um histórico de ~6.800 tokens virou ~700. Cada mensagem seguinte ficou **57% mais barata**, e o resumo se pagou já na primeira mensagem. A qualidade se manteve em todos os testes: as respostas só perdem a enrolação, não o conteúdo.

## ⚡ Instalação

```bash
git clone https://github.com/MathewsOliveir4/economia-de-tokens-claude.git
cd economia-de-tokens-claude
```

**Windows (PowerShell)**
```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
# ou, para salvar a nota direto no seu cofre do Obsidian:
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Pasta "C:\caminho\do\seu\cofre"
```

**macOS / Linux**
```bash
./install.sh                       # ou: ./install.sh "/caminho/do/seu/cofre"
```

Depois, reabra o VS Code (ou o terminal do Claude Code) e digite `/`. Os comandos `/resumo` e `/retomar` devem aparecer.

> O instalador **não apaga nada**: ele acrescenta o modo econômico ao fim do seu `~/.claude/CLAUDE.md` e pode ser rodado de novo sem duplicar o conteúdo.

## 🧰 O que vem no kit

```
claude/CLAUDE-global.md      → modo econômico (vai para ~/.claude/CLAUDE.md)
claude/commands/resumo.md    → comando /resumo
claude/commands/retomar.md   → comando /retomar
nota/Economia de Tokens.md   → nota de consulta com todos os prompts
nota/Modelo.md               → modelo de resumo de passagem
teste/                       → scripts e dados do benchmark
```

## 🚀 Como usar

| Situação | O que fazer |
|---|---|
| Dia a dia | Nada: o modo econômico já está ativo |
| Precisa de explicação detalhada | Diga **"modo completo"**. Para voltar, diga **"modo econômico"** |
| A conversa ficou longa | `/resumo nome-do-assunto`, depois abra uma conversa nova |
| Continuar outro dia | `/retomar nome-do-assunto` |
| Trocou de assunto | Abra uma conversa nova (ou `/clear`) |

Outros hábitos que economizam: `/compact` em conversas longas, `/model` para usar um modelo mais leve em tarefas simples, apontar arquivos com `@arquivo`, manter o `CLAUDE.md` curto e desligar integrações (MCP) que você não usa. Tudo isso está explicado na [nota](nota/Economia%20de%20Tokens.md).

## 🔬 Teste você mesmo

Com o Claude Code instalado:

```bash
cd teste
python3 run.py claude-sonnet-5-5     # modo normal × econômico, 4 tarefas
python3 handoff.py                   # histórico completo × resumo de passagem
```

Os scripts usam `claude -p --output-format json` e leem o uso de tokens que o próprio Claude Code informa. Rodar tudo custa poucos centavos de dólar.

## ❓ Perguntas frequentes

**Preciso de um proxy, roteador ou gateway de IA (tipo OmniRoute, LiteLLM, OpenRouter) para economizar tokens?**
Não. O kit usa só recursos oficiais do Claude Code: `CLAUDE.md` e comandos personalizados. Nada passa por servidores de terceiros, suas credenciais ficam só com você e sua conta continua dentro dos termos de uso do serviço.

**Funciona no Claude Code do VS Code e no terminal?**
Sim. Os dois leem a mesma pasta `~/.claude`.

**E no app do Claude (web, desktop ou celular)?**
Os comandos são do Claude Code, mas os prompts da nota funcionam em qualquer lugar: é só colar o bloco desejado.

**O modo econômico piora as respostas?**
Nos testes, não. Para estudo ou textos em que a explicação é o objetivo, use "modo completo".

**Como desinstalar?**
Apague o bloco entre `<!-- economia-de-tokens:inicio -->` e `<!-- economia-de-tokens:fim -->` em `~/.claude/CLAUDE.md` e os arquivos `resumo.md` e `retomar.md` de `~/.claude/commands/`.

---

<details>
<summary><b>🇺🇸 English summary</b></summary>

**Claude Code token saver kit.** Reduce Claude Code token usage and cost with official features only, with no proxy or AI gateway. It includes a tested "economy mode" `CLAUDE.md` prompt (responses up to 69% shorter, 22–42% cheaper per request), plus `/resumo` (session handoff summary saved to a file) and `/retomar` (resume from summary) slash commands, which made long conversations 57% cheaper. It also ships an Obsidian note with all the prompts. One-command installers for Windows (PowerShell) and macOS/Linux, plus reproducible benchmark scripts. Prompts are in Portuguese, but they work the same in any language.

</details>

<sub>Palavras-chave: economia de tokens, reduzir tokens Claude Code, Claude Code mais barato, limite de uso Claude, CLAUDE.md, comandos personalizados, slash commands, prompt econômico, Obsidian, alternativa a gateway de IA, token saver, reduce Claude Code token usage.</sub>

Feito por [@MathewsOliveir4](https://github.com/MathewsOliveir4) · Licença MIT
