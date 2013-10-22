" Install
" !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
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

Bundle 'gmarik/vundle'

" Explore files
Bundle 'scrooloose/nerdtree'

" Easy commenting
Bundle 'scrooloose/nerdcommenter'

" Syntax check on save
Bundle 'scrooloose/syntastic'

" Great status line
Bundle 'Lokaltog/vim-powerline'

" Color scheme
Bundle 'nanotech/jellybeans.vim'

" Press + to expand the visual selection and _ to shrink it.
Bundle 'terryma/vim-expand-region'

" yank history
Bundle 'vim-scripts/YankRing.vim'

" TODO
"Bundle 'vim-scripts/taglist.vim'
"Bundle 'mattn/emmet-vim'

filetype plugin on
filetype plugin indent on
filetype on
syntax on

" Plugin options
let g:jellybeans_background_color_256='256'
let g:syntastic_cpp_compiler_options = ' -std=c++0x'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

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
" {{{ syntax
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
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

" Stop highlighting search
map <C-C> :nohlsearch<cr>

" Dompter le tigre
noremap <leader>ms :silent! :make -j4 \| :redraw! \| :botright :cw<cr>
noremap <leader>mk :make<cr>

" Comment
"nmap <F6> ^2xj
"nmap <F5> I//<Esc>j

" Clean dirty disgusting pig stuff
map <leader>ric :retab<cr>gg=G<cr>:%s/[\r \t]\+$//<cr>

" Nerdtree
noremap <leader>nt :NERDTreeToggle<cr>

" Synstastic errors
noremap <leader>e :Errors<cr>

" Split resize (pretty lame)
noremap <leader>k :resize +2<cr>
noremap <leader>j :resize -2<cr>
noremap <leader>h :vertical resize +2<cr>
noremap <leader>l :vertical resize -2<cr>

" Faster way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>ex :!%:p<cr>

" Rename current file
map <Leader>n :call RenameFile()<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Show yanks
map <leader>ys :YRShow

" Override vim commands 'gf', '^Wf', '^W^F'
nnoremap gf :call GotoFile("")<CR>
nnoremap <C-W>f :call GotoFile("new")<CR>
nnoremap <C-W><C-F> :call GotoFile("new")<CR>

" }}}
