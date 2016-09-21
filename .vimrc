set nocompatible
set noswapfile
"swapfileを作成しない
set nobackup
set writebackup
set autoread
"編集外でファイルの変更があった時、自動で更新
set backspace=indent,eol,start
"Backspaceキーの設定
set whichwrap=b,s,h,l,<,>,[,]
"行頭行末の左右移動で行をまたぐ
set ruler
"右下に表示される行、列の番号を表示する
set showmatch
"対応括弧をハイライト表示する

"ステータスラインの設定
set laststatus=2
"itchyny/lightline.vimに任せた
"set statusline=%<%f\ %m%r%h%w
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}
"set statusline+=%=%l/%L,%c%V%8P
"set statusline=%F%m%r%h%w


inoremap jj <ESC>
"入力モード中に素早くjjと入力した場合はESCとみなす
vnoremap v $h                            

"文字コードをUTF-8にする
set encoding=UTF-8  
set fileencoding=UTF-8
set termencoding=UTF-8


"表示設定
syntax on
set title
set number
set expandtab
"行番号の表示
set shiftwidth=2
"インデント幅=2
set tabstop=2
"タブ文字幅=2
set autoindent
"改行時に前のインデントを継続する
autocmd BufWritePre * :%s/\t/  /ge

"カラースキーマ
"colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark


if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
endif
" runtimepath の追加は必須
set runtimepath+=~/.vim/bundle/neobundle.vim/


"=====neobundle bigin=====
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundleのプラグイン
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'cohama/agit.vim'
NeoBundle 'Shougo/neocomplete.vim'
"NeoBundle 'fatih/vim-go'

"----------各プラグインの説明----------
"[vimfiler]=:VimFilerで起動するファイラー
"[nerdtree]=:NERDTreeToggleで起動するファイラー、VimFilerよりよく使う
"[vim-endwise]=rubyでdef入力した時endを自動入力
"[vim-indent-guides]=インデントを見やすくする
"[lightline.vim]=ステータスラインに色をつける
"[vim-gitgutter]=gitの差分を表示する
"[agit.vim]=git logを見やすく
"--------------------------------------

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
"let g:indent_guides_enable_on_vim_startup = 1

"NERTTreeをCtr+Eで開くようにする
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"lightlineの設定
let g:lightline = { 'colorscheme': 'seoul256' }

"gitgutterのキーマップを設定
"nnoremap <silent> ,gt :<C-u>gitGutterToggle<CR>
nnoremap <silent> ,gl :<C-u>GitGutterLineHighlightsToggle<CR>

""neocompleteの設定
"let g:neocomplete#enable_at_startup = 1
"let g:acp_enableAtStartup = 0
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }


" vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundleCheck
call neobundle#end()
"=====neobundle end=====


filetype plugin indent on
set t_Co=256
