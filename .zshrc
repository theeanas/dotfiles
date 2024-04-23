if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/aliens.omp.json)"
fi

# Aliases
alias gs='git status'
alias ga='git add'
alias gl='git log'
alias glo='git log --oneline'
alias gc='git commit'
alias gd='git diff'
alias ls='ls -l --color=auto'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias gg='git grep -ni'

# Running scripts ... all start with rs (not reshape tho XD)
alias rsdocker='python3 ~/eta/scripts/run_docker.py'
alias rsk8s='sh ~/eta/scripts/access_k8s.sh'

# Git auto completion and other binaries
autoload -Uz compinit && compinit

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
zle -N lfcd
bindkey -a '^O' lfcd
bindkey -v '^O' lfcd


# fzf - the great and the powerful
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS='--no-height --no-reverse --border' # Go big, we all go home!
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# execute a history command instantly with ^X^R
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# iTerm does many cool things with this, like imgcat.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# mysql-client stuff - from their installation page ...
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# For compilers to find mysql-client you may need to set:
  export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

# Pycharm from terminal ...
export PATH=$PATH:'/Applications/PyCharm.app/Contents/MacOS'
alias charm='pycharm'

# Vim in shell? Oh yeah!
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Overrides ...
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change up a variable number of directories
# E.g:
#   cu   -> cd ../
#   cu 2 -> cd ../../
#   cu 3 -> cd ../../../
function cu {
    local count=$1
    if [ -z "${count}" ]; then
        count=1
    fi
    local path=""
    for (( i = 1; i <= count; i++ )); do
        path="${path}../"
    done
    cd $path
}

# Open all modified files in vim tabs
function vimod {
    vim -p $(git status -suall | awk '{print $2}')
}

# Open all modified files in vim tabs
function charmmod {
   pycharm -p $(git status -suall | awk '{print $2}')
}

