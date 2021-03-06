-
"set smartindent

" Make Vim more useful
set nocompatible

filetype indent on

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unnamed,autoselect
set clipboard=unnamed
" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
" if exists("&relativenumber")
  " set relativenumber
  " au BufReadPost * set relativenumber
" endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  autocmd BufNewFile,BufRead *.bql setfiletype sql syntax=sql
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

  "python setting
  autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4 smarttab
  autocmd FileType javascript setl tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab
endif
"vim-closetag setting
let g:closetag_filenames = "*.html,*.xml,*.erb"

" 
" quickrun-vim
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
"
" Syntastic settings
let g:syntastic_check_on_open=0 "Do syntax checkup on opening file
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_check_on_wq = 0 " wqではチェックしない
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=3 "エラー表示ウィンドウの高さ
set statusline+=%#warningmsg# "エラーメッセージの書式
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
let g:syntastic_javascript_eslint_args = ['--fix'] 
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['javascript', 'ruby'], 'passive_filetypes': [] }
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

" enable autoread to reload any files from files when checktime is called and
" the file is changed
set autoread
" add an autocmd after vim started to execute checktime for *.js files on write
au VimEnter *.js au BufWritePost *.js checktime

" syntastic python configure
"

let g:syntastic_python_python_exec = '/Users/dicek/pyenv/venv35/bin/python'
let g:syntastic_python_flake8_exec = 'python3.5'

" requires pip install pyflakes pep8.
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_python_flake8_args = ['-m', 'flake8']
let g:syntastic_enable_signs=1

" syntastic ruby configure
" gem i rubocop
let g:syntastic_ruby_checkers = ['mri','rubocop']
" use rvm rubocop..
let g:syntastic_ruby_rubocop_exec = '/Users/dicek/.rvm/gems/ruby-2.3.0/bin/rubocop'


"dismiss searching word highligh by c-l
nnoremap <silent> <C-L> :noh<C-L><CR>

" enable automatic folding
" refer :help folds
" basics: zc -> close folding
       " zo -> open folding
       " zR -> open all
" set foldmethod=syntax
" set foldlevelstart=3

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

"indent-guides
let g:indent_guides_auto_colors=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" let g:solarized_termtrans=0
colorscheme molokai
set background=dark
let g:molokai_original = 0
let g:rehash256 = 1
set t_Co=256

" Keymaps
noremap <S-h> ^
noremap <S-j> {
noremap <S-k> }
noremap <S-l> $
" jump to matching paren
noremap <m> %
noremap <C-q> :q<CR>
noremap <C-w> :w!<CR>
noremap == gg=G''
nnoremap <Space>v :vs<CR>:<C-u>VimShell<CR>
map :W :w
map :Q :q
" noremap <C-l> :term<CR>

" Neovundle
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))
" NeoBundle 'jiangmiao/auto-pairs'
" originalrepos on github

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
" NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'tpope/vim-surround'
"NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'
" NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'Shougo/neocomplete'
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
" NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'scrooloose/nerdcommenter' "commentout
NeoBundle 'nathanaelkane/vim-indent-guides' "visualize indents
" NeoBundle 'derekwyatt/vim-scala'
" NeoBundle 'fatih/vim-go'
NeoBundle 'fatih/vim-go', {
            \ 'autoload' : { 'filetypes' : 'go'  }
            \ }
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'Keithbsmiley/swift.vim'
" NeoBundle 'elzr/vim-json'
" NeoBundle 'ensime/ensime-vim'
" NeoBundle 'tpope/pathogen.vim'
NeoBundle 'moll/vim-node' " nodejs syntax highlighting
" NeoBundle 'rust-lang/rust.vim'
" NeoBundle 'racer-rust/vim-racer'
NeoBundle 'aklt/plantuml-syntax'
NeoBundle 'stephpy/vim-yaml'
" NeoBundle 'osyo-manga/vim-over'
NeoBundle 'leafCage/yankround.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'rhysd/devdocs.vim'
" NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ervandew/supertab'
NeoBundle 'jaxbot/semantic-highlight.vim'
" NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'cespare/vim-toml'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'pedrohdz/vim-yaml-folds'

" node js
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
call neobundle#end()

NeoBundleCheck

filetype plugin indent on     " required!
filetype indent on

" neocomplete
"
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" rust.vim
" requires rustfmt
" let g:rustfmt_autosave = 1
" vim-racer
set hidden
let g:racer_cmd = "/Users/dicek/.cargo/bin/racer"
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)
noremap <F10> :RustRun<CR>

" typescript-vim
" To run the compiler, enter :make, this will run tsc against the last saved
" version of your currently edited file.
" tsc compiler option
let g:typescript_compiler_options = ''
" show :make error msg in subwindow
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow
let g:typescript_indent_disable = 1
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


" yankround.vim {{{
"" キーマップ
" nmap p <Plug>(yankround-p)
" nmap P <Plug>(yankround-P)
" nmap <C-j> <Plug>(yankround-prev)
" nmap <C-k> <Plug>(yankround-next)
" "" 履歴取得数
" let g:yankround_max_history = 50
" ""履歴一覧(kien/ctrlp.vim)
" nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" }}}
"
"
" devdocs setting
" https://github.com/rhysd/devdocs.vim
" show document for word under selection
" nmap K <Plug>(devdocs-under-cursor)

"neosnippet
"" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" semantic-color
" let s:semanticGUIColors = [ '#72d572', '#c5e1a5', '#e6ee9c', '#fff59d', '#ffe082', '#ffcc80', '#ffab91', '#bcaaa4', '#b0bec5', '#ffa726', '#ff8a65', '#f9bdbb', '#f9bdbb', '#f8bbd0', '#e1bee7', '#d1c4e9', '#ffe0b2', '#c5cae9', '#d0d9ff', '#b3e5fc', '#b2ebf2', '#b2dfdb', '#a3e9a4', '#dcedc8' , '#f0f4c3', '#ffb74d' ]
"

"auto go fmt on save
let g:go_gmt_options = "-tabs=true -tabwidth=4"
"
" カンマ連打でコメントトグル with NERDCommenter
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" nerdtree
" ?: help
" o: open a file
" t: open file in new tab
" T: open file in new tab(background)
" r: refresh file node trees
" m: newfile / remove/ move / copy
"
" open explorer
map <C-n> :NERDTreeToggle<CR>
"go to previous tab
map <C-h> gT
"go to next tab
map <C-l> gt


