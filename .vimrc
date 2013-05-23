" Getting started:
" ----
" cd ~
" mkdir tmp  # directory, backupdir 用
" vim ~/.vimrc
" (Vundleのコメントアウトを削除して :BundleInstall を実行)
" (ただし、何か大事な設定が変わって戻せなかったので保留中)
" ----


"-------------------------------------------------
" Vundle settings
"-------------------------------------------------
"
" Vundle設定は一番上に書くらしい
"
" https://github.com/gmarik/vundle
" http://slumbers99.blogspot.jp/2012/02/vim-vundle.html
" http://shu-cream.blogspot.jp/2011/04/2011vimvundle.html
"
"" vi との互換性OFF
"set nocompatible
"" ファイル形式の検出を無効にする
"filetype off
"" Vundle を初期化して Vundle 自身も Vundle で管理
"set rtp+=~/.vim/bundle/vundle/
""call vundle#rc()
"Bundle 'gmarik/vundle'
"" CoffeeScript用パッケージ
"Bundle 'kchmck/vim-coffee-script'
"filetype plugin indent on


"-------------------------------------------------
" 一般的な設定
"-------------------------------------------------
" 構文解析を行う
syntax on
" 文字コード
set fileencoding=utf-8
" 編集中でのバッファ切り替えを可能にする、タブモードの為に必要っぽい
set hidden
" コマンドモードの補完をするときに強化されたものを使うか否か
set wildmenu
" Vimがテキストを整形する方法を決定するオプションのリスト
" @see http://vimwiki.net/?'formatoptions'
" rオプションを付けると、挿入モードでのリターンキー押下時に自動的にコメントプレフィックスが付く
" oオプションを付けると、コピペした時とかにコメントが勝手に増えることがある
set formatoptions=ql
" ファイル名の補完をリストにして出力する
set wildmode=list:longest


"-------------------------------------------------
" 検索に関する設定
"-------------------------------------------------
" 検索時に大文字小文字を無視するか否か
set ignorecase
" 特殊な検索ロジックの設定
" @see http://vimwiki.net/?'smartcase'
" set smartcase
" 検索時にファイルの最後まで行ったら最初に戻るか否か
set wrapscan
" 検索文字列をハイライトするか否か(omited:"hls")
set hlsearch


"-------------------------------------------------
" 編集に関する設定
"-------------------------------------------------
" タブの画面上での幅
"   ruby関連は2個にする
set tabstop=2
set softtabstop=2
set shiftwidth=2
autocmd BufRead,BufNewFile *.py set tabstop=4 softtabstop=4 shiftwidth=4
" autocmd BufRead,BufNewFile *.rb set tabstop=2 softtabstop=2 shiftwidth=2
" autocmd BufRead,BufNewFile *.rhtml set tabstop=2 softtabstop=2 shiftwidth=2
" タブをスペースに展開するか否か
set expandtab
" 自動的にインデントするか否か
set autoindent
" バックスペースでインデントや改行を削除できるようにする
" @see http://vimwiki.net/?'backspace'
set backspace=indent,eol,start
" 括弧入力時に対応する括弧を表示するか否か
" 表示させない為には set noshowmatch だけではダメで、
" loaded_matchparen = 1の設定も必要。
" @see http://jarp.does.notwork.org/diary/200612a.html
set noshowmatch
let loaded_matchparen = 1


"-------------------------------------------------
" 画面表示の設定
"-------------------------------------------------
" 行番号を非表示にするか否か
set number
" ルーラーを表示するか否か
set ruler
" タブや改行を表示するか否か
set list
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
set listchars=tab:>-
" 長い行を折り返して表示するか否か
set nowrap
" 常にステータスラインを表示
set laststatus=2
" ステータスラインに文字コードを改行文字を表示
" @see kawadu's .vimrc
" @see http://vimwiki.net/?plugin=related&page=%27statusline%27 (←書式を知りたい場合はコレ)
set statusline=%<%f\ %m%R%H%W%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" コマンドモード入力部分の縦幅
set cmdheight=1
" コマンドをステータス行に表示するか否か
set showcmd
" タイトルバーに情報を表示するか否か
set notitle
" 自動改行を禁止する
set textwidth=0
" 折り畳み設定にマーカーを使う
set foldmethod=marker


"-------------------------------------------------
" バックアップ・スワップに関する設定
"-------------------------------------------------
" スワップファイルの保存先
set directory=$HOME/tmp
" バックアップファイルの保存先
set backupdir=$HOME/tmp
" バックアップファイルを作成するか否か
set nobackup
" 一時的なバックアップファイルを作成するか否か
set nowritebackup
" コマンドの履歴やグローバルマーク保存に関する設定
" @see http://vimwiki.net/?'viminfo'
" @see http://www.kaoriya.net/vimdoc_j/usr_21.txt
" なお set viminfo? で現在の設定を見れる
" - グローバルマーク
"set viminfo+=f1
" - 検索履歴の行数
set viminfo+=/50
" - マークの行数
set viminfo+='50
" コマンド履歴の保存数
" - viminfoとの兼ね合いは良くわからない
set history=10000


"-------------------------------------------------
" マウス操作に関する設定
"-------------------------------------------------
" どのモードでもマウスを使えるようにする
" 例えば、ビジュアルモードの選択範囲をマウスで選択できる。
" ターミナル本体の範囲選択とコピーができなくなるので抑止。
"set mouse=a
" マウスの移動でフォーカスを自動的に切替えるか否か
set nomousefocus
" 入力時にマウスポインタを隠すか否か
set mousehide
" ビジュアル選択を自動的にシステムのクリップボードに入れる
set guioptions+=a


"-------------------------------------------------
" 色に関する設定
"-------------------------------------------------
" ctermbg=ターミナル時の背景色
" ctermfg=ターミナル時の文字色
" 被検索対象文字列
highlight Search ctermbg=Yellow ctermfg=Black
" タブと行末半角スペースと半角スペース
highlight TabSpace ctermbg=DarkBlue
match TabSpace /\t\|\s\+$/
" ディレクトリ
highlight Directory ctermfg=LightCyan
" syntax - 通常
highlight Normal ctermfg=White
" syntax - コメント
highlight Comment ctermfg=DarkRed
" syntax - PHP - 条件文
" ex) declare else enddeclare endswitch elseif endif if switch
highlight phpConditional ctermfg=Magenta
" syntax - PHP - 繰り返し文
" ex) as do endfor endforeach endwhile for foreach while
highlight phpRepeat ctermfg=Magenta
" syntax - PHP - 制御文
" ex) return break continue exit
highlight phpStatement ctermfg=Magenta
" syntax - PHP - 演算子
" phpOperator と phpRelation を合わせて（通常の）演算子と考える
highlight phpOperator ctermfg=White
highlight phpRelation ctermfg=White
" syntax - PHP - 変数の前の $
highlight phpVarSelector ctermfg=LightCyan
" syntax - PHP - メンバを表す ->
highlight phpMemberSelector ctermfg=LightCyan
" syntax - PHP - ラベル
" ex) case default switch
highlight phpLabel ctermfg=Magenta
" syntax - PHP - 文字列
" ...Double = " , ...Backtick = ` , ...Single = '
highlight phpStringDouble ctermfg=White
highlight phpBacktick ctermfg=White
highlight phpStringSingle ctermfg=White
" syntax - PHP - 数値
highlight phpNumber ctermfg=White
" syntax - PHP - 変数
" 以下全てで変数全体と考える
highlight phpIdentifier ctermfg=LightCyan
highlight phpIdentifierSimply ctermfg=LightCyan
highlight phpIdentifierComplex ctermfg=LightCyan
highlight phpIdentifierComplexP ctermfg=LightCyan
" syntax - PHP - 関数
highlight phpFunctions ctermfg=Green

" CGI
" au! BufRead,BufNewFile *.cgi setfiletype ruby

" ActionScript
" @see http://vim.sourceforge.net/scripts/script.php?script_id=413
" au! BufNewFile,BufRead *.as :set filetype=actionscript


"-------------------------------------------------
" プラグイン関連
"-------------------------------------------------
" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-m>'  " デフォルトと変えた
let g:ctrlp_cmd = 'CtrlP'


"-------------------------------------------------
" キーバインド
"-------------------------------------------------
" バッファ切り替え
nnoremap <C-N> :bn!<CR>
nnoremap <C-P> :bp!<CR>
" 5回移動する
nnoremap <C-J> 5j
nnoremap <C-K> 5k
nnoremap <C-H> 5h
nnoremap <C-L> 5l
" インサートモード中でもhjklで移動
inoremap <C-J> <DOWN>
inoremap <C-K> <UP>
inoremap <C-H> <LEFT>
inoremap <C-L> <RIGHT>
" カーソル上下の前方一致補完にする
cnoremap <C-P> <UP>
cnoremap <C-N> <DOWN>
