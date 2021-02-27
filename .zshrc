# xst-256color isn't supported over ssh, so revert to a known one
[ "$TERM" = xst-256color ] && export TERM=xterm-256color

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
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

autoload -Uz compinit && compinit
# history settings
HISTSIZE=6000
SAVEHIST=6000
# up and down arrows search the entered text back in history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey '\eOA' history-beginning-search-backward
bindkey '\eOB' history-beginning-search-forward

setopt autocd notify correct
# vi mode
#bindkey -v
# shift-tab selects the previous completion
bindkey '^[[Z' reverse-menu-complete
export KEYTIMEOUT=1
# no beep sound
unsetopt BEEP
# child programs dont terminate when exiting zsh
setopt NO_HUP
setopt interactivecomments
# Load shortcut aliases
[ -f "$HOME/.config/shortcuts" ] && source "$HOME/.config/shortcuts"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# echo "$(tput bold)$(tput setaf 4)$(tput setaf 3)$USER$(tput setaf 7)@$(tput setaf 6)$HOST"

export PS1="%F{5}%c%B%F{4}%F{6} $ %b%f"
