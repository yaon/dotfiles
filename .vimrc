" Install
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" :BundleInstall

" {{{ Vim options
" Disable vi compatibility
set nocompatible

" Use utf-8
set encoding=utf-8

" Smoothness
set ttyfast
set lazyredraw

" Save when doing some commands
set autowrite

" no swp/~
set nobackup
set noswapfile

" Remember info about open buffers on close
set viminfo^=%

" Keep unsaved buffers
set hidden

" include colon in filenames (for gf)
set isfname+=:

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Keep undo history after closing vim/buffer
try
    set undodir=~/.vim/tmp/undodir
    set undofile
catch
endtry

" }}}
" Plugins {{{

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vim bundle manager
Bundle 'gmarik/vundle'

" Explore files
Bundle 'scrooloose/nerdtree'
Bundle 'kin/ctrlp.vim'

" Easy commenting
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-commentary'

" Compile check on save
Bundle 'scrooloose/syntastic'

" Plugin for deleting, changing, and adding surroundings
Bundle 'tpope/vim-surround'

" Press + to expand the visual selection and _ to shrink it.
Bundle 'terryma/vim-expand-region'

" Yank history
Bundle 'vim-scripts/YankRing.vim'

" Multiple visual cursors
Bundle 'terryma/vim-multiple-cursors'

" Plugin that helps to end certain structures automatically
Bundle 'tpope/vim-endwise'
Bundle 'kana/vim-smartinput'

" Allign stuff
Bundle 'godlygeek/tabular'

" Makes . command work after a plugin map
Bundle 'tpope/vim-repeat'

" A colorful, dark color scheme
Bundle 'nanotech/jellybeans.vim'

" Great status line
Bundle 'Lokaltog/vim-powerline'

"Git wrapper
Bundle 'tpope/vim-fugitive'

" Syntax and completion stuffs
Bundle 'pangloss/vim-javascript'
Bundle 'othree/html5.vim'
Bundle 'sudar/vim-arduino-syntax'

filetype plugin on
filetype plugin indent on
filetype on
syntax on

" Plugin options

let g:jellybeans_background_color_256='256'
let g:syntastic_cpp_compiler_options = ' -std=c++0x'

" NERDTree configuration
let NERDTreeQuitOnOpen  = 0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI   = 1
let NERDTreeDirArrows   = 0
let NERDTreeChDirMode   = 0
let NERDTreeIgnore      = ['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw = 0
let g:nerdtree_tabs_startup_cd = 0

" Nerdtree
noremap <leader>nt :NERDTreeToggle<cr>

" Tabular
noremap <leader>tb :Tabularize 

" CtrlP
let g:ctrlp_map = '<c-o>'
let g:ctrlp_cmd = 'CtrlO'

" Synstastic errors
noremap <leader>e :Errors<cr>

" Show yanks
map <leader>ys :YRShow<cr>

" }}}
" {{{ Bottom things

" Show line/column size of visuals
set showcmd

" History size for commands
set history=1000

" Show number of lines changed
set report=0

" Show status bar
set laststatus=2

" Enable ruler
set ruler

" Enable /g by default for substitution
set gdefault

" Completion for commands
set wildmenu
set wildmode=list,full
set wildignore=*.o,*~,*.pyc
set wildignorecase

" Leaving insert mode instantly
set ttimeout
set ttimeoutlen=1

" }}}
" {{{ Other

" Amazing '/'
set hlsearch
set smartcase
set incsearch
set ignorecase

" Magnificient folds
set foldenable
set foldlevel=99
set foldlevelstart=0
set foldmethod=marker

" This is not here
set mouse=ar
set mousemodel=extend
set mousefocus
set mousehide

" }}}
" {{{ Edit, motion, indent...

" Indent spaces
set shiftwidth=4

" Number of spaces in a tab
set tabstop=8

" Number of spaces inserted when pressing <TAB>
set softtabstop=4

" <TAB> goes to indent level
set smarttab

" Automatic indentation
set autoindent
set smartindent

" Break lines before 80th column
set textwidth=79

" Insert spaces insted of tabs
set expandtab

" Indent options
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,t0,(0,u0,)20,*80,g0

" Completion options
set complete=t,k,.,w,b,u,i

" Working backspace
set backspace=indent,eol,start

" Number of lines between cursor and edge
set scrolloff=5

" Motion stuff
set whichwrap=b,s,l,h,<,>,[,]

" Delte trailing whitespaces on save
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" }}}
" {{{ Prettify

" Wrapped lines
set wrap

" For wrapped lines
set showbreak=\

" Line numbers in insert mode and relative in command mode
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Cool looking vertical splits
set fillchars=vert:│

" Show trailing whitespaces and tabs
set list
set listchars=tab:>\ ,trail:\ 

" Vertical line at textwidth
set colorcolumn=+1

" Highlight cursor line
set cursorline
"
" Enable 256 color terminal
set t_Co=256

" Show matching brackets when text indicator is over them
set showmatch

" nice colorscheme
colorscheme jellybeans

" }}}
" {{{ Functions

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" ----- Emulate 'gf' but recognize :line format -----
function! GotoFile(w)
    let curword = expand("<cfile>")
    if (strlen(curword) == 0)
        return
    endif
    let matchstart = match(curword, ':\d\+$')
    if matchstart > 0
        let pos = '+' . strpart(curword, matchstart+1)
        let fname = strpart(curword, 0, matchstart)
    else
        let pos = ""
        let fname = curword
    endif
    " Open new window if requested
    if a:w == "new"
        new
    endif
    " Use 'find' so path is searched like 'gf' would
    execute 'find ' . pos . ' ' . fname
endfunction
" }}}
" {{{ Map

" leader on , and space
let mapleader=','
nmap <space> ,
vmap <space> ,

" Gold
noremap ; :

" Basic stuff
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>x :x<cr>

" Move up/down correctly in wrapped lines
noremap j gj
noremap k gk

" Paste !
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Keep visual mode during indenting
vmap > >gv
vmap < <gv

" Stop highlighting search
map <C-C> :nohlsearch<cr>

" Dompter le tigre
noremap <leader>ms :silent! :make -j4 \| :redraw! \| :botright :cw<cr>
noremap <leader>mk :make<cr>

" Clean dirty disgusting pig stuff
map <leader>ric :retab<cr>gg=G<cr>:%s/[\r \t]\+$//<cr>

" Split resize
noremap <M-k> :resize +2<cr>
noremap <M-j> :resize -2<cr>
noremap <M-h> :vertical resize +2<cr>
noremap <M-l> :vertical resize -2<cr>

" Faster way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Execute current file
map <leader>ef :!%:p<cr>

" Rename current file
map <Leader>mv :call RenameFile()<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<cr>
vnoremap <silent> # :call VisualSelection('b')<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Override vim commands 'gf', '^Wf', '^W^F'
nnoremap gf :call GotoFile("")<cr>
nnoremap <C-W>f :call GotoFile("new")<cr>
nnoremap <C-W><C-F> :call GotoFile("new")<cr>

" Arduino
map <leader>ia :!sudo ino build && sudo ino upload && sudo ino serial<cr>
map <leader>iu :!sudo ino build && sudo ino upload<cr>
map <leader>is :!sudo ino serial<cr>
map <leader>ib :!sudo ino build<cr>

" Use :W! to write to a file using sudo if you forgot to 'sudo vim file'
ca W! %!sudo tee > /dev/null %

" }}}
