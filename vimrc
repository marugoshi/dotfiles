" ファイルタイプ関連
filetype on
filetype indent on
filetype plugin on

" タブ関連
set tabstop=2     " Tab文字を画面上で何文字分に展開するか
set shiftwidth=2  " cindentやautoindent時に挿入されるインデントの幅
set softtabstop=0 " Tabキー押し下げ時の挿入される空白の量，0はtabstopと同じ
set expandtab     " タブを空白文字に展開

" インデント関連
set autoindent  " 自動インデント
set smartindent " スマートインデント

" 互換関連
set nocompatible

" シンタックス関連
syntax on 

" 入力補助関連
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions+=m           " 整形オプション，マルチバイト系を追加

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ファイル関連
set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
set hidden     " 編集中でも他のファイルを開けるようにする

" 表示関連
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set wrap              " 画面幅で折り返す
set list              " 不可視文字表示
set listchars=tab:>\  " 不可視文字の表示方法
set notitle           " タイトル書き換えない
set scrolloff=5       " 行送り

" ステータスライン関連
set laststatus=2

" マウス関連
set mouse=a
set ttymouse=xterm2
map m :set mouse=a<CR>
map mm :set mouse=<CR>
