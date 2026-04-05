# ============================================================
#  Claude Code Skills Installer — Windows (PowerShell)
#  https://github.com/YOUR_USERNAME/claude-skills-installer
#
#  Запуск (в PowerShell от обычного пользователя):
#    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
#    .\install.ps1
# ============================================================

$ErrorActionPreference = "Continue"

# Цвета
function Write-Header($text) {
    Write-Host "`n══════════════════════════════════════════════════════════" -ForegroundColor Blue
    Write-Host "  $text" -ForegroundColor Blue
    Write-Host "══════════════════════════════════════════════════════════`n" -ForegroundColor Blue
}
function Write-Ok($text)   { Write-Host "  ✓ $text" -ForegroundColor Green }
function Write-Err($text)  { Write-Host "  ✗ $text" -ForegroundColor Red }
function Write-Info($text) { Write-Host "  → $text" -ForegroundColor Yellow }

$SkillsDir = "$env:USERPROFILE\.claude\skills"
$Success = 0
$Fail = 0

function Clone-OrPull($url, $dir) {
    $name = Split-Path $dir -Leaf
    if (Test-Path "$dir\.git") {
        Write-Info "Обновляем: $name"
        $result = git -C $dir pull --quiet 2>&1
        if ($LASTEXITCODE -eq 0) { Write-Ok $name; $script:Success++ }
        else                     { Write-Err $name; $script:Fail++ }
    } else {
        Write-Info "Клонируем: $name"
        $result = git clone --depth 1 --quiet $url $dir 2>&1
        if ($LASTEXITCODE -eq 0) { Write-Ok $name; $script:Success++ }
        else                     { Write-Err "$name (возможно уже существует или недоступен)"; $script:Fail++ }
    }
}

# ── Проверка зависимостей ─────────────────────────────────
Write-Header "Проверка зависимостей"
$gitOk  = $null -ne (Get-Command git  -ErrorAction SilentlyContinue)
$npxOk  = $null -ne (Get-Command npx  -ErrorAction SilentlyContinue)

if ($gitOk)  { Write-Ok  "git найден" }
else         { Write-Err "git не найден. Установи: https://git-scm.com"; exit 1 }

if ($npxOk)  { Write-Ok  "npx найден" }
else         { Write-Err "npx не найден — npm-скиллы будут пропущены" }

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
Write-Ok "Папка скиллов: $SkillsDir"

# ══════════════════════════════════════════════════════════════
Write-Header "🧠  Память и контекст сессий"
Clone-OrPull "https://github.com/thedotmack/claude-mem"               "$SkillsDir\claude-mem"
Clone-OrPull "https://github.com/affaan-m/everything-claude-code"     "$SkillsDir\everything-claude-code"
Clone-OrPull "https://github.com/netresearch/context7-skill"          "$SkillsDir\context7-skill"
Clone-OrPull "https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering" "$SkillsDir\context-engineering"

Write-Header "⚡  Продуктивность и workflow"
Clone-OrPull "https://github.com/obra/superpowers"                    "$SkillsDir\superpowers"
Clone-OrPull "https://github.com/gsd-build/get-shit-done"             "$SkillsDir\get-shit-done"
Clone-OrPull "https://github.com/NeoLabHQ/context-engineering-kit"   "$SkillsDir\context-engineering-kit"
Clone-OrPull "https://github.com/FlorianBruniaux/claude-code-ultimate-guide" "$SkillsDir\claude-code-templates"
Clone-OrPull "https://github.com/levnikolaevich/claude-code-skills"  "$SkillsDir\levnikolaevich-skills"

Write-Header "🔐  Безопасность"
Clone-OrPull "https://github.com/trailofbits/skills"                  "$SkillsDir\trailofbits-security"
Clone-OrPull "https://github.com/BehiSecc/awesome-claude-skills"      "$SkillsDir\vibesec-and-more"

Write-Header "🌐  Браузер и веб-автоматизация"
Clone-OrPull "https://github.com/SawyerHood/dev-browser"              "$SkillsDir\dev-browser"
Clone-OrPull "https://github.com/vercel-labs/agent-browser"           "$SkillsDir\agent-browser"
Clone-OrPull "https://github.com/ZenoWangzy/agent-browser-claude-plugin" "$SkillsDir\agent-browser-plugin"

Write-Header "🗄️  Базы данных"
Clone-OrPull "https://github.com/supabase/agent-skills"               "$SkillsDir\supabase-skills"

Write-Header "🔄  n8n автоматизация"
Clone-OrPull "https://github.com/czlonkowski/n8n-skills"              "$SkillsDir\n8n-skills"

Write-Header "📓  Obsidian"
Clone-OrPull "https://github.com/kepano/obsidian-skills"              "$SkillsDir\obsidian-skills"
Clone-OrPull "https://github.com/pablo-mano/Obsidian-CLI-skill"       "$SkillsDir\obsidian-cli-skill"

Write-Header "🔬  AI-исследования и Deep Research"
Clone-OrPull "https://github.com/Orchestra-Research/AI-Research-SKILLs" "$SkillsDir\ai-research-skills"

Write-Header "📋  Kanban и управление проектами"
Clone-OrPull "https://github.com/BloopAI/vibe-kanban"                 "$SkillsDir\vibe-kanban"

Write-Header "🎨  UI/UX и дизайн"
Clone-OrPull "https://github.com/nextlevelbuilder/ui-ux-pro-max-skill" "$SkillsDir\ui-ux-pro-max"

Write-Header "📦  Мега-паки (сотни скиллов)"
Clone-OrPull "https://github.com/alirezarezvani/claude-skills"        "$SkillsDir\alirezarezvani-220plus"
Clone-OrPull "https://github.com/sickn33/antigravity-awesome-skills"  "$SkillsDir\antigravity-1300plus"
Clone-OrPull "https://github.com/VoltAgent/awesome-agent-skills"      "$SkillsDir\voltagent-official-skills"
Clone-OrPull "https://github.com/mxyhi/ok-skills"                     "$SkillsDir\ok-skills-55"

Write-Header "🏢  Официальные скиллы от вендоров"
Clone-OrPull "https://github.com/vercel-labs/agent-skills"            "$SkillsDir\vercel-official"

Write-Header "✍️  Письмо и контент"
Clone-OrPull "https://github.com/blader/humanizer"                    "$SkillsDir\humanizer"

# ── npx GSD ──────────────────────────────────────────────
Write-Header "📦  npx-установка"
if ($npxOk) {
    Write-Info "Устанавливаем GSD глобально..."
    npx get-shit-done-cc --claude --global 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) { Write-Ok "GSD установлен глобально" }
    else                     { Write-Err "GSD не удалось установить" }
} else {
    Write-Err "npx недоступен — GSD пропущен"
}

# ── Итог ─────────────────────────────────────────────────
Write-Header "✅  Итог"
$Installed = (Get-ChildItem -Path $SkillsDir -Directory).Count
Write-Host "  Успешно: $Success  |  Ошибок: $Fail  |  Папок в ~/.claude/skills: $Installed" -ForegroundColor Cyan

Write-Host ""
Write-Host "Следующий шаг — открой Claude Code и выполни:" -ForegroundColor White
Write-Host ""
Write-Host "  /plugin marketplace add obra/superpowers-marketplace" -ForegroundColor Yellow
Write-Host "  /plugin install superpowers@superpowers-marketplace"  -ForegroundColor Yellow
Write-Host "  /plugin marketplace add thedotmack/claude-mem"        -ForegroundColor Yellow
Write-Host "  /plugin install claude-mem"                            -ForegroundColor Yellow
Write-Host "  /plugin marketplace add supabase/agent-skills"        -ForegroundColor Yellow
Write-Host "  /plugin install postgres-best-practices@supabase-agent-skills" -ForegroundColor Yellow
Write-Host "  /plugin marketplace add czlonkowski/n8n-skills"       -ForegroundColor Yellow
Write-Host "  /plugin install n8n-mcp-skills@czlonkowski/n8n-skills" -ForegroundColor Yellow
Write-Host "  /plugin marketplace add kepano/obsidian-skills"       -ForegroundColor Yellow
Write-Host "  /plugin install obsidian@obsidian-skills"             -ForegroundColor Yellow
Write-Host "  /reload-plugins"                                       -ForegroundColor Yellow
Write-Host ""
Write-Host "Готово! Спроси Claude: 'What skills do you have available?'" -ForegroundColor Green
