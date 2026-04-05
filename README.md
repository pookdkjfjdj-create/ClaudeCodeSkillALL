# 🚀 Claude Code Skills Installer

> Самый полный инсталлятор скиллов для [Claude Code](https://claude.ai/code) — один скрипт, все лучшие скиллы экосистемы.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Skills Count](https://img.shields.io/badge/skills_repos-25%2B-blue)]()
[![Platforms](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey)]()

---

## Что это

Claude Code поддерживает **Skills** — модульные инструкции, которые автоматически активируются когда нужны. Этот репозиторий автоматически клонирует лучшие скиллы сообщества в `~/.claude/skills/` для всех трёх операционных систем.

**Включает скиллы от:** Anthropic, Vercel Labs, Supabase, Trail of Bits, Orchestra Research, BloopAI и сотен авторов сообщества.

---

## Быстрый старт

### macOS / Linux

```bash
git clone https://github.com/YOUR_USERNAME/claude-skills-installer
cd claude-skills-installer
chmod +x install.sh
./install.sh
```

### Windows (PowerShell)

```powershell
# Разрешить выполнение скриптов (один раз)
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

git clone https://github.com/YOUR_USERNAME/claude-skills-installer
cd claude-skills-installer
.\install.ps1
```

### Универсальный (Python 3, любая ОС)

```bash
git clone https://github.com/YOUR_USERNAME/claude-skills-installer
cd claude-skills-installer
python3 install.py
```

**Дополнительные флаги Python-инсталлятора:**

```bash
python3 install.py --list              # показать список без установки
python3 install.py --cat memory        # установить только категорию
python3 install.py --cat productivity
python3 install.py --cat security
# доступные категории: memory, productivity, security, browser,
#                      database, n8n, obsidian, research, pm,
#                      design, megapacks, official, writing
```

---

## Что устанавливается

### 🧠 Память и контекст сессий

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | Автоматическая память: захватывает сессии, сжимает AI, инжектирует контекст в следующую | #1 trending Feb 2026 |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | Комплексный harness: скиллы, инстинкты, Context7, security-first | 997 тестов |
| [netresearch/context7-skill](https://github.com/netresearch/context7-skill) | Актуальная документация 50+ библиотек прямо в контексте | — |
| [muratcankoylan/Agent-Skills-for-Context-Engineering](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering) | 13 скиллов: context-fundamentals, multi-agent-patterns, memory-systems | — |

### ⚡ Продуктивность и workflow

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) | 20+ скиллов, TDD, brainstorm→plan→execute — самый звёздный dev-методология | 40k+ |
| [gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done) | GSD: lightweight meta-prompting + spec-driven development | — |
| [NeoLabHQ/context-engineering-kit](https://github.com/NeoLabHQ/context-engineering-kit) | SDD, FPF, Kaizen, Customaize Agent | — |
| [FlorianBruniaux/claude-code-ultimate-guide](https://github.com/FlorianBruniaux/claude-code-ultimate-guide) | 228 production-ready шаблонов: agents, commands, hooks, skills | — |
| [levnikolaevich/claude-code-skills](https://github.com/levnikolaevich/claude-code-skills) | Full Agile pipeline + hex MCP servers (hex-line, hex-ssh, hex-graph) | — |

### 🔐 Безопасность

| Репозиторий | Описание |
|---|---|
| [trailofbits/skills](https://github.com/trailofbits/skills) | Профессиональный security audit: CodeQL, Semgrep, variant analysis |
| [BehiSecc/awesome-claude-skills](https://github.com/BehiSecc/awesome-claude-skills) | VibeSec, OWASP Top10 2025, varlock, sanitize PII, ironclaw-agent-guard |

### 🌐 Браузер и веб-автоматизация

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [SawyerHood/dev-browser](https://github.com/SawyerHood/dev-browser) | Лёгкий браузер-скилл, QuickJS sandbox, без Playwright | 3.3k |
| [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | Мощный CLI + Playwright, сессии, iOS симулятор, снимки | — |
| [ZenoWangzy/agent-browser-claude-plugin](https://github.com/ZenoWangzy/agent-browser-claude-plugin) | Claude Code plugin для agent-browser: скрейпинг, формы, E2E | — |

### 🗄️ Базы данных

| Репозиторий | Описание |
|---|---|
| [supabase/agent-skills](https://github.com/supabase/agent-skills) | Официальные скиллы Supabase: Postgres best practices, 8 категорий |

### 🔄 n8n автоматизация

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [czlonkowski/n8n-skills](https://github.com/czlonkowski/n8n-skills) | 7 скиллов: expression-syntax, workflow-patterns, validation-expert, MCP tools | 2.2k |

### 📓 Obsidian

| Репозиторий | Описание |
|---|---|
| [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) | Официальные скиллы от CEO Obsidian: Markdown, Bases, JSON Canvas, CLI |
| [pablo-mano/Obsidian-CLI-skill](https://github.com/pablo-mano/Obsidian-CLI-skill) | Obsidian CLI: notes, daily notes, search, tags, plugins |

### 🔬 AI-исследования и Deep Research

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [Orchestra-Research/AI-Research-SKILLs](https://github.com/Orchestra-Research/AI-Research-SKILLs) | 50+ AI/ML скиллов + autoresearch: LitGPT, Mamba, fine-tuning, RAG | 2.2k |

### 📋 Kanban и управление проектами

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [BloopAI/vibe-kanban](https://github.com/BloopAI/vibe-kanban) | AI-kanban для Claude Code / Codex / Amp: план → трекинг → выполнение | 14.7k |

### 🎨 UI/UX и дизайн

| Репозиторий | Описание |
|---|---|
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Design intelligence для профессиональных интерфейсов |

### 📦 Мега-паки

| Репозиторий | Описание | Скиллов |
|---|---|---|
| [alirezarezvani/claude-skills](https://github.com/alirezarezvani/claude-skills) | engineering, DevOps, marketing, compliance, C-level — 11 платформ | 220+ |
| [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) | Для Claude Code / Cursor / Codex / Gemini CLI | 1340+ |
| [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | Официальные: Anthropic, Google, Vercel, Stripe, Supabase, Trail of Bits | 1000+ |
| [mxyhi/ok-skills](https://github.com/mxyhi/ok-skills) | Отборные: docs lookup, browser, GitHub, planning, design, PDF | 55 |

### 🏢 Официальные скиллы от вендоров

| Репозиторий | Описание |
|---|---|
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | React best practices, Web Design Guidelines |
| [anthropics/skills](https://github.com/anthropics/skills) | docx, pdf, pptx, xlsx, brand guidelines, canvas-design |

### ✍️ Письмо и контент

| Репозиторий | Описание | ⭐ |
|---|---|---|
| [blader/humanizer](https://github.com/blader/humanizer) | Убирает AI-признаки из текста | 2.9k |

---

## После установки

Открой Claude Code и выполни эти команды:

```
# Superpowers (рекомендуется в первую очередь)
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace

# claude-mem (долгосрочная память)
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem

# Supabase
/plugin marketplace add supabase/agent-skills
/plugin install postgres-best-practices@supabase-agent-skills

# n8n
/plugin marketplace add czlonkowski/n8n-skills
/plugin install n8n-mcp-skills@czlonkowski/n8n-skills

# Obsidian
/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills

# Trail of Bits Security
/plugin marketplace add trailofbits/skills
/plugin install security@trailofbits/skills

# 220+ alirezarezvani скиллов
/plugin marketplace add alirezarezvani/claude-skills
/plugin install engineering-skills@claude-code-skills
/plugin install engineering-advanced-skills@claude-code-skills
/plugin install product-skills@claude-code-skills
/plugin install marketing-skills@claude-code-skills

# Перезагрузить плагины
/reload-plugins
```

Затем проверь:

```
What skills do you have available?
```

---

## Требования

| Зависимость | Обязательно | Для чего |
|---|---|---|
| `git` | ✅ | Клонирование репозиториев |
| `npx` / Node.js | ⚠️ | GSD глобальная установка |
| `python3` | только для `install.py` | Универсальный скрипт |

---

## Структура после установки

```
~/.claude/
├── skills/
│   ├── claude-mem/
│   ├── superpowers/
│   ├── get-shit-done/
│   ├── trailofbits-security/
│   ├── dev-browser/
│   ├── agent-browser/
│   ├── supabase-skills/
│   ├── n8n-skills/
│   ├── obsidian-skills/
│   ├── ai-research-skills/
│   ├── vibe-kanban/
│   ├── alirezarezvani-220plus/
│   ├── antigravity-1300plus/
│   ├── voltagent-official-skills/
│   └── ...
└── CLAUDE.md   ← создай сам под свой проект
```

---

## Обновление скиллов

```bash
# macOS / Linux
./install.sh

# Windows
.\install.ps1

# Python (все ОС)
python3 install.py --update
```

Скрипт автоматически делает `git pull` для уже установленных репозиториев.

---

## Добавить свой скилл

Сделай Pull Request — добавь строку в нужную категорию в `install.py` (блок `SKILLS`):

```python
("https://github.com/AUTHOR/REPO",
 "folder-name",
 "Краткое описание что делает скилл"),
```

---

## Безопасность

> ⚠️ Скиллы могут выполнять код в твоём окружении. Устанавливай только из доверенных источников.

Все скиллы в этом инсталляторе взяты из:
- Официальных репозиториев (Anthropic, Vercel, Supabase, Trail of Bits)
- Высокозвёздных проектов сообщества с публичной историей

---

## Лицензия

MIT — делай что хочешь, ссылка на оригинал приветствуется.

---

## Полезные ссылки

- [Документация Claude Code Skills](https://docs.anthropic.com/en/docs/claude-code/skills)
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [awesome-claude-skills](https://github.com/travisvn/awesome-claude-skills)
- [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills)
- [skills.sh — каталог 85k+ скиллов](https://skills.sh)
