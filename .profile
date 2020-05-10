#!/bin/sh
#
export HISTCONTROL=ignoredups
export HISTSIZE=HISTFILESIZE=1000
export HISTIGNORE='c:clear'
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura"

export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.scripts/rofi:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$ANDROID_STUDIO/tools/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"
export EDITOR='emacs'
export TERMINAL="st"
export BROWSER='firefox'
export READER="evince"
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

export LF_ICONS="di=:fi=:ln=:or=:ex=:*.c=:*.cc=:*.clj=:*.coffee=:*.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:*.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:*.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:*.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:*.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:*.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:*.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:*.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:*.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:*.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:*.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:*.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf=:*.nix=:"

# export LESS_TERMCAP_me='\e[0m'    # turn off all
# export LESS_TERMCAP_mb='\e[31m'   # start blink
# export LESS_TERMCAP_md='\e[1;33m' # start bold
# export LESS_TERMCAP_so='\e[35m'   # start stand-out
# export LESS_TERMCAP_se='\e[0m'    # stop stand-out
# export LESS_TERMCAP_us='\e[34m'   # start underline
# export LESS_TERMCAP_ue='\e[0m'    # stop underline

export JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64'

GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"
export GUIX_LOCPATH="$GUIX_PROFILE/lib/locale"
#export _JAVA_AWT_WM_NONREPARENTING=1
#pgrep mpd || mpd;


export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"


#export GNUPGHOME="$XDG_DATA_HOME/gnupg"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
#aspell_personal=$(ls $XDG_CONFIG_HOME/aspell/*.pws)
#aspell_repl=$(ls $XDG_CONFIG_HOME/aspell/*.prepl)
# export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
# export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
#export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $aspell_personal; repl $aspell_repl"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export HISTFILE="$XDG_DATA_HOME/shell_history"
export ICEAUTHORITY="$XDG_CACHE_HOME/ICEauthority"
export INPUTRC="$XDG_CONFIG_HOME/inputrc"
export KODI_DATA="$XDG_DATA_HOME/kodi"
export LESSHISTFILE="-"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export SQLITE_HISTORY=$XDG_DATA_HOME/sqlite_history
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME/wineprefixes/default"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
#export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _Z_DATA="$XDG_DATA_HOME/z"
