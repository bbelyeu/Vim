"
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"

set nocompatible               " be iMproved

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Only use YouCompleteMe on my macs b/c some servers can't compile it
let ismac=$MACRC
if ismac == 'true'
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
endif
Plug 'airblade/vim-gitgutter'
Plug 'bbelyeu/vim-colors-solarized'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'fisadev/vim-isort'
Plug 'junegunn/fzf.vim', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'majutsushi/tagbar'
"Plug 'mattn/gist-vim'
"Plug 'mattn/webapi-vim'
"Plug 'mechatroner/rainbow_csv'
Plug 'mrk21/yaml-vim', { 'for': 'yaml' }
Plug 'powerline/powerline', { 'rtp': 'powerline/bindings/vim/' }
Plug 'psf/black', { 'branch': 'stable' }
Plug 'python-mode/python-mode'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'sheerun/vim-polyglot'  " Syntax highlighting for lots of languages/filetypes
"Plug 'sjl/gundo.vim'
"Plug 'terryma/vim-multiple-cursors'
"Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'udalov/kotlin-vim', { 'for': 'kotlin' }
Plug 'vim-scripts/ShowMarks'
"Plug 'vim-syntastic/syntastic'
Plug 'SirVer/ultisnips'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" change the mapleader from \ to , it's important that this
" is at/near the top of the file so that other mapped comamnds
" use this leader
let mapleader=","

" =========
" Setup vim
" =========
set ai
set background=dark
set bs=indent,eol,start " allow backspacing over everything in insert mode
set cmdheight=2 " Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue
set colorcolumn=100
set confirm " Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set copyindent
set expandtab
set fileformats+=dos " get rid of newline at end of file
set laststatus=2 " Always display the statusline in all windows
set lazyredraw " Try to make window quit flashing so much
set linebreak
set list
set matchtime=5 " Jump to matching bracket for 5/10th of a second (works with showmatch)
set nocursorline
set noeol "This prevents a \n being added by vim at the end of the file
set number
set scrolloff=3 " Scroll when cursor gets within 3 characters of top/bottom edge
set shell=bash\ --login " This allows my bash aliases & functions to work in vim
set shiftround " round indent to multiple of 'shiftwidth' for > and < commands
set shiftwidth=4
set showmatch " When a bracket is inserted, briefly jump to a matching one
set showtabline=2 " show tab line all the time
set smartindent
set softtabstop=4
set spell spelllang=en_us " https://robots.thoughtbot.com/vim-spell-checking
set tabstop=4
set tags=./.tags; " Custom ctags file
" Set viminfo to remember things between sessions...
" '20  - remember marks for 20 previous files
" \"100 - save 100 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"100,:20,%,n~/.viminfo
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.mo,htmlcov/*,.git/*,*.swp " Exclude files and directories
set wildmenu " Use menu to show command-line completion (in 'full' case)
" Set wildmode command-line completion mode:
"   - on first <Tab>, when more than one match, list all matches and complete
"     the longest common  string
"   - on second <Tab>, complete the next full match and show menu
set wildmode=list:longest,full
set wrap

" =======================================
" Conditional sets - not always available
" =======================================

" If Python file, check if inside a virtualenv, and if so use it
" I know the indenting looks weird, but according to the docs EOF *CANNOT* be preceded by
" whitespace. See http://vimdoc.sourceforge.net/htmldoc/if_pyth.html
" Note: Pymode is now doing this for me, but I'm leaving it here in case I remove python-mode
" Note: Other Python plugins still need the virtualenv (like vim-isort) so
" adding it back
python3 << EOF
import os
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    try:
        execfile(activate_this, dict(__file__=activate_this))  # python2
    except NameError:
        exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" xterm improvements
if &term=="xterm"
    set t_Co=8
    set t_Sb=^[[4%dm
    set t_Sf=^[[3%dm
endif

" Highlight search and enable incremental searching when vim has colors
if &t_Co > 2 || has("gui_running")
    set hlsearch
    set incsearch
endif

" Encodings
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

" Only do this part when compiled with support for autocommands
if has("autocmd")
    " Create a group to namespace my autocmds
    augroup BradCustom
        " Set .bash files to shell script
        autocmd BufNewFile,BufRead *.bash set filetype=sh
        " From bash-support docs
        let g:BASH_AlsoBash = [ '*.SlackBuild' , 'rc.*' ]

        " Make a custom view for the file on exit (saves folds) and load view when opening file
        autocmd BufWinLeave ?* mkview
        autocmd BufWinEnter ?* silent loadview

        " Open NERD tree if no files were specified when starting vim
        autocmd vimenter * if !argc() | NERDTree | endif
        " Close NERDTree if it's the last window open
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
        " Close Quickfix window if it is the last buffer open
        autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix" | quit | endif

        " Use shell's pylinter
        " autocmd FileType python compiler pylint
        " Call Black on python file save
        autocmd BufWritePost *.py execute ':Black'
        " YouCompleteMe is not longer enabled by default? Not sure why.
        autocmd BufWinEnter *.py execute ':call youcompleteme#Enable()'
        autocmd BufWinEnter *.go execute ':call youcompleteme#Enable()'
        autocmd BufWinEnter *.php execute ':call youcompleteme#Enable()'
        autocmd BufWinEnter *.js execute ':call youcompleteme#Enable()'

    augroup END

    augroup MyGroup
        autocmd!
        if exists('##QuitPre')
            autocmd QuitPre * if &filetype != 'qf' | silent! lclose | endif
        endif
    augroup END
endif

" -----------------
" Function key mappings
" -----------------

" <F1> is set to language specific help in ftplugin
" <F2> is set to language specific lint in ftplugin
" Use F3 to hide tab character
map <F3> :set listchars=tab:\ \ <CR>
" Toggle Nerd Tree plugin
map <F4> :NERDTreeToggle<CR>
" Toggle Tag bar plugin
map <F5> :TagbarToggle<CR>
" <F6> is used for language specific code-folding shortcut
" F7 & F8 are reserved for screen/tmux tab movement
" F9 & F10 are language specific

" -----------------
" Leader mappings
" -----------------

" cd to the local dir that your file being edited is in
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" Toggle cursor line
nnoremap <leader>cl :set cursorline!<CR>
" Copy currently edited file to dev server
map <leader>cp :!~/bin/rsync_dev.sh<CR>
" map <leader>f to display all lines with keyword under cursor and ask which one to jump to
nmap <leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" Customize YouCompleteMe Setup
if !empty($MACRC)
    nnoremap <leader>g2 :YcmCompleter GoTo<CR>
endif
" This is my 'Stamp' command. You can be at the beginning of a word and it will paste what is in your buffer over it.
nnoremap <leader>s diw"0P
" Remove trailing whitespace from all lines
map <leader>rmtw :%s/\s\+$//<CR>
" Get a timestamp
nmap <leader>t "=strftime('%s')<C-M>p"
" Close all folds
map <leader>z zM
" Go to next quickfix result
nnoremap <leader>qn :cn<CR>
" Close quickfix result window
nnoremap <leader>qc :ccl<CR>
nnoremap <leader>ch <C-w>k:q<CR>

" -----------------
" Other mappings
" -----------------

" Remap window movements
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Stop that stupid window from popping up!!!
map q: :q

" This rewires n and N to do the highlighting
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" Swap : and ; to make colon commands easier to type
nnoremap  ;  :
"nnoremap  :  ;

" Swap " and ' in insert mode to make it easier to be compatible with Python's Black
" formatter. I decided to put in here instead of my vim-python plugin so I
" could get used to it in all files.
inoremap  '  "
inoremap  "  '

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" -----------------
" Configure Plugins
" -----------------

" Set path for FZF
set rtp+=/usr/local/opt/fzf

" Solarized plugin
try
    let g:solarized_termtrans=1
    let g:solarized_contrast="medium"
    let g:solarized_visibility="medium"
    colorscheme solarized

    " ShowMarks support in Solarized, better looking SignColumn
    hi! link SignColumn   LineNr
    hi! link ShowMarksHLl DiffAdd
    hi! link ShowMarksHLu DiffChange
    hi! link ShowMarksHLo DiffAdd
    hi! link ShowMarksHLm DiffChange
catch
    echo 'Solarized not installed'
endtry

" ShowMarks Plugin
try
    let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let g:showmarks_enable = 1
catch
    echo 'ShowMarks not installed'
endtry

" Python Mode (Pymode) Plugin
try
    " Work around Python mode error b/c of Python version
    " see https://github.com/python-mode/python-mode/issues/908
    let g:pymode_python = 'python3'
catch
    echo 'Python-mode not installed'
endtry

" Ultisnips modified snippets dir
try
    let g:UltiSnipsUsePythonVersion = 3
    let g:UltiSnipsSnippetsDir        = '~/.vim/mysnippets/'
    let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'mysnippets']
    " Modified expand trigger key binding to work nicely with YouCompleteMe
    let g:UltiSnipsExpandTrigger="<c-j>"
catch
    echo 'Ultisnips not installed'
endtry

" Configure Flake8 & Pep8 plugins
" try
"     let g:flake8_cmd="flake8"
"     let g:flake8_show_quickfix=1
"     let g:flake8_show_in_gutter=1
"     let g:flake8_show_in_file=1
"     let g:python_pep8_indent_multiline_string=-2
" catch
"     echo 'Unable to setup flake8 and pep8'
" endtry

" =============================
" Environment specific settings
" =============================

" If mac shell env var is set
if !empty($MACRC)
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

" Since I removed the autocorrect spelling plugin. There are a few
" autocorrections that I wanted to keep and added here.
ia hte the
ia thier their
ia enviroment environment
ia freind friend
ia toghether together
ia crowind crowdin
ia Crowind Crowdin
ia suceed succeed
ia sucees succees

" Check if already enabled so not to clobber any color highlighting already set up
if !exists("g:syntax_on")
    syntax enable
endif

" Set color for colorcolumn
highlight ColorColumn ctermbg=235 guibg=#2c2d27

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

" Remove > char from representing tabs
" Not sure why this isn't working
if &filetype ==# 'go'
    setlocal listchars=tab:\ \ 
endif

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" js stuff for web
autocmd FileType js setlocal ts=2 sts=2 sw=2 expandtab
