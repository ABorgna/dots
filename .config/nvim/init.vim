set nocompatible

let mapleader = ","
let maplocalleader = ";"
set number	" Show line numbers
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
set mouse=a
set cursorline
inoremap ., <Esc>

" ================ SpellCheck ===========================

hi SpellBad cterm=underline

" ================ Search ===========================

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set incsearch	" Searches for strings incrementally

" ================ Indentation ======================

set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=2	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=2	" Number of spaces per Tab
set tabstop=2

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" =============== Colors ============================
set t_Co=256
colorscheme badwolf
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" =============== Advanced ==========================
set ruler	" Show row and column ruler information

set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
set splitright
set splitbelow

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

" Terminal
tnoremap ., <C-\><C-n>

" I keep doing this...
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

" ================ Haskell ======================
autocmd FileType haskell set tabstop=2|set shiftwidth=2|set noautoindent|set colorcolumn=81
autocmd FileType haskell filetype plugin indent on

" ================ Plugins ==========================
call plug#begin('~/.config/nvim/plugged')

" ---- Themes
Plug 'sjl/badwolf'

" ---- Autocompletion
"Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer --omnisharp-completer'}
"Plug 'rdnetto/YCM-Generator', {'branch': 'stable'}
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" ---- Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ---- Haskell
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
"Plug 'Shougo/neocomplete.vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}

" ---- Navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'
Plug 'bitc/lushtags'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'

" ---- Others
"Plug '~/.config/nvim/plugin/autoclose.vim'
Plug 'lervag/vimtex'
Plug 'rhysd/vim-clang-format'
Plug 'Shougo/vimproc.vim'
Plug 'Rykka/riv.vim' " rst notes

if has('nvim')
    "Plug 'jalvesaq/Nvim-R'
else
    "Plug 'vim-scripts/Vim-R-plugin'
endif

call plug#end()

" ================ YouCompleteMe ====================
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_python_binary_path = '/usr/bin/python3'

" ================ Deoplete ====================
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

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

" ================ Neco-ghc ===========================
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" ================ Haskell-vim ===========================
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = 0
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 2
let g:haskell_indent_before_where = -2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 2
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1

" ================ Ctrl-p ===========================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" Ignore files in .gitignore
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" ================ Riv (rst files) ===========================
let g:riv_highlight_code = "lua,python,c,cpp,javascript,vim,sh,haskell"

