# ---------- helpers ----------
add_to_path() {
  [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
}

add_to_path "$HOME/.local/bin"
export DEV_ENV_ROOT="$HOME/.personal"
export DEV_ENV_MODE="personal"

# Load secrets (API keys, tokens, etc.)
[[ -f ~/.secrets ]] && source ~/.secrets

#>>> nix shell
add_to_path "/run/current-system/sw/bin"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

#>>> zoxide(brew formulae) config
eval "$(zoxide init zsh)"

#>>> setopt config
unsetopt nomatch
setopt autocd
setopt sharehistory
setopt incappendhistory
setopt interactivecomments

#>>> tmux-sessionizer (Ctrl-F picks a project; Alt-h/t/n/s run TS_SESSION_COMMANDS)
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"
