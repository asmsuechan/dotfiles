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
" 行を強調表示
"set cursorline
"yankをクリップボードにも書き込む(macvim)
set clipboard=unnamed
"検索結果をハイライト表示する
set hlsearch
"マウス操作を有効にする
set mouse=a
"OSのクリップボードを使う
set clipboard=unnamed

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
"goではタブをスペースに変換しない
if expand("%:e") !~ "go"
  set expandtab
endif
"インデント幅=2
set shiftwidth=2
"タブ文字幅=2
set tabstop=2
set autoindent
"改行時に前のインデントを継続する
"goのファイルで保存した時にカーソルが移動する原因はこいつだったのでコメントイン
"autocmd BufWritePre * :%s/\t/  /ge

"スペース+.で.vimrcを開くようにする
"nnoremap <Space>. :<C-u>tabedit $HOME/.vimrc<CR>

"カラースキーマ
" colorscheme molokai
" colorscheme jellybeans
" colorscheme happy_hacking
" colorscheme perun
" colorscheme blue-mood
colorscheme hybrid
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

imap <C-j> <nop>
set pastetoggle=<C-j>

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
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'mattn/sonictemplate-vim'
"NeoBundle 'darthmall/vim-vue'
NeoBundleLazy 'jelera/vim-javascript-syntax',{'autoload':{'filetypes':['javascript']}}
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Chiel92/vim-autoformat'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tyru/open-browser-github.vim'
NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'scrooloose/syntastic'
" " カラースキーマの選択
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'sophacles/vim-processing'
" NeoBundle 'jistr/vim-nerdtree-tabs'
NeoBundle 'sophacles/vim-processing'
NeoBundle 'leafgarland/typescript-vim'

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
"let g:go_fmt_autosave = 0
let g:go_fmt_fail_silently = 0
"競プロ用テンプレートファイル
"~/.vim/bundle/vim-go/templates/default.go
if filereadable(expand('~/.vim/bundle/vim-go/templates/default.go'))
  let g:go_template_file = "default.go"
endif

"*.goファイルの保存時にgo fmtをかける
"コマンド打つ場所の高さを2行にする
"set cmdheight=2
"function! _CheckGoCode()
"  let currentfile = getcwd() . '/' . expand('%')
"  exec ":silent ! go fmt " . currentfile
"endfunction
"command! CheckCode call _CheckGoCode()
"autocmd BufWritePost *.go :CheckCode
"let g:go_fmt_command = "goimports"

"markdown用の設定
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd BufNewFile,BufRead ISSUE_EDITMSG set filetype=markdown

"snippets用の設定
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory='~/dotfiles/snippets/'

"sonictemplate-vim用の設定
let g:sonictemplate_vim_template_dir = [
      \ '~/dotfiles/templates'
      \]
"js用の設定
"vuejsはhtmlのシンタックスハイライトにする
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html

"gcommit-and-fixup用の設定
"自動で上書き保存して閉じる
function AutoSaveIfRebaseFixup()
  if match(getline(2), "fixup") == 0
    exec ":wq"
  endif
endfunction

if expand("%:t:r") == 'git-rebase-todo' && match(getline(2), "fixup")
  autocmd BufNewFile,BufRead git-rebase-todo call AutoSaveIfRebaseFixup()
endif

"ヴィジュアルモードでCtl+cしたらクリップボードにコピーされるよう設定
map <C-c> :!pbcopy;pbpaste<CR><CR>

"vim起動時は常にNERDTreeを表示する
autocmd VimEnter * execute 'NERDTree'

" NERDTreeで隠しファイルを常に表示する
let NERDTreeShowHidden = 1

"NERDTree起動時にブックマークを表示する
let NERDTreeShowBookmarks=1

"デフォルトでツリーを表示させる
let g:nerdtree_tabs_open_on_console_startup=1

"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"NERDTreeを新しいタブを開いた時も開きっぱなしにする
"'jistr/vim-nerdtree-tabs'だと閉じる時にNERDTreeのサイズが変わってしまって使いにくかったので
autocmd BufWinEnter * NERDTreeMirror

nnoremap <C-p> gt
nnoremap <C-n> gT
nnoremap <C-c> :tabclose<CR>
"nnoremap <C-o> :OpenGithubFile<CR>

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"新しいタブを開いたときなどにカーソルをファイルの方にする
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"シンタックスチェク
"'scrooloose/syntastic'の設定
"vueでうまく効かないしよくvimが落ちるようになったので一時的にコメントアウト
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"command Reek SyntasticCheck reek

filetype plugin indent on
set t_Co=256
