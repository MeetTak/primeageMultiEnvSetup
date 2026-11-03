#>>> stopping brew install time cleanup
export HOMEBREW_NO_INSTALL_CLEANUP=1

#>>> Colors
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

#>>> setopt config
unsetopt nomatch
setopt autocd
setopt sharehistory
setopt incappendhistory
setopt interactivecomments

#>>> Enable plugins.
#plugins=(git brew history kubectl zsh-history-substring-search)
# plugins=(git brew history kubectl)

# Bash-style time output.
# export TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

#>>> Allow history search via up/down key
#source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
#bindkey "^[[A" history-substring-search-up
#bindkey "^[[B" history-substring-search-downs

#>>> tell homebrew to not update automatically every time i run it(just once a week)
export HOMEBREW_AUTO_UPDATE_SECS=604800

#>>> Case insensitive.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

#>>> zoxide(brew formulae) config
eval "$(zoxide init zsh)"

#>>> VSCode shell configuration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

#starship config
eval "$(starship init zsh)"

#>>> most as the default pager for man
#export MANPAGER="most"

#>>> Function to compile, run, and clean up C programs
runC() {
    gcc-14 "$1" -o /temp/a.out && /temp/a.out
}

#>>> GitHub Copilot aliases for Zsh
#eval "$(gh copilot alias -- zsh)"

#>>> fzf setup for fast file navigation
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="find ~+ -type f"
# fzf file picker stays on its default Ctrl-T; Ctrl-F is tmux-sessionizer (below)
fzf_cd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
fzf_rg() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q}" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
}

#>>> docker completions
FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit

#>>> SDKMAN (lazy): installed candidates (java, gradle, ...) go on PATH now;
# sdkman-init.sh is only sourced the first time `sdk` is run.
export SDKMAN_DIR="$HOME/.sdkman"
if [[ -d "$SDKMAN_DIR/candidates" ]]; then
  for _sdk_bin in "$SDKMAN_DIR"/candidates/*/current/bin(N); do
    path=("$_sdk_bin" ${path:#$_sdk_bin})
  done
  unset _sdk_bin
  [[ -d "$SDKMAN_DIR/candidates/java/current" ]] && export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
  sdk() {
    unset -f sdk
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk "$@"
  }
fi

# add_to_path() {
#   [[ ":$PATH:" != *":$1:"* ]] && export PATH="$1:$PATH"
# }

# add_to_path "$HOME/.local/bin"
# add_to_path "$HOME/.local/pipx/bin"
export DEV_ENV_ROOT="$HOME/.personal"
export DEV_ENV_MODE="dev"

# Load secrets (API keys, tokens, etc.)
[[ -f ~/.secrets ]] && source ~/.secrets

#>>> nix shell
# add_to_path "/run/current-system/sw/bin"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# primeagen config
# autoload -Uz vcs_info

# precmd() { vcs_info }

# zstyle ':vcs_info:git:*' formats ' git:(%b)'

# setopt PROMPT_SUBST

# PROMPT='%F{39}%1~%f${vcs_info_msg_0_} %(?.%F{46}.%F{196})✗%f
# %F{46}➜%f '

#>>> tmux-sessionizer (Ctrl-F picks a project; Alt-h/t/n/s run TS_SESSION_COMMANDS)
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s '\eh' "tmux-sessionizer -s 0\n"
bindkey -s '\et' "tmux-sessionizer -s 1\n"
bindkey -s '\en' "tmux-sessionizer -s 2\n"
bindkey -s '\es' "tmux-sessionizer -s 3\n"
