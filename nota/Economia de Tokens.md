---
tags: [claude, tokens, prompts]
---
# Economia de Tokens

> 97–99% do gasto é **entrada** (histórico, arquivos lidos, instruções). Encurtar a resposta ajuda pouco; o que mais economiza é **conversa curta e contexto enxuto**. Use os blocos abaixo copiando só o que precisar.

## 1. Modo econômico (colar no início da conversa)
```
Modo econômico até eu dizer o contrário:
- Responda curto e direto. Sem saudação, elogio, resumo do que eu disse ou conclusão repetida.
- Frases curtas; fragmentos ok. Sem rodeios nem "talvez/acho que" desnecessários.
- Termos técnicos exatos. Código só o trecho alterado, não o arquivo inteiro.
- Estrutura: causa → ação → próximo passo.
- Não leia arquivos nem rode comandos além do necessário; pergunte se faltar informação.
- Se a tarefa for grande, mostre o plano em até 5 linhas antes de executar.
- Se eu disser "modo completo", responda detalhado até eu dizer "modo econômico".
```
**Quando não usar:** estudando algo novo, revisando um texto acadêmico ou quando a explicação é o objetivo. Aí diga "modo completo".

## 2. Resumo de passagem (antes de encerrar uma conversa longa)
```
Resuma esta conversa para eu continuar em outra, em até 15 linhas:
Objetivo | Decidido | Feito | Falta fazer | Arquivos envolvidos | Cuidados/erros já vistos.
Sem explicações, só fatos.
```
Salvar o resultado em `Resumos/AAAA-MM-DD assunto.md` (ver `Resumos/Modelo.md`). No Claude Code, use `/resumo` e `/retomar` (seção 6).

## 3. Retomar em conversa nova
```
Continuação. Contexto abaixo; não repita, só siga do "Falta fazer".
[colar o resumo]
```

## 4. Pedido bem feito (gasta menos idas e voltas)
```
Tarefa: [o quê] em [arquivo/linha]. Entrada: [..]. Saída esperada: [..].
Restrições: [..]. Não mexer em: [..].
```

## 5. Hábitos que mais economizam
- **Um assunto por conversa.** Mudou de assunto → conversa nova.
- **Claude Code:** `/clear` entre tarefas · `/compact` em conversa longa (ex.: `/compact foque nas decisões e no que falta`) · `/model` → modelo leve para tarefa simples.
- Apontar arquivos com `@arquivo` em vez de pedir para procurar.
- `CLAUDE.md` curto; detalhes em notas separadas, lidas só quando precisar.
- Desligar integrações (MCP) que não usa.
- Juntar perguntas relacionadas numa mensagem só.
- Corrigir o rumo cedo: refazer custa mais que planejar.

## 6. Deixar automático no Claude Code
Rode o instalador do repositório (`install.ps1` no Windows, `install.sh` no macOS/Linux). Ele ativa o modo econômico em todos os projetos e cria os comandos `/resumo [assunto]` e `/retomar [assunto]`.

## Não fazer
- Colar a conversa inteira num .md e reenviar (mesmo gasto).
- Colar esta nota inteira toda vez — use só o bloco necessário.

## Teste (out/2026 · Claude Code · Sonnet 5.5)
| Tarefa | Resposta normal → eco | Custo |
|---|---|---|
| Explicação (git) | 906 → 314 tokens | −42% |
| Código (CSV) | 876 → 376 | −30% |
| Erro Python | 636 → 198 | −31% |
| ABNT | 884 → 501 | −22% |

Resumo de passagem: histórico de ~6.800 tokens virou ~700. Cada mensagem seguinte ficou 57% mais barata, e o resumo se pagou já na 1ª mensagem. Qualidade das respostas mantida.
