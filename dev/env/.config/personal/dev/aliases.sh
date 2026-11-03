#!/usr/bin/env zsh
# dev aliases loaded automatically via .zprofile source loop

# example:
# alias k="kubectl"
# alias dc="docker compose"
#>>> audio devices
alias macbook='SwitchAudioSource -s "MacBook Air Speakers"'
alias headphones='SwitchAudioSource -s "External Headphones"'

#>>> Colors
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"

#>>> Alias configuration for GCC and G++
alias gcc="gcc-14"
alias g++="g++-14"

#>>> stow related aliases
alias unstow='stow --delete'

#>>> Alias to run JavaFX programs
alias javafx_run='java --module-path "$JAVAFX_PATH" --add-modules javafx.controls,javafx.fxml -cp .'

alias vim='nvim'

#ssh config
#alias meetpi7="ssh -i ~/.ssh/test2 'meetpi7@homelab'"
