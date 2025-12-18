"=============================================================================
" 基本設定 (Basic Settings)
"=============================================================================
set nocompatible
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8

" バックアップ・スワップファイル設定
set noswapfile
set nobackup
set writebackup

" 編集反映と表示
set autoread            " 外部での変更を自動検知
set number              " 行番号表示
set ruler               " ルーラー表示
set showmatch           " 括弧の対応表示
set laststatus=2        " ステータスラインを常に表示
set title               " タイトルを表示
set titlestring=vim\ \|\ %-25.55F\ %a%r%m titlelen=70
set hidden              " バッファを保存せずに切り替え可能にする
set updatetime=300      " 更新時間を短くする（GitGutterやCocのために重要）
set shortmess+=c        " 補完メニューのメッセージを抑制

" インデント・タブ設定
set expandtab           " タブをスペースに変換
set shiftwidth=2        " 自動インデント幅
set tabstop=2           " タブ文字幅
set autoindent          " 自動インデント
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]

" Go言語用の例外設定 (Goはタブ推奨のため)
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

" 検索・ハイライト
set hlsearch
set matchtime=1         " 対応括弧の表示秒数短縮

" ビープ音無効化
set visualbell t_vb=
set noerrorbells

" マウス・クリップボード
set mouse=a
set clipboard=unnamed   " OSのクリップボードと共有

"=============================================================================
" キーマッピング (Key Mappings)
"=============================================================================
" jj で ESC
inoremap jj <ESC>

" 行末まで選択の微調整
vnoremap v $h

" 削除操作でレジスタを汚さない
nnoremap x "_x
nnoremap s "_s

" ESC連打でハイライト解除
nnoremap <ESC><ESC> :nohl<CR>

" 定義ジャンプ (Coc.nvimに任せるため後述の設定を使用推奨だが、既存動作を維持)
" nnoremap <silent>gd :Ag <C-r><C-w><CR> 
" ※ Agコマンドがない場合に備え、Cocの定義ジャンプを推奨します（下部参照）

" ビジュアルモードで Ctrl+c (Mac用ハック: 基本的には clipboard=unnamed で動くはずですが既存維持)
map <C-c> :!pbcopy;pbpaste<CR><CR>

" タブ操作
nnoremap <C-p> gt
nnoremap <C-n> gT
nnoremap <C-c> :tabclose<CR>

" ペーストモード切り替え
imap <C-j> <nop>
set pastetoggle=<C-j>

" 0レジスタからのペースト
noremap PP "0p

"=============================================================================
" プラグイン管理 (vim-plug)
"=============================================================================
" 自動インストール設定
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" --- 外観・UI ---
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'              " 人気のカラースキーム
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'

" --- ユーティリティ ---
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'  " NERDTreeにGitステータスを表示
Plug 'ryanoasis/vim-devicons'       " アイコン表示（NERDTree等で使用）
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-endwise'            " Ruby等のend自動補完
Plug 'tpope/vim-surround'           " 括弧やクォートの操作を簡単に
Plug 'tpope/vim-commentary'         " コメントアウトを簡単に (gcc, gc)
Plug 'tpope/vim-repeat'             " . による繰り返しを強化
Plug 'jiangmiao/auto-pairs'         " 括弧の自動閉じ
Plug 'bronson/vim-trailing-whitespace'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'      " より強力なコメント機能
Plug 'mbbill/undotree'              " undo履歴を可視化
Plug 'vim-scripts/utl.vim'          " URLを開く
Plug 'vimwiki/vimwiki'              " パーソナルWiki（メモ管理に最適）

" --- Git連携 ---
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'            " GitHub support for fugitive
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'

" --- 言語サポート・シンタックス ---
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'kchmck/vim-coffee-script'
Plug 'mattn/vim-sonots'             " jbuilder support etc

" --- Markdown Support (メモ書き用途に最適) ---
Plug 'plasticboy/vim-markdown'      " 強化されたMarkdownサポート
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'dhruvasagar/vim-table-mode'   " テーブル作成を簡単に
Plug 'junegunn/goyo.vim'            " 集中執筆モード（メモに最適）
Plug 'junegunn/limelight.vim'       " 現在の段落をハイライト

" --- 補完・LSP (Modernization Core) ---
" neocomplete/vim-lspの代わりにCocを採用
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" --- スニペット ---
" Cocがスニペットも管理できますが、既存の資産を生かすなら以下を維持
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'mattn/sonictemplate-vim'

call plug#end()

"=============================================================================
" プラグイン設定 (Plugin Settings)
"=============================================================================

" --- ColorScheme ---
syntax on
set background=dark
colorscheme hybrid
autocmd ColorScheme * highlight LineNr ctermfg=241

" --- NERDTree ---
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let NERDTreeShowBookmarks = 1
let g:nerdtree_tabs_open_on_console_startup = 1

" 起動時にNERDTreeを表示し、カーソルをファイルへ移動
autocmd VimEnter * NERDTree | wincmd p

" タブ切り替え時にNERDTreeの状態を維持
autocmd BufWinEnter * NERDTreeMirror

" 他のバッファを閉じた時にNERDTreeだけなら終了
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" --- FZF (Uniteの代替) ---
" ,p でファイル検索
nnoremap <silent> ,p :Files<CR>
" ,f で文字列検索 (Ag/Rg)
nnoremap <silent> ,f :Rg<CR>
" ,b でバッファ検索
nnoremap <silent> ,b :Buffers<CR>

" --- GitGutter ---
nnoremap <silent> ,gl :<C-u>GitGutterLineHighlightsToggle<CR>

" --- vim-go ---
let g:go_fmt_command = "goimports" " gofmtの代わりにgoimportsを使用
let g:go_fmt_fail_silently = 0
" 保存時の自動フォーマットはvim-goがデフォルトでやってくれます

" --- Lightline ---
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'gitbranch', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'gitbranch': 'FugitiveHead'
      \ }
      \ }
function! LightLineFilename()
  return expand('%')
endfunction

" --- JSX/TSX ---
let g:vim_jsx_pretty_colorful_config = 1
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

" --- SonicTemplate ---
let g:sonictemplate_vim_template_dir = ['~/dotfiles/templates']

" --- Coc.nvim (補完・LSP設定) ---
" 既存の gd (Go to definition) を Coc で上書き (より正確です)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" K でドキュメント表示
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Tabで補完を選択
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Enterで補完決定
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" --- Markdown Preview ---
" Markdownプレビューを開く/閉じる (キーマップは既存と競合しないように設定)
" 使用方法: :MarkdownPreview でプレビュー開始
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_browser = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle'
    \ }

" --- vim-markdown設定 ---
let g:vim_markdown_folding_disabled = 1     " 折りたたみを無効化
let g:vim_markdown_conceal = 0              " 記号の隠蔽を無効化
let g:vim_markdown_frontmatter = 1          " YAML front matterをハイライト
let g:vim_markdown_toc_autofit = 1          " TOCを自動調整
let g:vim_markdown_new_list_item_indent = 2 " リストアイテムのインデント

" --- Goyo & Limelight (集中執筆モード) ---
" 集中執筆モードを起動/終了
nnoremap <silent> <Leader>g :Goyo<CR>

" Goyoを起動したらLimelightも自動起動
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Limelightの設定
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = '#777777'

" --- Undotree ---
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

" --- VimWiki (メモ・Wiki管理) ---
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown',
                      \ 'ext': '.md'}]
let g:vimwiki_global_ext = 0  " .mdファイルを全てVimWikiとして扱わない

"=============================================================================
" その他の自動処理 (Autocmds)
"=============================================================================
" Markdown設定
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd BufNewFile,BufRead ISSUE_EDITMSG set filetype=markdown
autocmd FileType markdown setlocal spell spelllang=en,cjk  " スペルチェック有効化

" Vue/HTML設定
autocmd BufNewFile,BufRead *.{html,htm,vue*} set filetype=html

" gcommit-and-fixup用の設定 (既存維持)
function! AutoSaveIfRebaseFixup()
  if match(getline(2), "fixup") == 0
    exec ":wq"
  endif
endfunction
if expand("%:t:r") == 'git-rebase-todo' && match(getline(2), "fixup")
  autocmd BufNewFile,BufRead git-rebase-todo call AutoSaveIfRebaseFixup()
endif
