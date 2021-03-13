"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify where the plugins will live
call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Show git status on gutter
Plug 'airblade/vim-gitgutter'

" Better status line
Plug 'vim-airline/vim-airline'

" Directory tree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
          \  if isdirectory(expand('<amatch>'))
          \|   call plug#load('nerdtree')
          \|   execute 'autocmd! nerd_loader'
          \| endif
  augroup END

" Auto-complete
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable modern vim features
set nocompatible

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"

" Fast saving
nmap <leader>w :w!<cr>

" Default ctrlp to current dir as root
let g:ctrlp_working_path_mode = 0

" Update faster for vim-gitgutter
set updatetime=100

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable mouse
set mouse=a

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hidden

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Display line numbers
set number
set relativenumber

" Highlight trailing whitespace
set list listchars=tab:»·,trail:·

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set background=dark

" Highlight text longer than limit
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
augroup vimrc_autocmds
  autocmd BufNewFile,BufEnter * highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufNewFile,BufEnter *.h,*.cc,*.js,*.go,*.grammar,*.proto match OverLength /\%81v.*/
  autocmd BufNewFile,BufEnter match OverLength /\%101v.*/
augroup END

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Fix colour of gutter
highlight clear SignColumn
highlight DiffAdd    ctermfg=black ctermbg=green
highlight DiffChange ctermfg=black ctermbg=yellow
highlight DiffDelete ctermfg=black ctermbg=red

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set nowrap "Don't wrap lines

autocmd BufRead,BufNewFile *.html,*.json,*.css setlocal shiftwidth=2 tabstop=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Yank until end of line
noremap Y y$

" Remap VIM 0 to first non-blank character
noremap 0 ^

" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" <leader>n | NERD Tree
nnoremap <leader>n :NERDTreeToggle<cr>

""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""
" Always show the status line
" set laststatus=2

" Format the status line
" set statusline=%{HasPaste()} " paste status
" set statusline+=[%{getcwd()}] " working directory
" set statusline+=[%f] " full path to file
" set statusline+=%m " modified?
" set statusline+=%r " read only?
" set statusline+=%= " right align
" set statusline+=%y " file type
" set statusline+=[%P] " percentage through file
" set statusline+=[%l:%c] " line number : column number
" set statusline+=[%{mode()}] " current mode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcut for 'default' macro register
nnoremap <space> @q
nnoremap Q @q

" Delete trailing white space, useful for Python and CoffeeScript
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
noremap <leader>tw :call DeleteTrailingWS()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>

" shortcut to edit .vimrc
:nnoremap <leader>ev :tabe $MYVIMRC<cr>

" shortcut to source .vimrc file
:nnoremap <leader>sv :source $MYVIMRC<cr>

" add quotes around current word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Toggle distraction free mode
let s:distractionFree = 0
function! ToggleDistractionFree()
    if s:distractionFree == 0
        let s:distractionFree = 1
        set noshowmode
        set noshowcmd
        set noruler
        set laststatus=0
        set nonumber
        set norelativenumber
        set showtabline=0
        if has("gui_running")
            set guioptions-=m "remove menu bar
            set guioptions-=r "remove right scrollbar
            set guioptions-=L "remove left scrollbar
        endif
    else
        let s:distractionFree = 0
        set showmode
        set showcmd
        set ruler
        set laststatus=2
        set number
        set relativenumber
        set showtabline=2
        if has("gui_running")
            set guioptions+=e "add tab line
            set guioptions+=m "add menu bar
            set guioptions+=r "add right scrollbar
            set guioptions+=L "add left scrollbar
        endif
    endif
endfunction
nnoremap <leader>df :call ToggleDistractionFree()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $FZF_DEFAULT_OPTS .= ' --inline-info'

nnoremap <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
noremap <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gi :YcmCompleter GoToImplementation<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source a global configuration file if available
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

