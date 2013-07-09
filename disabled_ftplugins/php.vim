" PHP specific vimrc settings

" Use with ctags
set tags=~/.vim/tags

" Show function documentation
map <F2> "zyw:exe "!php --rfunction ".@z.""<CR>
" Use to fold up a function
map <F6> zfa}
" Custom F9 script to create parens for functions & F10 for loops/conditionals
imap <F9> {}O
" Commented out F10 b/c of yv standards
imap <F10> {}O

" Use omnifunc for autocompletion
":autocmd FileType php set omnifunc=phpcomplete#CompletePHP
set omnifunc=phpcomplete#CompletePHP

" Lookup local php help files with lynx
map <leader>h :!lynx -editor=vi file:///usr/local/doc/php-net/indexes.functions.html<CR>
" Run phpunit tests
"map ,p :!phpunit -c /home/quibids/tests/Ares/phpunit.xml %<CR>
" Lint the file for syntax errors
map <leader>l :w!<CR>:!php -l %<CR>
" This runs your script via the php cli
map <leader>e :w!<CR>:!php %<CR>
" This runs codesniffer against your current open file
map <leader>cs :w!<CR>:!phpcs --standard=PEAR %<CR>

" Set vim make command to work with php lint 
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

" Highlight SQL syntax in strings
let php_sql_query=1
