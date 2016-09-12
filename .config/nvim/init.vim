set nocompatible

let mapleader = ","
let maplocalleader = ";"
set number	" Show line numbers
set relativenumber
set linebreak	" Break lines at word (requires Wrap lines)
set showmatch	" jighlight matching brace
set visualbell	" Use visual bell (no beeping)
set autoread
set showmode
set history=1000
set showcmd
set browsedir=buffer
set wildmenu    " Show command autocomplete in a menu
set clipboard=unnamed
inoremap ., <Esc>

" ================ Search ===========================

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set incsearch	" Searches for strings incrementally

" ================ Indentation ======================

set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
set tabstop=4

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" =============== Colors ============================
set t_Co=256
colorscheme monokai

" =============== Advanced ==========================
set ruler	" Show row and column ruler information

set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

syntax on

" ================ Scrolling ========================
set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Keys =============================

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
" Neovim workaround
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

nnoremap <silent> <C-A-k> :resize -1<CR>
nnoremap <silent> <C-A-j> :resize +1<CR>
nnoremap <silent> <C-A-h> :vertical resize -1<CR>
nnoremap <silent> <C-A-l> :vertical resize +1<CR>
" Neovim workaround
nnoremap <silent> <A-BS> :vertical resize -1<CR>

" I keep doing this >.<
command! W w

" ================ Directories ======================
set backup
silent !mkdir ~/.config/nvim/backups/back/ > /dev/null 2>&1
set backupdir=~/.config/nvim/backups/back/
silent !mkdir ~/.config/nvim/backups/swp/ > /dev/null 2>&1
set dir=~/.config/nvim/backups/swp/

" Persistent Undo
if has('persistent_undo')
    silent !mkdir ~/.config/nvim/backups/undo/ > /dev/null 2>&1
    set undodir=~/.config/nvim/backups/undo/
    set undofile
    endif

" ================ Plugins ==========================
call plug#begin('~/.config/nvim/plugged')

Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer --omnisharp-completer'}
Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
Plug '~/.config/nvim/plugin/autoclose.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'
Plug 'bitc/lushtags'
Plug 'rhysd/vim-clang-format'

if has('nvim')
    Plug 'jalvesaq/Nvim-R'
else
    Plug 'vim-scripts/Vim-R-plugin'
endif

call plug#end()

" ================ YouCompleteMe ====================
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" ================ GitGutter ========================
let g:gitgutter_updatetime = 750

" ================ Vimtex ===========================
let g:tex_flavor = 'latex'

" ================ NERDTree =========================
nnoremap <silent> <A-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-n> :NERDTreeFocus<CR>
let NERDTreeIgnore=['.lo$[[file]]','.la$[[file]]',  '.lo$[[file]]', '.o$[[file]]', '.pyc$[[file]]']
" Autoclose if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Autoopen when vim starts up with no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" ================ Tagbar ===========================
nmap <F8> :TagbarToggle<CR>

" ================ Clang-format ===========================
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \ "IndentWidth": 4,
            \ "AllowShortIfStatementsOnASingleLine": "false" }
let g:clang_format#detect_style_file = 1

