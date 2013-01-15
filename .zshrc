
# Your settings ..

#-----------------------------

#export PATH=/usr/local/bin:$PATH
#export PATH=/usr/local/share/python:$PATH # For Mac-Homebrew-pip-virtualenv
export LANGUAGE=ja_JP:ja
export LANG=ja_JP.UTF-8
export EDITOR=vim
export PAGER=less

# virtualenvwrapper settings
export VIRTUALENV_USE_DISTRIBUTE=true
# For Mac-Homebrew
if [ -f /usr/local/share/python/virtualenvwrapper.sh ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/share/python/virtualenvwrapper.sh
fi
# For CentOS
#if [ -f /usr/bin/virtualenvwrapper.sh ]; then
#    export WORKON_HOME=$HOME/.virtualenvs
#    source /usr/bin/virtualenvwrapper.sh
#fi
# For Ubuntu
#if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#    export WORKON_HOME=$HOME/.virtualenvs
#    source /usr/local/bin/virtualenvwrapper.sh
#fi

# utils
alias ll='ls -lAF'
alias h='history '
alias hh='history 0 | grep '

# color
export LS_COLORS=

# compinit
autoload -U compinit
compinit

# history
# @see http://journal.mycom.co.jp/column/zsh/003/
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# PROMPT
# @see http://journal.mycom.co.jp/column/zsh/002/
# @see http://www.machu.jp/b/zsh.html
PROMPT='%(!.#.$)'
case "$TERM" in
xterm*|kterm*|rxvt*)
    # TITLE BAR
    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT")
;;
screen*)
    # TITLE BAR
    # @see http://d.hatena.ne.jp/amt/20060530/Screen
    printf "\033P\033]0;$USER@$HOSTNAME\007\033\\"
;;
esac
RPROMPT="[%~]"

# Key-Binds
# -e = Emacs / -v = Vi
# @see http://journal.mycom.co.jp/cgi-bin/print?id=41896
bindkey -e
