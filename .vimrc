" Use the Solarized Dark theme
"set background=dark
" let g:solarized_termtrans=1
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256

" Adjust indents automatically by judging the content of inserted text.
"set smartindent 

" Make Vim more useful
set nocompatible

filetype indent on

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed,autoselect
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
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif
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
endif

" Neovundle
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))

      " NeoBundle 'jiangmiao/auto-pairs'
      " originalrepos on github
      NeoBundle 'Shougo/neobundle.vim'
      NeoBundle 'tpope/vim-surround'
      " NeoBundle 'Shougo/vimproc'
      "NeoBundle 'Shougo/vimshell'
      "NeoBundle 'Shougo/unite.vim'
      NeoBundle 'Shougo/neocomplcache'
      NeoBundle 'Shougo/neocomplete'
      NeoBundle 'Shougo/neosnippet'
      NeoBundle 'Shougo/neosnippet-snippets'
      NeoBundle 'jpalardy/vim-slime'
      NeoBundle 'scrooloose/syntastic'
      NeoBundle 'vim-ruby/vim-ruby'
      NeoBundle 'https://bitbucket.org/kovisoft/slimv'
      NeoBundle 'scrooloose/nerdcommenter' "commentout
      NeoBundle 'nathanaelkane/vim-indent-guides' "visualize indents
      NeoBundle 'derekwyatt/vim-scala' 
      " NeoBundle 'faith/vim-go'
      NeoBundle 'nathanaelkane/vim-indent-guides'
      " NeoBundle 'davidhalter/jedi-vim'
      NeoBundle 'kevinw/pyflakes-vim'
      NeoBundle 'Keithbsmiley/swift.vim'
      " NeoBundle 'elzr/vim-json'
      NeoBundle 'ensime/ensime-vim'
      " NeoBundle 'tpope/pathogen.vim'
      " NeoBundle 'moll/vim-node' " nodejs syntax highlighting

      " node js
      NeoBundle 'leafgarland/typescript-vim'
  call neobundle#end()
endif
filetype plugin indent on     " required!
filetype indent on

"vim-closetag setting
let g:closetag_filenames = "*.html,*.xml,*.erb"

" カンマ連打でコメントトグル with NERDCommenter
 let NERDSpaceDelims = 1
 nmap ,, <Plug>NERDCommenterToggle
 vmap ,, <Plug>NERDCommenterToggle

 " typescript-vim
 " To run the compiler, enter :make, this will run tsc against the last saved
 " version of your currently edited file.
 " tsc compiler option
 " let g:typescript_compiler_options = ''
 " show :make error msg in subwindow
 " autocmd QuickFixCmdPost [^l]* nested cwindow
 " autocmd QuickFixCmdPost    l* nested lwindow




" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
"
"
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

" Syntastic settings
  let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
  let g:syntastic_check_on_save=1 "保存時にはチェック
  let g:syntastic_check_on_wq = 0 " wqではチェックしない
  let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
  let g:syntastic_loc_list_height=3 "エラー表示ウィンドウの高さ
  set statusline+=%#warningmsg# "エラーメッセージの書式
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う
  let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['javascript', 'ruby'],
        \ 'passive_filetypes': []
        \ }

  " syntastic python configure
  " requires pip install pyflakes pep8.
  let g:syntastic_python_checkers = ['pyflakes', 'pep8']
  let g:syntastic_enable_signs=1

  " syntastic ruby configure
  " gem i rubocop
  let g:syntastic_ruby_checkers = ['mri','rubocop']
  " use rvm rubocop.. 
  let g:syntastic_ruby_rubocop_exec = '/Users/dicek/.rvm/gems/ruby-2.3.0/bin/rubocop'




"dismiss searching word highligh by c-l
nnoremap <silent> <C-L> :noh<C-L><CR>

"enable automatic folding 
"refer :help folds
"basics: zc -> close folding
"        zo -> open folding
"        zR -> open all
" set foldmethod=syntax
" set foldlevelstart=1

" let javaScript_fold=1         " JavaScript
" let perl_fold=1               " Perl
" let php_folding=1             " PHP
" let r_syntax_folding=1        " R
" let ruby_fold=1               " Ruby
" let sh_fold_enabled=1         " sh
" let vimsyn_folding='af'       " Vim script
" let xml_syntax_folding=1      " XML

"indent-guides
let g:indent_guides_auto_colors=1
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
