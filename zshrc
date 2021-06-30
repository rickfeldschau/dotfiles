export PATH=$HOME/bin:$PATH

# =============================================================================
#                                   Variables
# =============================================================================
export TERM="xterm-256color"
export LANG="en_US.UTF-8"

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=("rm -rf *" "fg=white,bold,bg=red")
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]="fg=white"
ZSH_HIGHLIGHT_STYLES[path_pathseparator]="fg=grey"
ZSH_HIGHLIGHT_STYLES[alias]="fg=cyan"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=cyan"
ZSH_HIGHLIGHT_STYLES[function]="fg=cyan"
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
ZSH_HIGHLIGHT_STYLES[commandseparator]="fg=yellow"
ZSH_HIGHLIGHT_STYLES[redirection]="fg=magenta"
ZSH_HIGHLIGHT_STYLES[bracket-level-1]="fg=cyan,bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-2]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-3]="fg=magenta,bold"
ZSH_HIGHLIGHT_STYLES[bracket-level-4]="fg=yellow,bold"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'


# =============================================================================
#                                   Functions
# =============================================================================
zsh_wifi_signal(){
    local signal=$(nmcli -t device wifi | grep '^*' | awk -F':' '{print $6}')
    local color="yellow"
    [[ $signal -gt 75 ]] && color="green"
    [[ $signal -lt 50 ]] && color="red"
    echo -n "%F{$color}\uf1eb" # \uf1eb is ï‡«
}

function psef() {
   ps -ef | grep -E "PID|$1" | grep -v grep
}


# =============================================================================
#                                   Aliases
# =============================================================================
# adding a space allows zsh to look for an alias after
alias sudo='sudo '
alias vi='vim'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias vvi='vim -u ~/custom.vimrc'
alias ldir='ls -ld */'

# =============================================================================
#                                   Final config
# =============================================================================
 
# Have zsh treat wildcards like bash, for utilities like scp and gsutil
setopt no_nomatch

[[ "$(umask)" == '000' ]] && umask 022 

if [ -z $XDG_CONFIG_HOME ]; then
  export NVM_DIR="$XDG_CONFIG_HOME/.nvm"
else 
  export NVM_DIR="$HOME/.nvm"
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Vim mode command line
bindkey -v
