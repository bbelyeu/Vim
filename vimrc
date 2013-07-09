" @link https://github.com/gmarik/vundle#about
" The top of my vimrc is suggested by vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle - required! 
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'Lokaltog/powerline'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'Raimondi/delimitMate'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bbelyeu/php-getter-setter.vim'
Bundle 'bbelyeu/vim-python'
Bundle 'ghewgill/vim-scmdiff'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'lepture/vim-jinja'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mileszs/ack.vim'
Bundle 'panozzaj/vim-autocorrect'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'troydm/pb.vim'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/ShowMarks'
Bundle 'vim-scripts/UltiSnips'
Bundle 'vim-scripts/nginx.vim'
Bundle 'vsushkov/vim-phpcs'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"
"
" The rest is my custom stuff
"
" change the mapleader from \ to , it's important that this
" is at/near the top of the file so that other mapped comamnds
" use this leader
let mapleader=","

" Set indention, line numbers, and enable syntax highlighting
set ai
" set smartindent " I think this was causing 2 tabs when used with pymode
set number
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=utf-8,latin1
endif

"This prevents a \n being added by vim at the end of the file
autocmd FileType php setlocal noeol
autocmd FileType python setlocal noeol
" Zend template files
au BufNewFile,BufRead *.phtml set filetype=html.php.js.css
" Added following 3 lines for drupal modules
au BufNewFile,BufRead *.module set filetype=php
au BufRead,BufNewFile *.install set filetype=php
autocmd BufRead,BufNewFile *.test set filetype=php
" Standard
au BufNewFile,BufRead *.php set filetype=php.html.js.css
au BufNewFile,BufRead *.js set filetype=javascript
au BufNewFile,BufRead *.py set filetype=python
" Jinja templating for json
au BufNewFile,BufRead *.json set filetype=jsonjinja

" Set tab & auto indent to 4 spaces also round indent to multiple of 'shiftwidth' for > and < commands
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set bs=indent,eol,start " allow backspacing over everything in insert mode

" Highlight search and enable incremental searching
set hlsearch
set incsearch

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" REPLACED MY CUSTOM STATUSLINE WITH POWERLINE PLUGIN
" Always show status line, even for one window
"set laststatus=2
" A more informative status line
":set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%m/%d/%y\ -\ %H:%M\")}
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Make a custom view for the file on exit (saves folds) and load view when opening file
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Go back to the position the cursor was on the last time this file was edited
au BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal g`\"" |
 \ endif

" imap <F1> Available
" <F2> is set to language specific lint in ftplugin
" Use F3 to toggle Gundo plugin
map <F3> :GundoToggle<CR>
" Toggle Nerd Tree plugin
map <F4> :NERDTreeToggle<CR>
" Toggle Tag bar plugin
map <F5> :TagbarToggle<CR>
" <F6> is used for language specific code-folding shortcut. Will fold everything between { }.
" F7 & F8 are reserved for screen/tmux tab movement
" F9 & F10 are language specific

" map <leader>f to display all lines with keyword under cursor and ask which one to jump to
nmap <leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" This is my 'Stamp' command. You can be at the beginning of a word and it will paste what is in your buffer over it.
nnoremap <leader>s diw"0P
" Close all folds
map <leader>z zM
" cd to the local dir that your file being edited is in
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" Copy currently edited file to dev server
map <leader>cp :!~/bin/rsync_dev.sh<CR>
" Setup find in buffer for cntrlp
nmap <leader>cb :CtrlPBufTagAll<CR>
nmap <leader>cm :CtrlPMixed<CR>
" Copied these from JT
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_mruf_relative = 1

" When a bracket is inserted, briefly jump to a matching one
set showmatch
" Jump to matching bracket for 5/10th of a second (works with showmatch)
set matchtime=5

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"100 - save 100 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"100,:20,%,n~/.viminfo

" Use menu to show command-line completion (in 'full' case)
set wildmenu
" Set command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" show tab line all the time
set showtabline=2

" Open Tag list when vim opens and close it when file is closed
"let Tlist_Auto_Open = 1
let Tlist_Auto_Update = 1
let Tlist_Enable_Fold_Column = 1
"let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Ctags_Cmd = "/opt/local/bin/ctags"

" This allows my bash aliases & functions to work in vim
set shell=bash\ --login

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
" Commented this out b/c it broke MacOS copy/paste with mouse
"set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

set wrap
set linebreak

" Highlight chars that go over the 80-column limit
":highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
":match OverLength '\%121v.*'
" Changed the 2 above lines to only use a colorcolumn instead of highlighting all code beyond column count
set colorcolumn=80

" --------------------
" ShowMarks Plugin
" --------------------
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen

" -------------------------------------------
" Set a highlight on the cursors current line
" -------------------------------------------
" Even better only set the cursor inside the active window
"autocmd WinEnter * setlocal cursorline
"autocmd WinLeave * setlocal nocursorline
:hi CursorLine   cterm=NONE ctermbg=LightGrey
"ctermfg=white guibg=darkred guifg=white
":hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <leader>cl :set cursorline!<CR>
" Disabled this b/c I found it annoying
set nocursorline

" Fix Mac issue with not being able to write/create a crontab
" @link http://vim.wikia.com/wiki/Editing_crontab
au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" Open NERD tree if no files were specified when starting vim
autocmd vimenter * if !argc() | NERDTree | endif

" Remap window movements
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Got this from Kevin to close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Powerline
source /Library/Python/2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim

" COMMENTED THIS OUT B/C IT WAS ANNOYING WHEN IT ALWAYS PUT YOUR VIM DELETES
" IN THE MAC PASTEBOARD
" Added this line for vim 7.3 on Mac to support using Mac's clipboard
" set clipboard=unnamed

" Ultisnips modified snippets dir
let g:UltiSnipsSnippetsDir        = '~/.vim/snippets/'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'snippets']
" Modified expand trigger key binding to work nicely with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"
