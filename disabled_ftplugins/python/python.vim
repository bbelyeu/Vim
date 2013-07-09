" Set folding settings
set foldnestmax=2
set foldlevel=1
set foldmethod=indent

" Set omnifunc for python
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Indentation options
let g:pyindent_open_paren = '&sw * 2'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw * 2'
