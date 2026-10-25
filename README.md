<div align="center">

**English** · [Português](README.pt-BR.md)

# 🪙 Token Saver for Claude Code

**Spend fewer tokens in Claude Code without losing quality.**
A benchmarked prompt, two slash commands (`/handoff` and `/pickup`) and a reference note for Obsidian, installed in one command.

![Answers](https://img.shields.io/badge/answers-up%20to%2069%25%20shorter-2ea44f)
![Cost](https://img.shields.io/badge/cost%20per%20request-22–42%25%20lower-2ea44f)
![Long chats](https://img.shields.io/badge/long%20chats-57%25%20cheaper-2ea44f)
![Official](https://img.shields.io/badge/100%25-official%20features-blueviolet)
![License](https://img.shields.io/badge/license-MIT-blue)

</div>

---

## Why this exists

On every message, Claude Code re-reads **the entire conversation history**. Most of the cost comes from **input** (history, files read, instructions), not from the length of the answer. Prompts that only make answers terse help, but only a little.

This kit tackles both sides:

| Problem | What the kit does |
|---|---|
| Long, padded answers | **Economy mode**, on automatically in every project |
| Long conversations drag a huge history along | **`/handoff`** compresses the conversation into 15 lines and saves it to a file |
| Starting over in a new conversation | **`/pickup`** continues exactly where you left off |
| Forgetting the good habits | **Reference note** ready for Obsidian (or any folder) |

## 📊 Measured results

Tested with the real Claude Code (Sonnet 5.5 model): the same tasks with and without the kit, 2 runs each. The scripts are in [`teste/`](teste/), so you can reproduce them.

| Task | Answer length | Cost per request |
|---|---|---|
| Explain git merge vs. rebase | 906 → 314 tokens (**−65%**) | **−42%** |
| Write code (expenses CSV) | 876 → 376 (**−57%**) | **−30%** |
| Fix a Python error | 636 → 198 (**−69%**) | **−31%** |
| Academic formatting rules | 884 → 501 (**−43%**) | **−22%** |

**Handoff summary:** a ~6,800-token history became ~700 tokens. Each following message was **57% cheaper**, and the summary paid for itself on the very first message. Quality held up in every test: answers lose the filler, not the content.

> The benchmark prompts were in Portuguese. The English prompts are direct translations of the same rules.

## ⚡ Install (one command)

**Windows: paste into PowerShell**
```powershell
$env:KIT_LANG='en'; irm https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.ps1 | iex
```

**macOS / Linux: paste into your terminal**
```bash
curl -fsSL https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/install.sh | bash -s -- --lang en
```

Then reopen VS Code (or your Claude Code terminal) and type `/`. You should see `/handoff` and `/pickup`.

> The installer **never deletes anything**: it appends economy mode to the end of your `~/.claude/CLAUDE.md`, and you can run it again without duplicating anything. The reference note goes to `Documents/Token Saving`.

<details>
<summary>Prefer to clone, or want the note saved straight into your Obsidian vault?</summary>

```bash
git clone https://github.com/MathewsOliveir4/economia-de-tokens-claude.git
cd economia-de-tokens-claude
```
```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Lang en -Pasta "C:\path\to\your\vault"
```
```bash
./install.sh --lang en "/path/to/your/vault"
```
</details>

## 🗑️ Uninstall (one command)

**Windows:**
```powershell
irm https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/uninstall.ps1 | iex
```

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/MathewsOliveir4/economia-de-tokens-claude/main/uninstall.sh | bash
```

This removes economy mode and the slash commands. The rest of your `CLAUDE.md`, your notes and your saved summaries stay untouched.

## 🧰 What's in the kit

```
claude/en/CLAUDE-global.md      → economy mode (goes into ~/.claude/CLAUDE.md)
claude/en/commands/handoff.md   → /handoff command
claude/en/commands/pickup.md    → /pickup command
nota/en/Token Saving.md         → reference note with all the prompts
nota/en/Template.md             → handoff summary template
claude/, nota/                  → Portuguese version (/resumo and /retomar)
install.* / uninstall.*         → installers and uninstallers
teste/                          → benchmark scripts and data
```

## 🚀 How to use it

| Situation | What to do |
|---|---|
| Day to day | Nothing: economy mode is already on |
| You need a detailed explanation | Say **"full mode"**. To go back, say **"economy mode"** |
| The conversation got long | `/handoff topic-name`, then open a new conversation |
| Continue another day | `/pickup topic-name` |
| You changed topics | Open a new conversation (or `/clear`) |

Other habits that save tokens: `/compact` in long conversations, `/model` to use a lighter model for simple tasks, pointing to files with `@file`, keeping `CLAUDE.md` short, and turning off integrations (MCP) you don't use. It's all in the [note](nota/en/Token%20Saving.md).

## 🔬 Test it yourself

With Claude Code installed:

```bash
cd teste
python3 run.py claude-sonnet-5-5     # normal vs. economy mode, 4 tasks
python3 handoff.py                   # full history vs. handoff summary
```

The scripts use `claude -p --output-format json` and read the token usage that Claude Code itself reports. Running everything costs a few cents.

## ❓ FAQ

**Do I need a proxy, router or AI gateway (like OmniRoute, LiteLLM or OpenRouter) to save tokens?**
No. The kit uses only official Claude Code features: `CLAUDE.md` and custom slash commands. Nothing goes through third-party servers, your credentials stay with you, and your account stays within the service's terms of use.

**Does it work in Claude Code for VS Code and in the terminal?**
Yes. Both read the same `~/.claude` folder.

**What about the Claude app (web, desktop, mobile)?**
The slash commands are for Claude Code, but the prompts in the note work anywhere: just paste the block you need.

**Does economy mode make answers worse?**
Not in our tests. For studying, or when the explanation is the point, say "full mode".

**Why aren't the commands called `/summary` and `/resume`?**
`/resume` is already a built-in Claude Code command, so the kit uses `/handoff` and `/pickup` to avoid conflicts.

## 💚 Support the project

If the kit saved you tokens, give it a ⭐ and share it with other Claude Code users. You can also chip in any amount:

<table>
<tr>
<td align="center" width="50%">

**🌎 PayPal (worldwide)**

<a href="https://www.paypal.com/donate/?hosted_button_id=382TU2X3N5FC8"><img src="https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal&logoColor=white&style=for-the-badge" alt="Donate with PayPal"/></a>

<a href="https://www.paypal.com/donate/?hosted_button_id=382TU2X3N5FC8"><img src="assets/paypal-qr.png" width="160" alt="PayPal QR code"/></a>

</td>
<td align="center" width="50%">

**🇧🇷 Pix (Brazil)**

Random key:
```
f2c6046e-1546-44fd-afc1-8aafb6233837
```

</td>
</tr>
</table>

---

<sub>Keywords: Claude Code token saver, reduce Claude Code token usage, Claude Code cost, Claude usage limits, CLAUDE.md, custom slash commands, economy prompt, handoff summary, context management, Obsidian, AI gateway alternative, economia de tokens.</sub>

Made by [@MathewsOliveir4](https://github.com/MathewsOliveir4) · MIT License
