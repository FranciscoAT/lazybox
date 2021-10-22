" ##########################################################
" #                      ____        _                     #
" #   /\  /\_____      _|___ \/\   /(_)_ __ ___  _ __ ___  #
" #  / /_/ / _ \ \ /\ / / __) \ \ / / | '_ ` _ \| '__/ __| #
" # / __  / (_) \ V  V / / __/ \ V /| | | | | | | | | (__  #
" # \/ /_/ \___/ \_/\_/ |_____| \_/ |_|_| |_| |_|_|  \___| #
" #                                                        #
" ##########################################################

" --- Plugins ---
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'psf/black', {'tag': '19.10b0'}
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'Numkil/ag.nvim'

call plug#end()

" --- Common Configs ---
set number rnu
colorscheme gruvbox
nnoremap <CR> :noh<CR><CR>
let g:mapleader = ','

" CTRL P
let g:ctrlp_custom_ignore = 'venv\|typings\|__pycache__'

" --- Timeout ESC ---
set timeoutlen=1000 ttimeoutlen=0

" --- Surround ---
vnoremap <leader>1 <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>2 <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>3 <esc>`>a}<esc>`<i{<esc>
vnoremap <leader>4 <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>5 <esc>`>a'<esc>`<i'<esc>


" --- Markdown Preview ---

nmap <leader>P <Plug>MarkdownPreviewToggle

" --- Common leader ---
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>b :e#<CR>
nnoremap <leader>s :source $MYVIMRC<CR>

" --- Prose ---
function! Prose()
    map j gj
    map k gk
    set textwidth=80
endfunction

function! Unprose()
    map j j
    map k k
    set textwidth=0
endfunction

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)


" --- Common Editing ---
" nnoremap <leader>d v$hda

" --- Vim Tabs ---
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap H gT
nnoremap L gt
nnoremap <A-l> :+tabmove<CR>
nnoremap <A-h> :-tabmove<CR>

" --- Line Highlighting ---
hi Normal guibg=NONE ctermbg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi Visual ctermfg=24 guifg=#005f5f ctermbg=NONE guibg=NONE
set cursorline
highlight CursorLine cterm=NONE

" --- Tabbing ---
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" --- Nerd Tree Config ---
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

" --- Gitgutter Config ---
set updatetime=100
let g:gitgutter_enabled=1
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn guibg=NONE ctermbg=NONE
highlight GitGutterAdd guifg=DarkGreen guibg=NONE ctermbg=NONE ctermfg=green
highlight GitGutterChange guifg=DarkBlue guibg=NONE ctermbg=NONE ctermfg=blue
highlight GitGutterDelete guifg=DarkRed guibg=NONE ctermbg=NONE ctermfg=red

" --- IndentLine ---
let g:indentLine_char = '¦'
let g:indentLine_enabled = 1
autocmd Filetype json set conceallevel=0
autocmd Filetype json let g:indentLine_enabled = 0
autocmd Filetype dockerfile set conceallevel=0
autocmd Filetype dockerfile let g:indentLine_enabled = 0

" --- Whitespace ---
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" --- Lightline ---
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [
    \       ['mode', 'paste'],
    \       ['git_branch', 'relativepath', 'modified']
    \   ],
    \   'right': [
    \       ['coc_hint', 'coc_info', 'coc_warn', 'coc_error'],
    \       ['lineinfo'],
    \       ['percent'],
    \       ['filetype', 'fileencoding']
    \   ]
    \ },
    \ 'component_function': {
    \   'coc_hint': 'GetCocHint',
    \   'coc_info': 'GetCocInfo',
    \   'coc_warn': 'GetCocWarn',
    \   'coc_error': 'GetCocError',
    \   'git_branch': 'FugitiveHead'
    \ },
    \ }


autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" --- coc vim ---
let g:coc_global_extensions = ['coc-pairs', 'coc-tsserver', 'coc-pyright', 'coc-json', 'coc-css', 'coc-pydocstring', 'coc-python']

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

nmap <leader>ac :CocAction<CR>
nmap <leader>qf <Plug>(coc-fix-current)

nnoremap <leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! GetCocError() abort
    return s:get_coc_diagnostic('error', 'E:')
endfunction

function! GetCocWarn() abort
    return s:get_coc_diagnostic('warning', 'W:')
endfunction

function! GetCocInfo() abort
    return s:get_coc_diagnostic('information', 'I:')
endfunction

function! GetCocHint() abort
    return s:get_coc_diagnostic('hint', 'H:')
endfunction

function! s:get_coc_diagnostic(key, icon) abort
    let info = get(b:, 'coc_diagnostic_info', 0)
    if empty(info) || get(info, a:key, 0) == 0
        return ''
    endif
    return printf('%s%d', a:icon, info[a:key])
endfunction

"highlight CocFloating guibg=brown gui=bold
"highlight Pmenu guibg=brown gui=bold

nmap <silent> <leader>] <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>' <Plug>(coc-diagnostic-next)
nmap <silent> <leader>; <Plug>(coc-diagnostic-prev)

autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

" --- Semshi ---
function! SemshiCustomHighlights()
    hi semshiSelected ctermfg=24 guifg=#005f5f ctermbg=NONE guibg=NONE
endfunction
autocmd FileType python call SemshiCustomHighlights()

" --- Python Specific ---
nnoremap <leader>m :call FormatPython()<CR>
nnoremap <leader>pd :Pydocstring<CR>
nnoremap <leader>r :CocCommand pyright.restartserver<CR>

function! FormatPython()
    :Black
    :CocCommand pyright.organizeimports
endfunction

" --- On Save ---
function! StripTrailingWhiteSpaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd bufwritepre *.vim,*.py :call StripTrailingWhiteSpaces()

" --- Jenkins ---
autocmd BufRead Jenkinsfile setfiletype groovy
