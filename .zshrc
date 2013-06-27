
# Tmp settings

# Apache
webserver ()
{
  sub_command="$1"
  if [ "$sub_command" = "" ]; then
    sub_command='start'
  fi
  case "$sub_command" in
    'start'|'stop')
      sudo apachectl $sub_command
      ;;
    'check')
      ps aux | grep 'httpd'
  esac
}

# MySQL Server
# mysql.server start
# mysql.server stop

# MTA
# sudo launchctl start org.postfix.master
# sudo launchctl stop org.postfix.master
# ps aux | grep 'postfix'
mta ()
{
  sub_command="$1"
  if [ "$sub_command" = "" ]; then
    sub_command='start'
  fi
  case "$sub_command" in
    'start'|'stop')
      sudo launchctl $sub_command org.postfix.master
      ;;
    'check')
      ps aux | grep 'postfix'
  esac
}

# Redis-server
# redis-server /usr/local/etc/redis.conf  # 起動

# Show hidden-files and hidden-dirs
showallfiles ()
{
  if [ "$1" = "" ]; then
    defaults write com.apple.finder AppleShowAllFiles TRUE
  else
    defaults write com.apple.finder AppleShowAllFiles FALSE
  fi
  killall Finder
}


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

# Util aliases
alias ll='ls -lAF'
alias h='history '
alias hh='history 0 | grep '
alias mm='mysql -uroot '

# Color
export LS_COLORS=

# History
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=20000
export SAVEHIST=20000
setopt hist_ignore_dups  # 直前と同じコマンドをヒストリへ追加しない
setopt share_history  # ヒストリを共有

# 基本キーバインド選択, -e=Emacs風, -v=Vim風
bindkey -e


# -------------
# prompt の設定
# -------------
setopt prompt_subst
autoload -U colors; colors
autoload -Uz vcs_info

# 基本フォーマット, %b=ブランチ名, %s=VCS名 など
zstyle ':vcs_info:*' formats '[%b]%c%u'
# 異常時の特殊フォーマット, コンフリクト中などは書式が変わる
# %a へ原因となったアクション名が入る
zstyle ':vcs_info:*' actionformats '[%b|%a]%c%u'

# 作業コピー変更を示すマーク, %c に対応
zstyle ':vcs_info:*' unstagedstr '?'
# インデックス変更を示すマーク, %u に対応
zstyle ':vcs_info:*' stagedstr '+'

# 上記 %c,%s の反映を Git の場合のみ有効にしている
zstyle ':vcs_info:git:*' check-for-changes true
# Mercurial はまだ動かないので有効にしない、デフォルトは false
#zstyle ':vcs_info:hg:*' check-for-changes true

# 組み込み関数 precmd を上書きしているらしい, 詳細不明
precmd () {
    psvar=()
    vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# プロンプトの書式設定
PROMPT=$'%{$fg[yellow]%}%n%{$fg[red]%}@$fg[green]%}%m %{$fg[cyan]%}%~ %1(v|%F{green}%1v%f|)\n%{$fg[green]%}%#%{$reset_color%}'

## 旧プロンプト設定
#PROMPT='%(!.#.$)'
#case "$TERM" in
#xterm*|kterm*|rxvt*)
#    # TITLE BAR
#    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT")
#;;
#screen*)
#    # TITLE BAR
#    # @see http://d.hatena.ne.jp/amt/20060530/Screen
#    printf "\033P\033]0;$USER@$HOSTNAME\007\033\\"
#;;
#esac
#RPROMPT="[%~]"


# ----------------
# その他の個別設定
# ----------------

# 補完機能の強化
autoload -U compinit
compinit

# ビープを鳴らさない
setopt nobeep

# ディレクトリだけ入力した場合に cd を自動的に補完
setopt auto_cd

# cd を実行した際にディレクトリ移動履歴を保存
setopt autopushd
setopt pushd_ignore_dups # 同じディレクトリを pushd しない

# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

# コマンドラインをコピペする時に RPROMPT 部分を除外する
setopt transient_rprompt

# 色を使う
setopt prompt_subst

# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

# 補完候補一覧でファイルの種別をマーク表示
setopt list_types

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

# 補完候補を一覧表示
setopt auto_list

# git で HEAD^ が書けなくなるので無効にした
# ref) http://d.hatena.ne.jp/supermassiveblackhole/20100820/1282284495
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
#setopt extended_glob

# TAB で順に補完候補を切り替える
setopt auto_menu

# zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

# =command を command のパス名に展開する
setopt equals

# ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

# 出力時8ビットを通す
setopt print_eight_bit

# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# https://github.com/aziz/tmuxinator/
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


# -------------------
# git-flow-completion
#
# Ref) https://github.com/bobthecow/git-flow-completion
# -------------------
_git-flow ()
{
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    ':command:->command' \
    '*::options:->options'

  case $state in
    (command)

      local -a subcommands
      subcommands=(
        'init:Initialize a new git repo with support for the branching model.'
        'feature:Manage your feature branches.'
        'release:Manage your release branches.'
        'hotfix:Manage your hotfix branches.'
        'support:Manage your support branches.'
        'version:Shows version information.'
      )
      _describe -t commands 'git flow' subcommands
    ;;

    (options)
      case $line[1] in

        (init)
          _arguments \
            -f'[Force setting of gitflow branches, even if already configured]'
          ;;

          (version)
          ;;

          (hotfix)
            __git-flow-hotfix
          ;;

          (release)
            __git-flow-release
          ;;

          (feature)
            __git-flow-feature
          ;;
      esac
    ;;
  esac
}

__git-flow-release ()
{
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    ':command:->command' \
    '*::options:->options'

  case $state in
    (command)

      local -a subcommands
      subcommands=(
        'start:Start a new release branch.'
        'finish:Finish a release branch.'
        'list:List all your release branches. (Alias to `git flow release`)'
        'publish:Publish release branch to remote.'
        'track:Checkout remote release branch.'
      )
      _describe -t commands 'git flow release' subcommands
      _arguments \
        -v'[Verbose (more) output]'
    ;;

    (options)
      case $line[1] in

        (start)
          _arguments \
            -F'[Fetch from origin before performing finish]'\
            ':version:__git_flow_version_list'
        ;;

        (finish)
          _arguments \
            -F'[Fetch from origin before performing finish]' \
            -s'[Sign the release tag cryptographically]'\
            -u'[Use the given GPG-key for the digital signature (implies -s)]'\
            -m'[Use the given tag message]'\
            -p'[Push to $ORIGIN after performing finish]'\
            ':version:__git_flow_version_list'
        ;;

        (publish)
          _arguments \
            ':version:__git_flow_version_list'
        ;;

        (track)
          _arguments \
            ':version:__git_flow_version_list'
        ;;

        *)
          _arguments \
            -v'[Verbose (more) output]'
        ;;
      esac
    ;;
  esac
}

__git-flow-hotfix ()
{
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    ':command:->command' \
    '*::options:->options'

  case $state in
    (command)

      local -a subcommands
      subcommands=(
        'start:Start a new hotfix branch.'
        'finish:Finish a hotfix branch.'
        'list:List all your hotfix branches. (Alias to `git flow hotfix`)'
      )
      _describe -t commands 'git flow hotfix' subcommands
      _arguments \
        -v'[Verbose (more) output]'
    ;;

    (options)
      case $line[1] in

        (start)
          _arguments \
            -F'[Fetch from origin before performing finish]'\
            ':hotfix:__git_flow_version_list'\
            ':branch-name:__git_branch_names'
        ;;

        (finish)
          _arguments \
            -F'[Fetch from origin before performing finish]' \
            -s'[Sign the release tag cryptographically]'\
            -u'[Use the given GPG-key for the digital signature (implies -s)]'\
            -m'[Use the given tag message]'\
            -p'[Push to $ORIGIN after performing finish]'\
            ':hotfix:__git_flow_hotfix_list'
        ;;

        *)
          _arguments \
            -v'[Verbose (more) output]'
        ;;
      esac
    ;;
  esac
}

__git-flow-feature ()
{
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    ':command:->command' \
    '*::options:->options'

  case $state in
    (command)

      local -a subcommands
      subcommands=(
        'start:Start a new feature branch.'
        'finish:Finish a feature branch.'
        'list:List all your feature branches. (Alias to `git flow feature`)'
        'publish:Publish feature branch to remote.'
        'track:Checkout remote feature branch.'
        'diff:Show all changes.'
        'rebase:Rebase from integration branch.'
        'checkout:Checkout local feature branch.'
        'pull:Pull changes from remote.'
      )
      _describe -t commands 'git flow feature' subcommands
      _arguments \
        -v'[Verbose (more) output]'
    ;;

    (options)
      case $line[1] in

        (start)
          _arguments \
            -F'[Fetch from origin before performing finish]'\
            ':feature:__git_flow_feature_list'\
            ':branch-name:__git_branch_names'
        ;;

        (finish)
          _arguments \
            -F'[Fetch from origin before performing finish]' \
            -r'[Rebase instead of merge]'\
            ':feature:__git_flow_feature_list'
        ;;

        (publish)
          _arguments \
            ':feature:__git_flow_feature_list'\
        ;;

        (track)
          _arguments \
            ':feature:__git_flow_feature_list'\
        ;;

        (diff)
          _arguments \
            ':branch:__git_branch_names'\
        ;;

        (rebase)
          _arguments \
            -i'[Do an interactive rebase]' \
            ':branch:__git_branch_names'
        ;;

        (checkout)
          _arguments \
            ':branch:__git_flow_feature_list'\
        ;;

        (pull)
          _arguments \
            ':remote:__git_remotes'\
            ':branch:__git_branch_names'
        ;;

        *)
          _arguments \
            -v'[Verbose (more) output]'
        ;;
      esac
    ;;
  esac
}

__git_flow_version_list ()
{
  local expl
  declare -a versions

  versions=(${${(f)"$(_call_program versions git flow release list 2> /dev/null | tr -d ' |*')"}})
  __git_command_successful || return

  _wanted versions expl 'version' compadd $versions
}

__git_flow_feature_list ()
{
  local expl
  declare -a features

  features=(${${(f)"$(_call_program features git flow feature list 2> /dev/null | tr -d ' |*')"}})
  __git_command_successful || return

  _wanted features expl 'feature' compadd $features
}

__git_remotes () {
  local expl gitdir remotes

  gitdir=$(_call_program gitdir git rev-parse --git-dir 2>/dev/null)
  __git_command_successful || return

  remotes=(${${(f)"$(_call_program remotes git config --get-regexp '"^remote\..*\.url$"')"}//#(#b)remote.(*).url */$match[1]})
  __git_command_successful || return

  # TODO: Should combine the two instead of either or.
  if (( $#remotes > 0 )); then
    _wanted remotes expl remote compadd $* - $remotes
  else
    _wanted remotes expl remote _files $* - -W "($gitdir/remotes)" -g "$gitdir/remotes/*"
  fi
}

__git_flow_hotfix_list ()
{
  local expl
  declare -a hotfixes

  hotfixes=(${${(f)"$(_call_program hotfixes git flow hotfix list 2> /dev/null | tr -d ' |*')"}})
  __git_command_successful || return

  _wanted hotfixes expl 'hotfix' compadd $hotfixes
}

__git_branch_names () {
  local expl
  declare -a branch_names

  branch_names=(${${(f)"$(_call_program branchrefs git for-each-ref --format='"%(refname)"' refs/heads 2>/dev/null)"}#refs/heads/})
  __git_command_successful || return

  _wanted branch-names expl branch-name compadd $* - $branch_names
}

__git_command_successful () {
  if (( ${#pipestatus:#0} > 0 )); then
    _message 'not a git repository'
    return 1
  fi
  return 0
}

zstyle ':completion:*:*:git:*' user-commands flow:'provide high-level repository operations'


# --------------------------
# その他のコマンドの読み込み
# --------------------------

# autoload の -Uz はとりあえず付けといた方が良い
#   -U の説明: http://blog.livedoor.jp/miya_k_/archives/206513.html
#   -z の説明: http://blog.livedoor.jp/miya_k_/archives/227129.html
autoload -Uz add-zsh-hook

# https://github.com/rupa/z
#
#   brew install z でインストール
if [ `uname` = 'Darwin' ]; then
  . `brew --prefix`/etc/profile.d/z.sh
  z_precmd () {
     z --add "$(pwd -P)"
  }
  add-zsh-hook precmd z_precmd
fi

