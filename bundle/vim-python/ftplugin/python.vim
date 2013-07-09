" Set folding settings
set foldnestmax=2
set foldlevel=1
set foldmethod=indent

" Set omnifunc for python
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Indentation options
let g:pyindent_open_paren = '&sw'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw'

"This prevents a \n being added by vim at the end of the file
setlocal noeol

" Only use these 2 linters
let g:pymode_lint_checker = "pyflakes,pep8"
