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

" Disable beep
set visualbell
set t_vb=

let g:is_posix = 1

" leader on , and space
let mapleader=','
map <space> ,

" }}}
"{{{ Windows

let windows = has("win32") || has("win64")

if has("gui")
    " GUI font
    set guifont=Ubuntu_Mono:h14

    "remove menu bar
    set guioptions-=m

    "remove toolbar
    set guioptions-=T

    "remove right-hand scroll bar
    set guioptions-=r

    " Allways have block cursor
    set guicursor=n-c-v-i:block
endif

""}}}
" Plugins {{{

filetype off

if windows
    set rtp+=~/vimfiles/bundle/vundle/
    call vundle#rc('$HOME/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
endif

" Vim bundle manager
Bundle 'gmarik/vundle'

" Explore files
Bundle 'scrooloose/nerdtree'
if !windows
    Bundle 'kien/ctrlp.vim'
endif

" Easy commenting
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-commentary'

" Compile check on save
if !windows
    Bundle 'scrooloose/syntastic'
endif

" Plugin for deleting, changing, and adding surroundings
Bundle 'tpope/vim-surround'

" Press + to expand the visual selection and _ to shrink it.
Bundle 'terryma/vim-expand-region'

" Yank history
if !windows
    "Bundle 'vim-scripts/YankRing.vim'
endif

" Plugin that helps to end certain structures automatically
Bundle 'tpope/vim-endwise'
Bundle 'kana/vim-smartinput'

" Allign stuff
Bundle 'godlygeek/tabular'

" Makes . command work after a plugin map
Bundle 'tpope/vim-repeat'

" A colorful, dark color scheme
Bundle 'nanotech/jellybeans.vim'
Bundle 'altercation/vim-colors-solarized'

" Great status line
Bundle 'Lokaltog/vim-powerline'

" Git wrapper
Bundle 'tpope/vim-fugitive'

" Snipmate
Bundle "msanders/snipmate.vim"

" Syntax and completion stuffs
Bundle 'pangloss/vim-javascript'
Bundle 'othree/html5.vim'
Bundle 'sudar/vim-arduino-syntax'
Bundle 'hynek/vim-python-pep8-indent'
Bundle 'hdima/python-syntax'
Bundle 'leafgarland/typescript-vim'

filetype plugin on
filetype plugin indent on
filetype on
syntax on

" }}}
" {{{ Plugin options/mappings

if windows
    let g:yankring_history_dir = '$HOME/vimfiles/tmp'
else
    let g:yankring_history_dir = '~/.vim/tmp'
endif

let g:jellybeans_background_color_256='256'

let g:syntastic_cpp_compiler_options = ' -std=c++0x'
let g:syntastic_python_python_exe = 'python3'

let python_highlight_all = 1

let NERDTreeQuitOnOpen  = 0   " don't collapse NERDTree when a file is opened
let NERDTreeMinimalUI   = 0
let NERDTreeDirArrows   = 0
let NERDTreeChDirMode   = 0
let NERDTreeIgnore      = ['\.pyc$', '\.rbc$', '\~$']
let NERDTreeHijackNetrw = 0
let g:nerdtree_tabs_startup_cd = 0

" Nerdtree
map <leader>nt :NERDTreeToggle<cr>

" Tabular
map <leader>tb :Tabularize /

" CtrlP
let g:ctrlp_map = '<c-e>'
let g:ctrlp_cmd = 'CtrlP'

" Synstastic errors
map <leader>ee :Errors<cr>

" Show yanks
map <leader>ys :YRShow<cr>

" Git diff
map <leader>gd Gdiff<cr>

" Colorscheme
" set t_Co=256
" syntax enable
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized
colorscheme jellybeans

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
"
" Amazing '/'
set hlsearch
set smartcase
set incsearch
set ignorecase

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
set wrapmargin=0

" Insert spaces insted of tabs
set expandtab

" Indent options
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,ps,t0,(0,u0,)20,*80,g0

" Do not insert comment automatically 
autocmd FileType * setlocal fo-=c fo-=r fo-=o

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
au BufWrite *.py :call DeleteTrailingWS()

" You didn't see that
set mouse=ar
set mousemodel=extend
set mousefocus
set mousehide

" }}}
" {{{ Prettify

" Wrapped lines
set wrap

" For wrapped lines
set showbreak=\

" Spellcheking
" highlight SpellBad term=underline gui=undercurl

" Line numbers in insert mode and relative in command mode
set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Cool looking vertical splits
set fillchars=vert:│

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Show trailing whitespaces and tabs
set list
set listchars=tab:>\ ,trail:\ ,

" Vertical line at textwidth
set colorcolumn=+1

" Highlight cursor line
set cursorline
"
" Enable 256 color terminal
set t_Co=256

" Show matching brackets when text indicator is over them
set showmatch

" Magnificient folds
set foldenable
set foldlevel=99
set foldlevelstart=0
set foldmethod=marker

" }}}
" {{{ Functions / whitchcraft

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Keep undo history after closing vim/buffer
try
    if windows
        set undodir=~/_vim/tmp/undodir
    else
        set undodir=~/.vim/tmp/undodir
    endif
    set undofile
catch
endtry

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

" include colon in filenames (for gf)
set isfname+=:

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
    elseif
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

"Source .vimrc on close, kills my term...
"autocmd bufwritepost .vimrc source $MYVIMRC

" }}}
" {{{ Map

" Gold
map ; :

" Visual studio mode with vsvim
    "behave mswin

    " Backspace to delete visual selection
    vmap <BS> d

    " Getting rid of control commands (not really using UHL anyways)
    nmap vv <C-V>
    noremap U <C-R>
    nmap H <C-D>
    nmap L <C-U>

" Basic stuff
map <leader>w :w<cr>
map <leader>q :q<cr>
map <leader>x :x<cr>
map <leader>W :w!<cr>
map <leader>Q :q!<cr>
map <leader>X :x!<cr>

" Move up/down correctly in wrapped lines
map j gj
map k gk

" Paste !
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Keep visual mode during indenting
vmap > >gv
vmap < <gv

" Stop highlighting search
map <leader>nh :nohlsearch<cr>

" Dompter le tigre
map <leader>ms :silent! :make -j4 \| :redraw! \| :botright :cw<cr>
map <leader>mk :make<cr>

" Clean dirty disgusting pig stuff
map <leader>ric :retab<cr>gg=G<cr>:%s/[\r \t]\+$//<cr>

" Split resize #TODO
map <M-k> :resize +2<cr>
map <M-j> :resize -2<cr>
map <M-h> :vertical resize +2<cr>
map <M-l> :vertical resize -2<cr>

" Faster way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Execute current file
map <leader>ef :!clear<cr>:!%:p<cr>

" Execute current file | less
" map <leader>el :!clear<cr>:!%p<cr>

" Rename current file
map <Leader>mv :call RenameFile()<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Visual mode pressing * or # searches for the current selection
" " Super useful! From an idea by Michael Naumann
vmap <silent> * :call VisualSelection('f')<cr>
vmap <silent> # :call VisualSelection('b')<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Override vim commands 'gf', '^Wf', '^W^F'
nmap gf :call GotoFile("")<cr>
nmap <C-W>f :call GotoFile("new")<cr>
nmap <C-W><C-F> :call GotoFile("new")<cr>

" Arduino
map <leader>ia :!sudo ino build && sudo ino upload && sudo ino serial<cr>
map <leader>iu :!sudo ino build && sudo ino upload<cr>
map <leader>is :!sudo ino serial<cr>
map <leader>ib :!sudo ino build<cr>

" Use :W! to write to a file using sudo if you forgot to 'sudo vim file'
cmap W! %!sudo tee > /dev/null %

" Source vimrc
map <leader>so :source $MYVIMRC<cr>

" Select (charwise) the contents of the current line, excluding indentation.
map <leader>v ^vg_"

" Open .vimrc in a separated split
map <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Select (linewise) the text you just pasted (handy for modifying indentation)
map <leader>V V`]

" Reload file
map <leader>lf :edit!<cr>

" don't
map <up> <nop>
map <down> <nop>
map <right> <nop>
map <left> <nop>
map <tab> <nop>

" Python colon
au Filetype python iabbr def def:<left>
au Filetype python iabbr if if:<left>
au Filetype python iabbr while while:<left>
au Filetype python iabbr for for:<left>
au Filetype python iabbr with with:<left>
au Filetype python iabbr try try:<left>
au Filetype python iabbr except except:<left>
au Filetype python iabbr finally finally:<left>
au Filetype python iabbr else else:
au Filetype python iabbr elif elif:
" }}}
" {{{ Impractical vim
" start a a euler problem plugins kills Vimgolf... require commenter thingie

nmap <leader>se "ddiw:e ~/euler/problems.txt<cr>/Problem <c-r>"$<cr>V/Problem<cr>5ky:bp<cr>PV`]gc`]ji<cr>def p<esc>"dpa():<cr>ret = 0<cr>return ret<cr># <esc>a}<esc>..<esc>kO<esc>?Problem<cr>$a {{<del><del>{<del><esc>/ret = 0<cr>j<leader>nh

" }}}
