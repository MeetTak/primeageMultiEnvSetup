export XDG_CONFIG_HOME=$HOME/.config

DEV=$XDG_CONFIG_HOME/personal/dev
if [[ -d "$DEV" ]]; then
  for i in $(find -L "$DEV" -type f 2>/dev/null); do
      source "$i"
  done
fi

# all that sweet sweet fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export DEV_ENV_MODE="dev"

catr() {
    tail -n "+$1" $3 | head -n "$(($2 - $1 + 1))"
}

cat1Line() {
    cat $1 | tr -d "\n"
}

addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ ! -z "$2" ]] || [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

# defining variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/Documents/go
export JAVAFX_PATH="$HOME/javafx-sdk-22.0.2/lib"

addToPathFront $HOME/.local/scripts
addToPathFront $HOME/.local/dev-bin
addToPathFront $HOME/.local/bin

# do i need this one
addToPathFront $HOME/.cargo/bin
addToPathFront /usr/local/bin
addToPathFront /opt/homebrew/opt/coreutils/libexec/gnubin
#addToPathFront /usr/local/bin/node
addToPath $HOME/.docker/bin
addToPath $HOME/development/flutter/bin
addToPath $GOROOT/bin
addToPath $GOPATH/bin
addToPath /usr/local/mysql/bin
addToPath /opt/homebrew/opt/mysql/bin
addToPath /usr/local/opt/maven/bin
addToPath $HOME/.vscode-dotnet-sdk/.dotnet
#addToPath $N_PREFIX/bin
#addToPath $HOME/.n/bin
addToPath $HOME/.lmstudio/bin
addToPath /opt/homebrew/bin
addToPath /opt/homebrew/opt
addToPath /Applications/'Visual Studio Code.app'/Contents/Resources/app/bin
# addToPath /opt/podman/bin

#>>> Homebrew initialization
eval "$(/opt/homebrew/bin/brew shellenv)"

# #starting from here

#>>> NVM (lazy): sourcing nvm.sh costs ~0.5s, so put the default node on PATH
# directly and only load nvm itself the first time `nvm` is run.
export NVM_DIR="$HOME/.nvm"
if [[ -d "$NVM_DIR/versions/node" ]]; then
  _nvm_alias="$(<"$NVM_DIR/alias/default" 2>/dev/null)"
  _nvm_alias="${_nvm_alias#v}"
  case "$_nvm_alias" in node|stable|lts/*) _nvm_alias="" ;; esac
  # newest installed version matching the alias, e.g. "24" → v24.19.0
  _nvm_versions=( "$NVM_DIR"/versions/node/v${_nvm_alias}*(N/nOn) )
  # move it to the very front even if a parent shell already put it on PATH
  (( ${#_nvm_versions} )) && path=("${_nvm_versions[1]}/bin" ${path:#${_nvm_versions[1]}/bin})
  unset _nvm_alias _nvm_versions
fi
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}

#>>> Miniconda (lazy): the shell hook costs ~0.6s; load it on the first `conda` call.
# Base env is not auto-activated, so nothing else changes.
if [[ -x "$HOME/miniconda3/bin/conda" ]]; then
  addToPath "$HOME/miniconda3/condabin"
  conda() {
    unset -f conda
    eval "$("$HOME/miniconda3/bin/conda" shell.zsh hook 2> /dev/null)"
    conda "$@"
  }
fi

#>>> to avoid the deprecation warnings temporarily
alias gt='NODE_OPTIONS="--no-deprecation" gt'
