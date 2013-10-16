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

" Keep unsaved buffers
set hidden

" }}}
" Plugins {{{

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'nanotech/jellybeans.vim'

filetype plugin on
filetype plugin indent on
filetype on
syntax on

" Plugin options
let g:jellybeans_background_color_256='256'
let g:syntastic_cpp_compiler_options = ' -std=c++0x'

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

" Don't
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

" }}}
" {{{ Map

let mapleader=','

" Move up/down correctly in wrapped lines
noremap j gj
noremap k gk

" Paste !
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Stop highlighting search
map <C-C> :nohlsearch<cr>

" Gold
noremap ; :

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

" Paste mode
noremap <leader>pa :setlocal paste!<cr>

map <leader>xx :!%:p<cr>

" Rename current file
map <Leader>n :call RenameFile()<cr>

" }}}
