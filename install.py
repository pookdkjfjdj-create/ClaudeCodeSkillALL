#!/usr/bin/env python3
"""
Claude Code Skills Installer — универсальный (macOS / Linux / Windows)
https://github.com/YOUR_USERNAME/claude-skills-installer

Запуск:
    python3 install.py           # установить всё
    python3 install.py --update  # обновить уже установленное
    python3 install.py --list    # показать список скиллов без установки
    python3 install.py --cat memory  # установить только категорию
"""

import subprocess, sys, os, argparse
from pathlib import Path

# ─── Цвета ────────────────────────────────────────────────────────────────────
C = {"g": "\033[92m", "r": "\033[91m", "y": "\033[93m",
     "b": "\033[94m", "B": "\033[1m",  "R": "\033[0m"}

def h(t):  print(f"\n{C['B']}{C['b']}{'═'*60}{C['R']}\n{C['B']}{C['b']}  {t}{C['R']}\n{C['B']}{C['b']}{'═'*60}{C['R']}\n")
def ok(t): print(f"{C['g']}  ✓ {t}{C['R']}")
def er(t): print(f"{C['r']}  ✗ {t}{C['R']}")
def inf(t):print(f"{C['y']}  → {t}{C['R']}")

# ─── Полный список скиллов по категориям ──────────────────────────────────────
SKILLS = {
    "memory": {
        "title": "🧠  Память и контекст сессий",
        "repos": [
            # claude-mem — #1 trending GitHub Feb 2026, автоматическая память между сессиями
            ("https://github.com/thedotmack/claude-mem",
             "claude-mem",
             "Автоматическая память: захватывает сессии, сжимает AI, инжектирует в след. сессию"),
            # everything-claude-code — комплексный harness: скиллы, память, безопасность
            ("https://github.com/affaan-m/everything-claude-code",
             "everything-claude-code",
             "Комплексный harness: скиллы, инстинкты, память, Context7, security-first"),
            # context7 — live-документация библиотек для LLM
            ("https://github.com/netresearch/context7-skill",
             "context7-skill",
             "Context7: актуальная документация 50+ библиотек прямо в контексте агента"),
            # Context Engineering — паттерны многоагентных систем
            ("https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering",
             "context-engineering",
             "13 скиллов: context-fundamentals, multi-agent-patterns, memory-systems и др."),
        ]
    },
    "productivity": {
        "title": "⚡  Продуктивность и workflow",
        "repos": [
            # Superpowers — самый звёздный dev-methodology, 40k+ stars
            ("https://github.com/obra/superpowers",
             "superpowers",
             "Superpowers: 20+ скиллов, TDD, brainstorm→plan→execute, 40k+ ⭐"),
            # GSD — lightweight spec-driven development
            ("https://github.com/gsd-build/get-shit-done",
             "get-shit-done",
             "GSD: meta-prompting + context engineering + spec-driven dev от TÂCHES"),
            # NeoLab context engineering kit
            ("https://github.com/NeoLabHQ/context-engineering-kit",
             "context-engineering-kit",
             "SDD, FPF, Kaizen, Customaize Agent — advanced context engineering"),
            # Ultimate Guide + шаблоны
            ("https://github.com/FlorianBruniaux/claude-code-ultimate-guide",
             "claude-code-templates",
             "228 production-ready шаблонов: agents, commands, hooks, skills, scripts"),
            # levnikolaevich — Agile pipeline + hex MCP servers
            ("https://github.com/levnikolaevich/claude-code-skills",
             "levnikolaevich-skills",
             "Full Agile pipeline: bootstrap → docs → decompose → execute → QA"),
        ]
    },
    "security": {
        "title": "🔐  Безопасность",
        "repos": [
            # Trail of Bits — профессиональный security audit
            ("https://github.com/trailofbits/skills",
             "trailofbits-security",
             "Trail of Bits: static analysis, CodeQL/Semgrep, variant analysis, audit"),
            # BehiSecc awesome — включает VibeSec, OWASP, ironclaw-agent-guard и др.
            ("https://github.com/BehiSecc/awesome-claude-skills",
             "vibesec-collection",
             "VibeSec, OWASP Top10 2025, varlock, sanitize PII, ironclaw-agent-guard"),
        ]
    },
    "browser": {
        "title": "🌐  Браузер и веб-автоматизация",
        "repos": [
            # dev-browser — SawyerHood, 3.3k stars, лёгкий браузер-скилл
            ("https://github.com/SawyerHood/dev-browser",
             "dev-browser",
             "dev-browser: лёгкая браузерная автоматизация, 3.3k ⭐, QuickJS sandbox"),
            # agent-browser — Vercel Labs, официальный
            ("https://github.com/vercel-labs/agent-browser",
             "agent-browser",
             "agent-browser от Vercel Labs: мощный CLI + Playwright, сессии, снимки"),
            # agent-browser plugin для Claude Code
            ("https://github.com/ZenoWangzy/agent-browser-claude-plugin",
             "agent-browser-plugin",
             "Claude Code plugin для agent-browser: скрейпинг, формы, E2E-тесты"),
        ]
    },
    "database": {
        "title": "🗄️  Базы данных",
        "repos": [
            # Supabase официальные скиллы
            ("https://github.com/supabase/agent-skills",
             "supabase-skills",
             "Официальные скиллы Supabase: Postgres best practices, 8 категорий"),
        ]
    },
    "n8n": {
        "title": "🔄  n8n автоматизация",
        "repos": [
            # czlonkowski n8n-skills — 2.2k stars, 7 специализированных скиллов
            ("https://github.com/czlonkowski/n8n-skills",
             "n8n-skills",
             "7 скиллов n8n: expression-syntax, workflow-patterns, validation-expert и др."),
        ]
    },
    "obsidian": {
        "title": "📓  Obsidian",
        "repos": [
            # kepano — CEO Obsidian, официальные скиллы
            ("https://github.com/kepano/obsidian-skills",
             "obsidian-skills",
             "Официальные скиллы Obsidian от CEO kepano: Markdown, Bases, JSON Canvas"),
            # pablo-mano CLI skill
            ("https://github.com/pablo-mano/Obsidian-CLI-skill",
             "obsidian-cli-skill",
             "Obsidian CLI: read/create/edit notes, daily notes, search, tags, plugins"),
        ]
    },
    "research": {
        "title": "🔬  AI-исследования и Deep Research",
        "repos": [
            # Orchestra Research — AI/ML research skills, autoresearch
            ("https://github.com/Orchestra-Research/AI-Research-SKILLs",
             "ai-research-skills",
             "50+ AI/ML скиллов + autoresearch: LitGPT, Mamba, fine-tuning, RAG и др."),
        ]
    },
    "pm": {
        "title": "📋  Kanban и управление проектами",
        "repos": [
            # vibe-kanban — 14.7k stars, AI-kanban для Claude Code
            ("https://github.com/BloopAI/vibe-kanban",
             "vibe-kanban",
             "vibe-kanban: 10x эффективность с Claude Code / Codex / Amp, 14.7k ⭐"),
        ]
    },
    "design": {
        "title": "🎨  UI/UX и дизайн",
        "repos": [
            # UI/UX Pro Max
            ("https://github.com/nextlevelbuilder/ui-ux-pro-max-skill",
             "ui-ux-pro-max",
             "UI/UX Pro Max: design intelligence для профессиональных интерфейсов"),
        ]
    },
    "megapacks": {
        "title": "📦  Мега-паки (сотни скиллов)",
        "repos": [
            # alirezarezvani — 220+ скиллов для 11 платформ, 5.2k stars
            ("https://github.com/alirezarezvani/claude-skills",
             "alirezarezvani-220plus",
             "220+ скиллов: engineering, DevOps, marketing, compliance, C-level, 5.2k ⭐"),
            # antigravity-awesome — 1340+ скиллов
            ("https://github.com/sickn33/antigravity-awesome-skills",
             "antigravity-1300plus",
             "1340+ скиллов для Claude Code / Cursor / Codex / Gemini CLI"),
            # VoltAgent — официальные скиллы от Anthropic, Google, Vercel, Stripe, etc.
            ("https://github.com/VoltAgent/awesome-agent-skills",
             "voltagent-official-skills",
             "Официальные скиллы: Anthropic, Google, Vercel, Stripe, Supabase, Trail of Bits"),
            # ok-skills — 55 отборных скиллов
            ("https://github.com/mxyhi/ok-skills",
             "ok-skills-55",
             "55 отборных скиллов: docs lookup, browser, GitHub, planning, design, PDF"),
        ]
    },
    "official": {
        "title": "🏢  Официальные скиллы от вендоров",
        "repos": [
            # Vercel Labs agent-skills
            ("https://github.com/vercel-labs/agent-skills",
             "vercel-official",
             "Vercel Labs: React best practices, Web Design Guidelines"),
            # Anthropic official skills (docx, pdf, pptx, xlsx, etc.)
            ("https://github.com/anthropics/skills",
             "anthropic-official",
             "Официальные скиллы Anthropic: docx, pdf, pptx, xlsx, brand, canvas-design"),
        ]
    },
    "writing": {
        "title": "✍️  Письмо и контент",
        "repos": [
            # humanizer — 2.9k stars, убирает AI-паттерны из текста
            ("https://github.com/blader/humanizer",
             "humanizer",
             "humanizer: убирает AI-признаки из текста, 2.9k ⭐"),
        ]
    },
}

# ─── NPX-скиллы ───────────────────────────────────────────────────────────────
NPX_SKILLS = [
    (["npx", "get-shit-done-cc", "--claude", "--global"],
     "GSD (get-shit-done) глобально в ~/.claude/"),
    (["npx", "antigravity-awesome-skills", "--claude"],
     "Antigravity 1340+ скиллов через CLI (альтернативный способ)"),
]

# ─── Утилиты ──────────────────────────────────────────────────────────────────
def run(cmd, cwd=None):
    try:
        r = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, timeout=180)
        return r.returncode == 0
    except Exception:
        return False

def find_npx():
    for c in ["npx", "npx.cmd"]:
        try:
            if subprocess.run([c, "--version"], capture_output=True, timeout=5).returncode == 0:
                return c
        except Exception:
            pass
    return None

def clone_or_pull(url, target):
    git_dir = target / ".git"
    name = target.name
    if git_dir.exists():
        inf(f"Обновляем: {name}")
        return run(["git", "-C", str(target), "pull", "--quiet"])
    else:
        inf(f"Клонируем: {name}")
        return run(["git", "clone", "--depth", "1", "--quiet", url, str(target)])

# ─── Основная логика ──────────────────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(description="Claude Code Skills Installer")
    parser.add_argument("--update", action="store_true", help="Обновить уже установленное")
    parser.add_argument("--list",   action="store_true", help="Показать список без установки")
    parser.add_argument("--cat",    type=str, default=None,
                        help=f"Установить только категорию: {', '.join(SKILLS.keys())}")
    args = parser.parse_args()

    print(f"\n{C['B']}{C['g']}Claude Code Skills Installer{C['R']}")
    print(f"{C['y']}Самый полный инсталлятор скиллов для Claude Code{C['R']}\n")

    if args.list:
        for cat, data in SKILLS.items():
            h(data["title"])
            for url, folder, desc in data["repos"]:
                print(f"  {C['b']}{folder}{C['R']}")
                print(f"    {desc}")
                print(f"    {C['y']}{url}{C['R']}")
        return

    # Проверка зависимостей
    h("Проверка зависимостей")
    if not run(["git", "--version"]):
        er("git не найден. Установи: https://git-scm.com"); sys.exit(1)
    ok("git найден")

    npx = find_npx()
    if npx: ok(f"npx найден: {npx}")
    else:   er("npx не найден — npm-скиллы будут пропущены")

    skills_dir = Path.home() / ".claude" / "skills"
    skills_dir.mkdir(parents=True, exist_ok=True)
    ok(f"Папка скиллов: {skills_dir}")

    # Выбор категорий
    cats = {args.cat: SKILLS[args.cat]} if args.cat and args.cat in SKILLS else SKILLS

    success = fail = 0

    for cat_key, data in cats.items():
        h(data["title"])
        for url, folder, desc in data["repos"]:
            target = skills_dir / folder
            if clone_or_pull(url, target):
                ok(folder)
                success += 1
            else:
                er(f"{folder} — не удалось")
                fail += 1

    # npx установка
    if npx:
        h("📦  npx-установка")
        for cmd, label in NPX_SKILLS:
            cmd[0] = npx
            inf(f"Устанавливаем: {label}")
            if run(cmd):
                ok(label)
            else:
                er(f"Не удалось: {label}")

    # Итог
    h("✅  Итог")
    installed = len(list(skills_dir.iterdir()))
    print(f"  {C['g']}Успешно: {success}{C['R']}  |  {C['r']}Ошибок: {fail}{C['R']}  |  {C['b']}Папок в ~/.claude/skills: {installed}{C['R']}")

    print(f"""
{C['B']}Следующий шаг — открой Claude Code и выполни:{C['R']}

  {C['y']}# Superpowers (TDD, brainstorm, plan, execute){C['R']}
  {C['y']}/plugin marketplace add obra/superpowers-marketplace{C['R']}
  {C['y']}/plugin install superpowers@superpowers-marketplace{C['R']}

  {C['y']}# claude-mem (долгосрочная память){C['R']}
  {C['y']}/plugin marketplace add thedotmack/claude-mem{C['R']}
  {C['y']}/plugin install claude-mem{C['R']}

  {C['y']}# Supabase{C['R']}
  {C['y']}/plugin marketplace add supabase/agent-skills{C['R']}
  {C['y']}/plugin install postgres-best-practices@supabase-agent-skills{C['R']}

  {C['y']}# n8n{C['R']}
  {C['y']}/plugin marketplace add czlonkowski/n8n-skills{C['R']}
  {C['y']}/plugin install n8n-mcp-skills@czlonkowski/n8n-skills{C['R']}

  {C['y']}# Obsidian{C['R']}
  {C['y']}/plugin marketplace add kepano/obsidian-skills{C['R']}
  {C['y']}/plugin install obsidian@obsidian-skills{C['R']}

  {C['y']}/reload-plugins{C['R']}

{C['B']}{C['g']}Готово! Спроси Claude: 'What skills do you have available?'{C['R']}
""")

if __name__ == "__main__":
    main()
