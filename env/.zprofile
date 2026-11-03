export XDG_CONFIG_HOME=$HOME/.config

PERSONAL=$XDG_CONFIG_HOME/personal
if [[ -d "$PERSONAL" ]]; then
  for i in $(find -L "$PERSONAL" -type f 2>/dev/null); do
      source "$i"
  done
fi

# all that sweet sweet fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GOPATH=$HOME/.local/go
export N_PREFIX="$HOME/.local/n"

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

addToPathFront $HOME/.local/scripts
addToPathFront $HOME/.local/dev-bin
addToPathFront $HOME/.local/bin

# do i need this one
addToPathFront $HOME/.cargo/bin
addToPath /Applications/'Visual Studio Code.app'/Contents/Resources/app/bin

#>>> Homebrew initialization
eval "$(/opt/homebrew/bin/brew shellenv)"