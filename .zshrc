# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob always
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors $(tput setaf 2)
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current at %p%s
zstyle ':completion:*' substitute aoeualways
zstyle ':completion:*' use-compctl false
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u' 
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 
zstyle :compinstall filename '/home/yoavm448/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
setopt autocd notify correctall
bindkey -v
export KEYTIMEOUT=1

#appendhistory 
# End of lines configured by zsh-newuser-install

setopt NO_HUP

[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts" # Load shortcut aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

export PS1="%B%F{12}[%b%F{3}%n%F{white}:%F{13}%c%B%F{12}]%F{white}$ %b%f"
