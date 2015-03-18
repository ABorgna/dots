set nocompatible

set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
set autoread
set showmode
set history=1000
set showcmd
 

" ================ Search ===========================

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally

" ================ Indentation ======================

set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·
 
" =============== Advanced ==========================
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

syntax on

"
" ================ Scrolling ========================
set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
    endif

