" Set folding settings
set foldlevel=99
set foldmethod=indent
"set foldmethod=syntax
"set foldminlines=3
"set foldnestmax=2
" Make tabs, trailing whitespace, and non-breaking spaces visible, idk why
" it's set like this, but I couldn't get it to work otherwise...
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"

" Only do this part when compiled with support for autocommands
if has("autocmd")
    augroup PythonCustom
        " Always Isort before writing
        autocmd BufWritePre :Isort

        " Setup Black
        try
            " Call Black on python file save
            autocmd BufWritePre *.py execute ':Black'
        catch
            echo 'Black not installed'
        endtry

        let g:SimpylFold_docstring_preview=1

        let g:ale_linters = {'python': 'all'}
        let g:ale_fixers = {'python': ['isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']}
        let g:ale_fix_on_save = 1
        let g:ale_set_quickfix = 1
        let g:ale_open_list = 1
    augroup END
endif

map <F1> "zyw:exe "!python -c 'help(".@z.")'""<CR>

" Only use these linters
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']

" let g:pymode_lint_checkers = ['pyflakes', 'pep8']
" let g:pymode_lint_ignore = "E501"
" Insert import for current word under cursor 'g:pymode_rope_autoimport_bind'
" Should be enabled 'g:pymode_rope_autoimport'
" let g:pymode_rope_autoimport_bind = '<C-c>ra'

" Disable Pymode folding b/c I get much better results I like from the settings above
" let g:pymode_folding = 0
" let g:pymode_options_max_line_length = 100
" let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
" let g:pymode_lint_options_pylint = {'max-line-length': g:pymode_options_max_line_length}
