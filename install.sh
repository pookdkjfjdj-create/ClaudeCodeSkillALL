#!/usr/bin/env bash
# ============================================================
#  Claude Code Skills Installer — macOS / Linux
#  https://github.com/YOUR_USERNAME/claude-skills-installer
# ============================================================

set -euo pipefail

GREEN="\033[92m"; RED="\033[91m"; YELLOW="\033[93m"
BLUE="\033[94m";  BOLD="\033[1m"; RESET="\033[0m"

SKILLS_DIR="${HOME}/.claude/skills"
SUCCESS=0; FAIL=0

header()  { echo -e "\n${BOLD}${BLUE}══════════════════════════════════════════════════════════${RESET}"; echo -e "${BOLD}${BLUE}  $1${RESET}"; echo -e "${BOLD}${BLUE}══════════════════════════════════════════════════════════${RESET}\n"; }
ok()      { echo -e "${GREEN}  ✓ $1${RESET}"; }
err()     { echo -e "${RED}  ✗ $1${RESET}"; }
info()    { echo -e "${YELLOW}  → $1${RESET}"; }

clone_or_pull() {
  local url="$1" dir="$2"
  if [ -d "$dir/.git" ]; then
    info "Обновляем: $(basename "$dir")"
    git -C "$dir" pull --quiet 2>/dev/null && { ok "$(basename "$dir")"; ((SUCCESS++)); } || { err "$(basename "$dir")"; ((FAIL++)); }
  else
    info "Клонируем: $(basename "$url" .git)"
    git clone --depth 1 --quiet "$url" "$dir" 2>/dev/null && { ok "$(basename "$dir")"; ((SUCCESS++)); } || { err "$(basename "$dir")"; ((FAIL++)); }
  fi
}

# ── Проверка зависимостей ──────────────────────────────────
header "Проверка зависимостей"
command -v git  >/dev/null 2>&1 && ok "git найден"  || { err "git не найден. Установи: https://git-scm.com"; exit 1; }
command -v npx  >/dev/null 2>&1 && ok "npx найден"  || { err "npx не найден — npm-скиллы будут пропущены"; NPX_MISSING=1; }
command -v python3 >/dev/null 2>&1 && ok "python3 найден" || true

mkdir -p "$SKILLS_DIR"
ok "Папка скиллов: $SKILLS_DIR"

# ══════════════════════════════════════════════════════════════
#  СКИЛЛЫ — ПОЛНЫЙ СПИСОК
# ══════════════════════════════════════════════════════════════

header "🧠  Память и контекст сессий"
clone_or_pull "https://github.com/thedotmack/claude-mem"               "$SKILLS_DIR/claude-mem"
clone_or_pull "https://github.com/affaan-m/everything-claude-code"     "$SKILLS_DIR/everything-claude-code"
clone_or_pull "https://github.com/netresearch/context7-skill"          "$SKILLS_DIR/context7-skill"
clone_or_pull "https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering" "$SKILLS_DIR/context-engineering"

header "⚡  Продуктивность и workflow"
clone_or_pull "https://github.com/obra/superpowers"                    "$SKILLS_DIR/superpowers"
clone_or_pull "https://github.com/gsd-build/get-shit-done"             "$SKILLS_DIR/get-shit-done"
clone_or_pull "https://github.com/NeoLabHQ/context-engineering-kit"   "$SKILLS_DIR/context-engineering-kit"
clone_or_pull "https://github.com/FlorianBruniaux/claude-code-ultimate-guide" "$SKILLS_DIR/claude-code-templates"
clone_or_pull "https://github.com/levnikolaevich/claude-code-skills"  "$SKILLS_DIR/levnikolaevich-skills"

header "🔐  Безопасность"
clone_or_pull "https://github.com/trailofbits/skills"                  "$SKILLS_DIR/trailofbits-security"
clone_or_pull "https://github.com/BehiSecc/awesome-claude-skills"      "$SKILLS_DIR/vibesec-and-more"  # включает VibeSec

header "🌐  Браузер и веб-автоматизация"
clone_or_pull "https://github.com/SawyerHood/dev-browser"              "$SKILLS_DIR/dev-browser"
clone_or_pull "https://github.com/vercel-labs/agent-browser"           "$SKILLS_DIR/agent-browser"
clone_or_pull "https://github.com/ZenoWangzy/agent-browser-claude-plugin" "$SKILLS_DIR/agent-browser-plugin"

header "🗄️  Базы данных"
clone_or_pull "https://github.com/supabase/agent-skills"               "$SKILLS_DIR/supabase-skills"

header "🔄  n8n автоматизация"
clone_or_pull "https://github.com/czlonkowski/n8n-skills"              "$SKILLS_DIR/n8n-skills"

header "📓  Obsidian"
clone_or_pull "https://github.com/kepano/obsidian-skills"              "$SKILLS_DIR/obsidian-skills"
clone_or_pull "https://github.com/pablo-mano/Obsidian-CLI-skill"       "$SKILLS_DIR/obsidian-cli-skill"

header "🔬  AI-исследования и Deep Research"
clone_or_pull "https://github.com/Orchestra-Research/AI-Research-SKILLs" "$SKILLS_DIR/ai-research-skills"

header "📋  Kanban и управление проектами"
clone_or_pull "https://github.com/BloopAI/vibe-kanban"                 "$SKILLS_DIR/vibe-kanban"

header "🎨  UI/UX и дизайн"
clone_or_pull "https://github.com/nextlevelbuilder/ui-ux-pro-max-skill" "$SKILLS_DIR/ui-ux-pro-max"
clone_or_pull "https://github.com/gregsabia/gsap-skills"               "$SKILLS_DIR/gsap-skills"          2>/dev/null || clone_or_pull "https://github.com/remotion-dev/skills" "$SKILLS_DIR/remotion-skills"

header "📦  Мега-паки (сотни скиллов)"
clone_or_pull "https://github.com/alirezarezvani/claude-skills"        "$SKILLS_DIR/alirezarezvani-220plus"
clone_or_pull "https://github.com/sickn33/antigravity-awesome-skills"  "$SKILLS_DIR/antigravity-1300plus"
clone_or_pull "https://github.com/VoltAgent/awesome-agent-skills"      "$SKILLS_DIR/voltagent-official-skills"
clone_or_pull "https://github.com/mxyhi/ok-skills"                     "$SKILLS_DIR/ok-skills-55"

header "🏢  Официальные скиллы от вендоров"
clone_or_pull "https://github.com/vercel-labs/agent-skills"            "$SKILLS_DIR/vercel-official"
clone_or_pull "https://github.com/stripe/agent-toolkit"                "$SKILLS_DIR/stripe-skills"        2>/dev/null || true
clone_or_pull "https://github.com/cloudflare/agents"                   "$SKILLS_DIR/cloudflare-skills"    2>/dev/null || true

header "✍️  Письмо и контент"
clone_or_pull "https://github.com/blader/humanizer"                    "$SKILLS_DIR/humanizer"

# ── npx-установка GSD глобально ───────────────────────────
header "📦  npx-установка"
if [ -z "${NPX_MISSING:-}" ]; then
  info "Устанавливаем GSD глобально через npx..."
  npx get-shit-done-cc --claude --global 2>/dev/null && ok "GSD установлен глобально" || err "GSD не удалось установить"
else
  err "npx недоступен — GSD пропущен"
fi

# ── Итог ──────────────────────────────────────────────────
header "✅  Итог"
INSTALLED=$(find "$SKILLS_DIR" -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' ')
echo -e "  ${GREEN}Успешно: $SUCCESS${RESET}  |  ${RED}Ошибок: $FAIL${RESET}  |  ${BLUE}Папок в ~/.claude/skills: $INSTALLED${RESET}"

echo ""
echo -e "${BOLD}Следующий шаг — открой Claude Code и выполни:${RESET}"
echo ""
echo -e "  ${YELLOW}# Superpowers${RESET}"
echo -e "  ${YELLOW}/plugin marketplace add obra/superpowers-marketplace${RESET}"
echo -e "  ${YELLOW}/plugin install superpowers@superpowers-marketplace${RESET}"
echo ""
echo -e "  ${YELLOW}# claude-mem (долгосрочная память)${RESET}"
echo -e "  ${YELLOW}/plugin marketplace add thedotmack/claude-mem${RESET}"
echo -e "  ${YELLOW}/plugin install claude-mem${RESET}"
echo ""
echo -e "  ${YELLOW}# Supabase${RESET}"
echo -e "  ${YELLOW}/plugin marketplace add supabase/agent-skills${RESET}"
echo -e "  ${YELLOW}/plugin install postgres-best-practices@supabase-agent-skills${RESET}"
echo ""
echo -e "  ${YELLOW}# n8n${RESET}"
echo -e "  ${YELLOW}/plugin marketplace add czlonkowski/n8n-skills${RESET}"
echo -e "  ${YELLOW}/plugin install n8n-mcp-skills@czlonkowski/n8n-skills${RESET}"
echo ""
echo -e "  ${YELLOW}# Obsidian${RESET}"
echo -e "  ${YELLOW}/plugin marketplace add kepano/obsidian-skills${RESET}"
echo -e "  ${YELLOW}/plugin install obsidian@obsidian-skills${RESET}"
echo ""
echo -e "  ${YELLOW}/reload-plugins${RESET}"
echo ""
echo -e "${BOLD}${GREEN}Готово! Спроси Claude: 'What skills do you have available?'${RESET}\n"
