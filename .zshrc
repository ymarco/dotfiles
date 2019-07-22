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
# history settings
HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
# up and down arrows search the entered text back in history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

setopt autocd notify correctall
# vi mode
bindkey -v
# shift-tab selects the previous completion
bindkey '^[[Z' reverse-menu-complete
export KEYTIMEOUT=1
# no beep sound
unsetopt BEEP
# child programs dont terminate when exiting zsh
setopt NO_HUP
# Load shortcut aliases
[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

echo "$(tput bold)$(tput setaf 12)$(tput setaf 3)$USER$(tput setaf 7)@$(tput setaf 14)$HOST"
#echo "%B%F{12}[%b%F{3}%n%F{white}%B"

export PS1="%F{13}%c%B%F{12}%F{14} $ %b%f"
