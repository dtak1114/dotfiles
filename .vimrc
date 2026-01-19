" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/Users/daisuke.takahashi.a/.cache/dein'

" Set Dein source path (required)
let s:dein_src = '/Users/daisuke.takahashi.a/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('preservim/nerdcommenter')


" Finish Dein initialization (required)
call dein#end()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax enable

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" ============================================
" 基本設定
" ============================================
" Use the OS clipboard by default
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
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
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
" Don't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
" Show "invisible" characters
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
" Don't reset cursor to start of line when moving around
set nostartofline
" Show the cursor position
set ruler
" Don't show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it's being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Enable autoread to reload files when changed externally
set autoread
" Allow switching buffers without saving
set hidden

" ============================================
" カラースキーム
" ============================================
colorscheme molokai
set background=dark
let g:molokai_original = 0
let g:rehash256 = 1
set t_Co=256

" ============================================
" キーマップ
" ============================================
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

" Dismiss search highlight by C-l
nnoremap <silent> <C-L> :noh<C-L><CR>

" Movement keymaps
noremap <S-h> ^
noremap <S-j> {
noremap <S-k> }
noremap <S-l> $

" Quick quit and save
noremap <C-q> :q<CR>
map :W :w
map :Q :q

" NERDCommenter toggle with ,,
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle

" ============================================
" ファイルタイプ別設定
" ============================================
if has("autocmd")
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  autocmd BufNewFile,BufRead *.bql setfiletype sql syntax=sql
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

  " Python setting
  autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4 smarttab
  " JavaScript setting
  autocmd FileType javascript setl tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab
endif
