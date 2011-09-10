" This prevents a \n being added by vim at the end of every file
autocmd FileType php setlocal noeol "fileformat=dos "binary

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
	set fileencodings=utf-8,latin1
endif

" Use Vim defaults (much better!) also required for snippets
set nocompatible 

" Turn filetypes on and set phtml & inc file to be of type php
filetype on
" Zend template files
au BufNewFile,BufRead *.phtml set filetype=html.php.js.css
" QB class files
au BufNewFile,BufRead *.inc set filetype=php
" Added following 3 lines for drupal modules
au BufNewFile,BufRead *.module set filetype=php
au BufRead,BufNewFile *.install set filetype=php
autocmd BufRead,BufNewFile *.test set filetype=php
" Standard
au BufNewFile,BufRead *.php set filetype=php.html.js.css
au BufNewFile,BufRead *.js set filetype=javascript
" Added this bc my snippets plugin said to
:filetype plugin on
:helptags ~/.vim/doc

" Set tab & auto indent to 4 spaces also round indent to multiple of 'shiftwidth' for > and < commands
set expandtab
" set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set bs=indent,eol,start " allow backspacing over everything in insert mode

" Highlight search and enable incremental searching
set hlsearch
set incsearch

" Set indention, line numbers, and enable syntax highlighting
set ai
set smartindent
set number
syntax on

" Show line, column number, and relative position within a file in the status line
set ruler

" Scroll when cursor gets within 3 characters of top/bottom edge
set scrolloff=3

" Always show status line, even for one window
set laststatus=2
" A more informative status line
":set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%m/%d/%y\ -\ %H:%M\")}
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" Use with ctags
set tags=/home/quibids/includes/.tags

" Make a custom view for the file on exit (saves folds) and load view when opening file
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Go back to the position the cursor was on the last time this file was edited
au BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal g`\"" |
 \ endif

" F1-F5 is mapped to javadoc style documentation blocks
" THESE SHOULD BECOME CODE SNIPPETS
"map <F1> o/** * Page level doc block - short desc** Long description* @access public* @author Brad Belyeu <bbelyeu@quibids.com>* @copyright Copyright (c) 2011, QuiBids* @link URL* @example /path/to/example.php description* @todo information string* @version Version 1.0* @filesource**/
"map <F2> O/** * @see file.ext**/
"map <F3> O/** * Class level doc block name* Description* @package Quibids/Shopee* @category Model/View/Controller* @extends extensions/implements**/
"map <F4> O/** * Property Description* @var varname datatype description* @staticvar varname datatype description**/
"map <F5> O/** * Method level doc block* @param   $paramname datatype description* @return  returntype  description**/

map <F1> :set expandtab!<CR>
map <F2> :set list!<CR>
" Use F3 to toggle 'paste' mode
map <F3> :set paste!<CR>
" This is a code-folding shortcut. Will fold everything between { }.
map <F6> zfa}" Use F7 to toggle line numbers
" F7 & F8 are reserved for screen tabs

" Map PageUp & PageDown keys
map <PageUp> <CTRL-U>
map <PageDown> <CTRL-D>
imap <PageUp> <CTRL-O><CTRL-U>
imap <PageDown> <CTRL-O><CTRL-D>
set nostartofline

" Custom F9 script to create parens for functions & F10 for loops/conditionals
imap <F9> {}O
imap <F10> {}O

" Use omnifunc for autocompletion
:autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" This runs lint on your current working file to check for php syntax errors
:autocmd FileType php noremap ,l :w!<CR>:!php -l %<CR>
" This runs your script via the php cli
:autocmd FileType php noremap ,e :w!<CR>:!php %<CR>
" This runs codesniffer against your current open file
:autocmd FileType php noremap ,cs :w!<CR>:!phpcs --standard=PEAR %<CR>
" map ,t to create a new tab
map ,t <Esc>:tabnew<CR>
" map ,f to display all lines with keyword under cursor and ask which one to jump to
nmap ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" This is my 'Stamp' command. You can be at the beginning of a word and it will paste what is in your buffer over it.
nnoremap ,s diw"0P
" Lookup local php help files with lynx
map ,h :!lynx -editor=vi file:///usr/local/doc/php-net/indexes.html<CR>
" Close all folds
map ,z zM

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
:let Tlist_Auto_Open = 1
:let Tlist_Auto_Update = 1
:let Tlist_Enable_Fold_Column = 1
:let Tlist_Show_One_File = 1
:let Tlist_Sort_Type = "name"
:let Tlist_Exit_OnlyWindow = 1

" This allows my bash aliases & functions to work in vim
set shell=bash\ --login

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

set wrap
set linebreak

" Highlight chars that go over the 80-column limit
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%81v.*'
