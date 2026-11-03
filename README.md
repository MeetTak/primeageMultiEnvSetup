# .personal

My macOS dotfiles and machine setup, modelled on ThePrimeagen's
[dev](https://github.com/ThePrimeagen/dev), [init.lua](https://github.com/ThePrimeagen/init.lua) and
[tmux-sessionizer](https://github.com/ThePrimeagen/tmux-sessionizer).

**📖 Docs website: [meettak.github.io/primeageMultiEnvSetup](https://meettak.github.io/primeageMultiEnvSetup/)**: search, sidebar, dark mode.
Same content on GitHub: [`docs/GUIDE.md`](docs/GUIDE.md) (architecture, specs, design decisions, every command and keymap, recipes, troubleshooting).

## Features

- **Two profiles:** a minimal *personal* shell and a full *dev* toolchain. Switch with `dev-on` / `dev-off`.
- **Safe installer:** `dev-apply` copies the repo into `$HOME`, moving everything it replaces into a timestamped backup. `--dry` previews it, and `dev-pull` brings live edits back.
- **New Mac in minutes:** `./run` executes idempotent installers (`runs/`) and the `Brewfile`.
- **`Ctrl-F` project jumping** from zsh, tmux or Neovim (tmux-sessionizer). Projects open with their servers and tests already running, and `Alt-h` / `Alt-t` open Claude / lazygit per project.
- **Neovim in lua:** lazy.nvim, telescope, harpoon2, treesitter, LSP via Mason (nvim 0.12 APIs), conform, undotree, fugitive.
- **Keyboard-driven macOS:** yabai + skhd tiling, Karabiner (Caps Lock = Hyper), Ghostty.
- **Fast shell:** about 0.09 s startup, with nvm, conda and sdkman lazy-loaded.
- **Public-repo safe:** no secrets or identity in the repo (`~/.secrets` and `~/.gitconfig.local` stay local), and a test checks it.
- **Tested:** `tests/run` checks the scripts against a repo copy and a fake `$HOME`.
- **Self-publishing docs:** a GitHub Action builds the guide with MkDocs Material and deploys it to GitHub Pages on every push.

## Quick start

```bash
git clone https://github.com/MeetTak/primeageMultiEnvSetup.git ~/.personal
cd ~/.personal
./init && ./run brew && ./run git
DEV_ENV_MODE=dev ./dev-apply --dry && DEV_ENV_MODE=dev ./dev-apply && exec zsh
./run tmux && ./run neovim && ./run projects
```

Details and the remaining installers: [Guide §1](docs/GUIDE.md#1-quick-start-new-mac).

## Everyday commands

| Command | What it does |
|---|---|
| `dev-apply [--dry]` | Apply the current profile to `$HOME` (with backups) |
| `dev-on` / `dev-off` / `dev-status` | Switch to dev / switch to personal / show the profile |
| `dev-pull [--dry]` | Copy live edits back into the repo |
| `dev-commit` | Commit and push the repo |
| `./run [filter] [--dry]` | Run installers: `brew` `git` `tmux` `neovim` `node` `docker` `hammerspoon` `macos` `projects` |
| `tests/run [filter]` | Run the test suite |
| `Ctrl-F` | Fuzzy-jump to a project's tmux session |

## Layout

```
common/      shared configs: nvim, tmux, sessionizer, skhd, yabai, karabiner, ghostty, lazygit, git, starship
env/         personal profile overlay
dev/env/     dev profile overlay
runs/        idempotent installers          projects/   per-project tmux session setups
tests/       test suite                     docs/       the guide + docs-site pages (mkdocs.yml)
```

The architecture diagram and the "how it works" sections are in [the guide](docs/GUIDE.md#2-the-mental-model).

---

*Inspired by [ThePrimeagen/dev](https://github.com/ThePrimeagen/dev). The `tmux-sessionizer/` submodule is his script, unchanged.*
