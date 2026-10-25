---
tags: [claude, tokens, prompts]
---
# Token Saving

> 97–99% of the cost is **input** (history, files read, instructions). Shorter answers help a little; what saves the most is **short conversations and lean context**. Copy only the block you need.

## 1. Economy mode (paste at the start of a conversation)
```
Economy mode until I say otherwise:
- Answer short and direct. No greetings, praise, restating my question, or repeated conclusions.
- Short sentences; fragments OK. No filler or unnecessary hedging.
- Exact technical terms. Code: only the changed snippet, not the whole file.
- Structure: cause → action → next step.
- Don't read files or run commands beyond what's needed; ask if information is missing.
- If the task is big, show the plan in up to 5 lines before executing.
- If I say "full mode", answer in detail until I say "economy mode".
```
**When not to use it:** learning something new, reviewing academic writing, or when the explanation is the goal. Then say "full mode".

## 2. Handoff summary (before closing a long conversation)
```
Summarize this conversation so I can continue in a new one, in up to 15 lines:
Goal | Decided | Done | To do | Files involved | Caveats/errors seen.
No explanations, facts only.
```
Save it as `Handoffs/YYYY-MM-DD topic.md` (see `Handoffs/Template.md`). In Claude Code, use `/handoff` and `/pickup` (section 6).

## 3. Pick up in a new conversation
```
Continuation. Context below; don't repeat it, just continue from "To do".
[paste the summary]
```

## 4. A well-scoped request (fewer back-and-forths)
```
Task: [what] in [file/line]. Input: [..]. Expected output: [..].
Constraints: [..]. Don't touch: [..].
```

## 5. Habits that save the most
- **One topic per conversation.** New topic → new conversation.
- **Claude Code:** `/clear` between tasks · `/compact` in long conversations (e.g. `/compact focus on decisions and what's left`) · `/model` → lighter model for simple tasks.
- Point to files with `@file` instead of asking it to search.
- Keep `CLAUDE.md` short; put details in separate notes read only when needed.
- Turn off integrations (MCP) you don't use.
- Batch related questions into one message.
- Correct course early: redoing costs more than planning.

## 6. Make it automatic in Claude Code
Run the repository installer with English selected (see README). It enables economy mode in every project and adds the `/handoff [topic]` and `/pickup [topic]` commands.

## Don't
- Paste the whole conversation into a .md and resend it (same cost).
- Paste this whole note every time — use only the block you need.

## Benchmark (Oct 2026 · Claude Code · Sonnet 5.5)
| Task | Normal → economy answer | Cost |
|---|---|---|
| Explanation (git) | 906 → 314 tokens | −42% |
| Code (CSV) | 876 → 376 | −30% |
| Python error | 636 → 198 | −31% |
| Academic formatting | 884 → 501 | −22% |

Handoff summary: a ~6,800-token history became ~700. Each following message was 57% cheaper, and the summary paid for itself on the very first message. Answer quality was preserved.
