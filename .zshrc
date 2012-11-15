alias screen='screen -U'


#-----------------------------

#export PATH=$PATH
export EDITOR=vim
export PAGER=lv
# @see http://journal.mycom.co.jp/column/zsh/002/
#export LANG=ja_JP.eucJP
export LANG=ja_JP.UTF-8

alias ll='ls -lAF'
alias h='history '
alias hh='history 0 | grep -nr '

# @see http://journal.mycom.co.jp/column/zsh/009/index.html
export LS_COLORS=

# compinit
# @see http://journal.mycom.co.jp/column/zsh/001/
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

