# Tmp settings

function filter_pipeline_by_yesno() {
  prompt_message="$1"
  default_value="$2"

  printf "$1"
  read answer
  case "$answer" in
    'y' | 'yes' | 'Y' | 'YES' | 'Yes') return 0;;
    'n' | "no" | 'N' | 'NO' | 'No') return 1;;
    *) return "$2";;
  esac
}

# Apache
function webserver() {
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
function mta (){
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
function showallfiles() {
  if [ "$1" = "" -o "$1" = "on" ]; then
    defaults write com.apple.finder AppleShowAllFiles TRUE
  else
    defaults write com.apple.finder AppleShowAllFiles FALSE
  fi
  killall Finder
}

# check-for-changes が特定リポジトリで重いことがあるので、その対処
# ただその前に、重いリポジトリ内で一度明示的に git status を打ってみる
# それで早くなったことがある
function enable_check_for_changes() {
  zstyle ':vcs_info:git:*' check-for-changes true
}
function disable_check_for_changes() {
  zstyle ':vcs_info:git:*' check-for-changes false
}

# MySQL を操作した際に
# Lost connection to MySQL server at 'sending authentication information', system error: 32
# というエラーになる問題への対処用に作った、プロセス kill コマンド
function kill_mysqld() {
  mysqld_process=$(ps aux | grep -E 'mysql/[0-9]+\.[0-9]+\.[0-9]+/bin/mysqld ')
  if [ "$mysqld_process" = "" ]; then
    echo 'mysqld is not running'
    return 0
  fi

  mysqld_pid=$(echo "$mysqld_process" | sed -E 's/^[^ ]+ +([0-9]+) +.+$/\1/')
  killer="kill -9 $mysqld_pid"

  echo '-- found mysqld process --'
  echo "$mysqld_process"
  echo '--------------------------'
  filter_pipeline_by_yesno 'execute `'"$killer"'`? [y/N]: ' 1
  if [ "$?" = '1' ]; then
    return 1
  fi

  eval $killer
  echo 'the current mysqld process has been killed'
}

#-----------------------------

export LANGUAGE=ja_JP:ja
export LANG=ja_JP.UTF-8
export EDITOR=vim
export PAGER=less

# Util aliases
alias ll='ls -lAF'

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


# --------------------------
# その他のコマンドの読み込み
# --------------------------
