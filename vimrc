"
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"
"
" @link https://github.com/gmarik/vundle#about
" The top of my vimrc is suggested by vundle

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle - required!
Bundle 'gmarik/Vundle.vim'

" original repos on github
Plugin 'SirVer/ultisnips'
" Only use YouCompleteMe on my macs b/c the ec2 servers can't compile it
let ismac=$MACRC
if ismac == 'true'
    Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bbelyeu/pylint.vim'
Plugin 'bbelyeu/vim-python' " custom ftplugin for Python
"Plugin 'fatih/vim-go'
Plugin 'fisadev/vim-isort'
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'mattn/gist-vim'
"Plugin 'mattn/webapi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'  " Syntax highlighting for lots of languages/filetypes
"Plugin 'sjl/gundo.vim'
"Plugin 'sukima/xmledit'
"Plugin 'terryma/vim-multiple-cursors'
"Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
"Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ShowMarks'
Plugin 'Vimjas/vim-python-pep8-indent' " modifies Vim’s indentation behavior to comply with PEP8

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
" Make tabs, trailing whitespace, and non-breaking spaces visible, idk why
" it's set like this, but I couldn't get it to work otherwise...
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set matchtime=5 " Jump to matching bracket for 5/10th of a second (works with showmatch)
set nocursorline
set noeol "This prevents a \n being added by vim at the end of the file
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline))"
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

        " NerdTree is commented out b/c it was causing bugs with my . redo command
        " Open NERD tree if no files were specified when starting vim
        autocmd vimenter * if !argc() | NERDTree | endif
        " Got this from Kevin to close NERDTree if it's the last window open
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

        " Use shell's pylinter
        autocmd FileType python compiler pylint
        " Call Flake8 on python file save
        autocmd BufWritePost *.py call Flake8()
    augroup END
endif

" -----------------
" Function key mappings
" -----------------

" imap <F1> Available
" <F2> is set to language specific lint in ftplugin
autocmd FileType python map <buffer> <F2> :call Flake8()<CR>
" Use F3 to toggle Gundo plugin
map <F3> :GundoToggle<CR>
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
    nnoremap <leader>goto :YcmCompleter GoTo<CR>
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
"
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
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    colorscheme solarized
catch
    echo 'Solarized not installed'
endtry

" ShowMarks Plugin
try
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
catch
    echo 'ShowMarks not installed'
endtry

" Ultisnips modified snippets dir
try
    let g:UltiSnipsSnippetsDir        = '~/.vim/mysnippets/'
    let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'mysnippets']
    " Modified expand trigger key binding to work nicely with YouCompleteMe
    let g:UltiSnipsExpandTrigger="<c-j>"
catch
    echo 'Ultisnips not installed'
endtry

" Configure Flake8 & Pep8 plugins
try
    let g:flake8_cmd="flake8"
    let g:flake8_show_quickfix=1
    let g:flake8_show_in_gutter=1
    let g:flake8_show_in_file=1
    let g:python_pep8_indent_multiline_string=-2
catch
    echo 'Unable to setup flake8 and pep8'
endtry

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
