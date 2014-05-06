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
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bbelyeu/php-getter-setter.vim'
Bundle 'bbelyeu/vim-python'
Bundle 'bbelyeu/vim-custom'
" Bundle 'derekwyatt/vim-scala'
Bundle 'ghewgill/vim-scmdiff'
Bundle 'hallettj/jslint.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'lepture/vim-jinja'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'panozzaj/vim-autocorrect'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'troydm/pb.vim'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/ShowMarks'
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
" The rest is my custom stuff
"
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

set encoding=utf-8

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

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline))"

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
set nocursorline

" Open NERD tree if no files were specified when starting vim
autocmd vimenter * if !argc() | NERDTree | endif
" Got this from Kevin to close NERDTree if it's the last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Remap window movements
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Ultisnips modified snippets dir
let g:UltiSnipsSnippetsDir        = '~/.vim/snippets/'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'snippets']
" Modified expand trigger key binding to work nicely with YouCompleteMe
let g:UltiSnipsExpandTrigger="<c-j>"

" Delete trailing white space on save, useful for Python
" Copied this function from Josh's vimrc
" func! DeleteTrailingWS()
"     exe "normal mz"
"     %s/\s\+$//ge
"     exe "normal `z"
" endfunc
" autocmd BufWrite *.py :call DeleteTrailingWS()
" autocmd BufWrite *.php :call DeleteTrailingWS()`"

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
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

set tags=tags;

if !empty($MACRC)
    " Dash configuration
    " https://github.com/rizzatti/dash.vim/blob/master/doc/dash.txt
    let g:dash_map = {
            \ 'ruby'       : 'rails',
            \ 'python'     : 'python2'
            \ }

    " Powerline
    source $HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/plugin/powerline.vim

    " Fix Mac issue with not being able to write/create a crontab
    " @link http://vim.wikia.com/wiki/Editing_crontab
    au BufEnter /private/tmp/crontab.* setl backupcopy=yes
endif
