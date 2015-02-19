" @link https://github.com/gmarik/vundle#about
" The top of my vimrc is suggested by vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle - required!
Bundle 'gmarik/Vundle.vim'

" original repos on github
Plugin 'Lokaltog/powerline'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
" Only use YouCompleteMe on my macs b/c the ec2 servers can't compile it
if !empty($MACRC)
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bbelyeu/php-getter-setter.vim'
Plugin 'bbelyeu/vim-python'
Plugin 'bbelyeu/vim-custom'
Plugin 'ghewgill/vim-scmdiff'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'lepture/vim-jinja'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'panozzaj/vim-autocorrect'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'rking/ag.vim'
Plugin 'ryanss/vim-hackernews'
"Plugin 'scrooloose/nerdtree'
" For some reason nerdtree is screwing up my . redo commands!!!
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'troydm/pb.vim'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/ShowMarks'
Plugin 'vim-scripts/nginx.vim'
Plugin 'vsushkov/vim-phpcs'

call vundle#end()
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
" The rest is my custom stuff

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

" change the mapleader from \ to , it's important that this
" is at/near the top of the file so that other mapped comamnds
" use this leader
let mapleader=","

" Set indention, line numbers, and enable syntax highlighting
set ai
set smartindent
set copyindent
set number
syntax enable
set background=dark

" =========================
" Solarized plugin
" Customize solarized theme
" =========================
let g:solarized_termtrans=1
let g:solarized_contrast="high"
let g:solarized_visibility="high"
colorscheme solarized

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Create a group to namespace my autocmds
    augroup BradCustom
        " Zend template files
        autocmd BufNewFile,BufRead *.phtml set filetype=html.php.js.css
        " Added following 3 lines for drupal modules
        autocmd BufNewFile,BufRead *.module set filetype=php
        autocmd BufRead,BufNewFile *.install set filetype=php
        autocmd BufRead,BufNewFile *.test set filetype=php
        " Standard
        autocmd BufNewFile,BufRead *.php set filetype=php.html.js.css
        autocmd BufNewFile,BufRead *.js set filetype=javascript
        autocmd BufNewFile,BufRead *.py set filetype=python
        " Jinja templating for json
        autocmd BufNewFile,BufRead *.json set filetype=jsonjinja

        " Make a custom view for the file on exit (saves folds) and load view when opening file
        autocmd BufWinLeave ?* mkview
        autocmd BufWinEnter ?* silent loadview

        " Go back to the position the cursor was on the last time this file was edited
        autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

        " -------------------------------------------
        " Set a highlight on the cursors current line
        " -------------------------------------------
        " Even better only set the cursor inside the active window
        "autocmd WinEnter * setlocal cursorline
        "autocmd WinLeave * setlocal nocursorline
        ":hi CursorLine   cterm=NONE ctermbg=LightGrey
        "ctermfg=white guibg=darkred guifg=white
        ":hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
        " Disabled this b/c I found it annoying

        " Open NERD tree if no files were specified when starting vim
        autocmd vimenter * if !argc() | NERDTree | endif
        " Got this from Kevin to close NERDTree if it's the last window open
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    augroup END
endif

" Set tab & auto indent to 4 spaces also round indent to multiple of 'shiftwidth' for > and < commands
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set bs=indent,eol,start " allow backspacing over everything in insert mode

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
    syntax on
    " Highlight search and enable incremental searching
    set hlsearch
    set incsearch
endif

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline))"

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
" map <leader>h to Dash search of word currently under cursor
nmap <silent> <leader>h :Dash<CR>
" This is my 'Stamp' command. You can be at the beginning of a word and it will paste what is in your buffer over it.
nnoremap <leader>s diw"0P
" Get a timestamp
nmap <leader>t "=strftime('%s')<C-M>p"
" Close all folds
map <leader>z zM
" cd to the local dir that your file being edited is in
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" Copy currently edited file to dev server
map <leader>cp :!~/bin/rsync_dev.sh<CR>
" Setup find in buffer for cntrlp
nmap <leader>cb :CtrlPBufTagAll<CR>
nmap <leader>cm :CtrlPMixed<CR>
" Toggle cursor line
nnoremap <leader>cl :set cursorline!<CR>
" Go to next quickfix result
nnoremap <leader>qn :cn<CR>
" Close quickfix result window
nnoremap <leader>qc :ccl<CR>
" Sort
map <leader>so :sort<CR>
" Remove trailing whitespace from all lines
map <leader>rmtw :%s/\s\+$//<CR>
" Customize YouCompleteMe Setup
if !empty($MACRC)
    nnoremap <leader>goto :YcmCompleter GoTo<CR>
endif

" ============
" Ctrlp plugin
" ============
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_mruf_relative = 1

" When a bracket is inserted, briefly jump to a matching one
set showmatch
" Jump to matching bracket for 5/10th of a second (works with showmatch)
set matchtime=5

" Remember things between sessions
"
" '50  - remember marks for 20 previous files
" \"100 - save 100 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='50,\"100,:20,%,n~/.viminfo

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

" This allows my bash aliases & functions to work in vim
" Also vim doesn't work well with Fish shell so this fixes that
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
set colorcolumn=100
" Set color for colorcolumn
highlight ColorColumn ctermbg=235 guibg=#2c2d27
" If you only want to show it on lines that exceed 100 chars use the following line instead
"call matchadd('ColorColumn', '\%81v', 100)

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

set nocursorline

" Remap window movements
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Ultisnips modified snippets dir
let g:UltiSnipsSnippetsDir        = '~/.vim/mysnippets/'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'mysnippets']
" Modified expand trigger key binding to work nicely with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"

" Found the following features @link http://programming.oreilly.com/2013/10/more-instantly-better-vim.html
highlight WhiteOnRed ctermbg=white ctermfg=darkred
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

"====[ Swap : and ; to make colon commands easier to type ]======
nnoremap  ;  :
"nnoremap  :  ;

" Fix terminal timeout when pressing escape
" https://powerline.readthedocs.org/en/latest/tipstricks.html
if ! has('gui_running')
    if has("autocmd")
        set ttimeoutlen=10
        augroup FastEscape
            autocmd!
            autocmd InsertEnter * set timeoutlen=0
            autocmd InsertLeave * set timeoutlen=1000
        augroup END
    endif
endif

set tags=tags;

" If mac shell env var is set
if !empty($MACRC)
    " Dash configuration
    " https://github.com/rizzatti/dash.vim/blob/master/doc/dash.txt
    let g:dash_map = {
            \ 'ruby'       : 'rails',
            \ 'python'     : 'python2'
            \ }

    " Powerline
    source $HOME/src/powerline/powerline/bindings/vim/plugin/powerline.vim

    augroup BradMacCustom
        " Fix Mac issue with not being able to write/create a crontab
        " @link http://vim.wikia.com/wiki/Editing_crontab
        autocmd BufEnter /private/tmp/crontab.* setl backupcopy=yes
    augroup END
endif

" If my server env var is set
if !empty($SERVERRC)
    if has("autocmd")
        augroup BradLinuxCustom
            " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
            autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
            " start with spec file template
            autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
        augroup END
    endif

    if has("cscope") && filereadable("/usr/bin/cscope")
        set csprg=/usr/bin/cscope
        set csto=0
        set cst
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
            cs add $PWD/cscope.out
            " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            cs add $CSCOPE_DB
        endif
        set csverb
    endif
endif

" xterm improvements
if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif

" customize pymode
let g:pymode_options_max_line_length = 100
let g:pymode_trim_whitespaces = 1

" get rid of newline at end of file
set fileformats+=dos
