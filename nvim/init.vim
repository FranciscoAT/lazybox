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
Plug 'vim-scripts/mru.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'
Plug 'psf/black'
Plug 'fisadev/vim-isort'
Plug 'heavenshell/vim-pydocstring'
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" --- Common Configs ---
set number rnu
colorscheme gruvbox
let g:mapleader = ','
set noshowmode

" --- Surround ---
vnoremap <leader>1 <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>2 <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>3 <esc>`>a}<esc>`<i{<esc>
vnoremap <leader>4 <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>5 <esc>`>a'<esc>`<i'<esc>

" --- Common leader ---
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>b :e#<CR>
nnoremap <leader>s :source $MYVIMRC<CR>

" --- Sessions ---
nnoremap <leader>K :mksession! ~/.config/nvim/tempSession.vim<CR>
nnoremap <leader>k :source ~/.config/nvim/tempSession.vim<CR>

" --- Common Editing ---
nnoremap <leader>D vg$hda

" --- Vim Tabs ---
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap H gT
nnoremap L gt
nnoremap <A-l> :+tabmove<CR>
nnoremap <A-h> :-tabmove<CR>

" --- Line Highlighting ---
nnoremap <CR> :noh<CR><CR>
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

" --- Whitespace ---
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

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
    \   'git_branch': 'LightlineFugitive'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }


function! LightlineFugitive()
    if exists('*fugitive#head')
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    endif
    return ''
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" --- coc vim ---
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! GetCocError() abort
    return GetCocDiagnostic('error', 'E')
endfunction

function! GetCocWarn() abort
    return GetCocDiagnostic('warning', 'W')
endfunction

function! GetCocInfo() abort
    return GetCocDiagnostic('information', 'I')
endfunction

function! GetCocHint() abort
    return GetCocDiagnostic('hint', 'H')
endfunction

function! GetCocDiagnostic(key, icon) abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    if get(info, a:key, 0)
        return a:icon . info[a:key]
    endif
    return ''
endfunction

highlight CocFloating guibg=brown gui=bold
highlight Pmenu guibg=brown gui=bold

nmap <silent> <leader>] <Plug>(coc-diagnostic-next-error)
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>' <Plug>(coc-diagnostic-next)
nmap <silent> <leader>; <Plug>(coc-diagnostic-prev)

" --- Semshi ---
function! SemshiCustomHighlights()
    hi semshiSelected ctermfg=24 guifg=#005f5f ctermbg=NONE guibg=NONE
endfunction
autocmd FileType python call SemshiCustomHighlights()

" --- Python Specific ---
let g:black_linelength = 100
nnoremap <leader>m :Black<CR>
nnoremap <leader>pd :Pydocstring<CR>

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
