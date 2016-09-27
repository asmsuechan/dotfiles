set nocompatible
"swapfileを作成しない
set noswapfile
set nobackup
set writebackup
"編集外でファイルの変更があった時、自動で更新
set autoread
"Backspaceキーの設定
set backspace=indent,eol,start
"行頭行末の左右移動で行をまたぐ
set whichwrap=b,s,h,l,<,>,[,]
"右下に表示される行、列の番号を表示する
set ruler
"対応括弧をハイライト表示する
set showmatch

"ステータスラインの設定
set laststatus=2
"itchyny/lightline.vimに任せた
"set statusline=%<%f\ %m%r%h%w
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']'}
"set statusline+=%=%l/%L,%c%V%8P
"set statusline=%F%m%r%h%w

"ビープ音を鳴らさない
set visualbell t_vb=

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
"行番号の表示
set number
if expand("%:e") !~ "go"
  set expandtab
endif
"インデント幅=2
set shiftwidth=2
"タブ文字幅=2
set tabstop=2
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
NeoBundle 'fatih/vim-go'
NeoBundle 'mattn/vim-sonots'

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

"vim-go用の設定
"セーブ時にgo fmtを実行しない
"=>:w打つたびにカーソルが移動してめんどくさいから
"=>代わりに下で実装している
let g:go_fmt_autosave = 0
let g:go_fmt_fail_silently = 0
"競プロ用テンプレートファイル
"~/.vim/bundle/vim-go/templates/default.go
if filereadable(expand('~/.vim/bundle/vim-go/templates/default.go'))
  let g:go_template_file = "default.go"
endif

"*.goファイルの保存時にgo fmtをかける
"コマンド打つ場所の高さを2行にする
:set cmdheight=2
function! _CheckGoCode()
  let currentfile = getcwd() . '/' . expand('%')
  exec ":silent ! go fmt " . currentfile
endfunction
command! CheckCode call _CheckGoCode()
autocmd BufWritePost *.go :CheckCode

filetype plugin indent on
set t_Co=256
