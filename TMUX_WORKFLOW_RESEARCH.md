# Tmux Workflow Research

Research into tmux plugins, extensions, alternatives, and patterns relevant to a
window-centric, tmuxp-driven workflow.

## Current Setup Summary

- Prefix: `C-a`, base-index 1, mouse on, 50k history
- Plugins: tpm, tmux-sensible, tmux-pomodoro-plus, tmux-dark-notify
- Session manager: tmuxp (YAML configs per project)
- Workflow: multiple sessions (one per project), each with named windows (nvim, claude, shell, lazygit, etc.)
- Rarely uses splits; prefers windows
- Uses number keys (`prefix + 1-9`) for window switching

---

## The Parallel Claude Problem

The core challenge: running multiple Claude Code processes in one tmux session
without burning through window number slots (1-9).

### Option A: Nested/Grouped Sessions

tmux supports **session groups** — multiple sessions sharing the same window
group. You could have a dedicated "claude" session with its own windows (one per
Claude process), independent of your project session's window numbering:

```bash
# In your tmuxp yaml, launch a separate session for claudes:
tmux new-session -s claude-dotfiles -d
tmux new-window -t claude-dotfiles -n "claude-1"
tmux new-window -t claude-dotfiles -n "claude-2"
tmux new-window -t claude-dotfiles -n "claude-3"
```

Switch to this session with `C-a s` (choose-tree) or a fuzzy switcher (see
below). Your project session keeps its clean 1-9 window numbering.

### Option B: Use Claude Code's Built-in Agent Teams

Claude Code has an official **Agent Teams** feature that spawns teammate
processes in tmux panes automatically. A lead agent coordinates multiple
sub-agents, each getting its own pane. This is the path of least resistance if
you want parallel Claude instances collaborating on a task.

- Docs: https://code.claude.com/docs/en/agent-teams
- Configure `teammateMode: "tmux"` in settings.json for split-pane display

### Option C: CCB (Claude Code Bridge)

[CCB](https://github.com/bfly123/claude_code_bridge) orchestrates multiple AI
CLIs (Claude, Gemini, Codex) in tmux panes with cross-agent interaction. More
relevant if you want to mix models.

### Option D: Claude Agent Farm

[claude_code_agent_farm](https://github.com/Dicklesworthstone/claude_code_agent_farm)
is a framework for running 20+ Claude Code agents in parallel with lock-based
coordination and a real-time tmux monitoring dashboard. Overkill for casual use,
but interesting for batch operations.

### Recommendation

**Option A (separate session)** fits your workflow best — it keeps your project
windows clean and lets you manage Claude processes with their own 1-9 numbering.
Pair it with a fuzzy session/window switcher (see below) for fast navigation.

---

## Plugins Worth Adding

### Navigation (high value for many-window workflows)

**[tmux-fzf](https://github.com/sainnhe/tmux-fzf)** — `prefix + F` opens fzf
to fuzzy-find sessions, windows, panes, commands, keybindings. Supports popup
mode. This is the single highest-value addition for a workflow with many windows
across many sessions.

**[sessionx](https://github.com/omerxx/tmux-sessionx)** (1.2k stars) — Session
manager with previews and fuzzy finding. More opinionated than tmux-fzf but
excellent for session-heavy workflows.

**[harpoon](https://github.com/Rickards/tmux-harpoon)** — Bookmark
sessions/windows and jump between them instantly (inspired by
ThePrimeagen/harpoon for neovim). Good if you have a small set of
frequently-visited windows.

**[tmux-which-key](https://github.com/alexwforsythe/tmux-which-key)** —
Customizable popup menu triggered by a key. Useful for discoverable access to
less-frequent commands without memorizing bindings.

### Persistence

**[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)** (12.4k
stars) — Saves and restores tmux environment across system restarts. Since you
use tmuxp for session setup this is less critical, but it preserves running
processes and pane contents that tmuxp can't.

**[tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)** —
Continuous auto-saving on top of resurrect. Auto-restores on tmux start.

### Quality of Life

**[extrakto](https://github.com/laktak/extrakto)** — Select and copy text from
tmux scrollback via fzf fuzzy matching. Useful for grabbing URLs, paths, hashes
from output without reaching for the mouse.

**[tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url)** — Quickly open any
URL visible in your terminal via fzf.

**[tmux-autoreload](https://github.com/b0o/tmux-autoreload)** — Auto-reloads
tmux.conf on file change. Eliminates the `prefix + r` step during config
iteration.

### Skippable for Your Workflow

- **tmux-pain-control / tmux-tilit / tmux-pane-focus** — Pane management plugins; not useful since you don't use splits.
- **tmux-sidebar / treemux** — Directory tree in a sidebar pane; you use nvim for this.
- **tmux-battery / tmux-cpu** — Status bar bling; you already have a clean status bar.

---

## Session Manager Alternatives to tmuxp

You're already on tmuxp, which is the most capable option. For awareness:

| Tool | Language | Notes |
|------|----------|-------|
| **tmuxp** | Python | Your current tool. Session freezing, YAML/JSON, most features. |
| **smug** | Go | Simpler than tmuxp, similar YAML config. Single binary, no Python dep. |
| **tmuxinator** | Ruby | The original. Similar to tmuxp but requires Ruby. |
| **tmuxifier** | Shell | Pure shell scripts instead of YAML. Total control, more verbose. |
| **laio** | Rust | Flexbox-inspired layout manager. Newer, less mature. |

Unless you hit specific pain points with tmuxp, there's no strong reason to
switch.

---

## Terminal Multiplexer Alternatives

### Zellij

[Zellij](https://zellij.dev/) is a Rust-based terminal multiplexer with:

- Built-in session management (no separate tool needed)
- Plugin system via WebAssembly
- Floating and stacked panes
- Discoverable keybindings shown at screen bottom
- Tab/pane navigation via `Alt + h/j/k/l`

**Trade-offs vs tmux:** Zellij's plugin ecosystem is small compared to tmux/tpm.
No equivalent to tmuxp's project-based session configs. Better out-of-box UX,
but less customizable. Your existing tmux muscle memory and config investment
make switching costly for marginal gain.

### WezTerm

[WezTerm](https://wezfurlong.org/wezterm/) is a GPU-accelerated terminal
emulator with built-in multiplexing:

- Tabs, panes, workspaces built into the terminal itself
- Configured via Lua with hot-reloading
- No separate multiplexer needed

**Trade-offs:** Ties you to one terminal emulator. Loses tmux's
terminal-agnostic portability and remote session persistence.

### Verdict

Neither alternative offers a compelling reason to migrate given your investment
in tmux + tmuxp. Zellij is worth watching if you ever start fresh on a new
setup.

---

## Suggested Quick Wins

1. **Add tmux-fzf** — Fuzzy window/session switching replaces the need for
   memorizing window numbers across many sessions:
   ```
   set -g @plugin 'sainnhe/tmux-fzf'
   ```

2. **Add tmux-resurrect** — Safety net for when your machine reboots
   unexpectedly:
   ```
   set -g @plugin 'tmux-plugins/tmux-resurrect'
   ```

3. **Create a dedicated Claude session** in tmuxp for parallel Claude processes,
   keeping your project window numbering clean.

4. **Add a fzf session switcher binding** for fast jumping between your project
   session and Claude session:
   ```bash
   bind C-j display-popup -E "tmux list-sessions | sed -E 's/:.*$//' | \
     grep -v \"^$(tmux display-message -p '#S')\$\" | \
     fzf --reverse | xargs tmux switch-client -t"
   ```

---

## Sources

- [awesome-tmux](https://github.com/rothgar/awesome-tmux)
- [tmux-plugins/list](https://github.com/tmux-plugins/list)
- [tmuxai.dev/tmux-plugins](https://tmuxai.dev/tmux-plugins/)
- [Zellij vs Tmux comparison](https://typecraft.dev/tutorial/zellij-vs-tmux)
- [Claude Code Agent Teams docs](https://code.claude.com/docs/en/agent-teams)
- [tmux-fzf](https://github.com/sainnhe/tmux-fzf)
- [Waylon Walker's tmux nav](https://waylonwalker.com/tmux-nav-2021/)
