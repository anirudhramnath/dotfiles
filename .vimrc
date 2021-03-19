set nocompatible
filetype off

source /usr/share/vim/google/google.vim

" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'anirudhramnath/tender.vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'sso://user/lerm/glint-ale'
call plug#end()
" }}}

" Google plugins {{{
Glug critique
Glug codefmt
Glug codefmt-google
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType c,cpp,javascript AutoFormatBuffer clang-format
  autocmd FileType markdown AutoFormatBuffer mdformat
  autocmd FileType proto AutoFormatBuffer protofmt
  autocmd FileType sql AutoFormatBuffer format_sql
  autocmd FileType java AutoFormatBuffer google-java-format
augroup END
" }}}


" visual {{{
set termguicolors
if !has('gui_running')
  set t_Co=256
endif
set vb t_vb= " disable sounds
set number
set cursorline
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
colorscheme tender
let g:lightline = { 'colorscheme': 'tender' }
" status bar {
  set cmdheight=2
  set laststatus=2
  set noshowmode
  set showcmd
" }
" }}}

" sensible defaults {{{
syntax on
let mapleader=" "
set hidden
set ignorecase
set smartcase
set hlsearch
set incsearch
set splitright
set ttyfast
nnoremap <silent> <leader>/ :noh<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> <leader>w :update<CR>
nnoremap <silent> <leader>q :q!<CR>
" }}} 

" movement {{{
nnoremap <silent> 1 <C-D>
nnoremap <silent> 2 <C-U>
" }}}

" Nerdtree {{{
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap - :NERDTreeToggle<CR>
" exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
" }}}

" FZF vim
nmap <C-P> :Files<CR>

" Coc {{{
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :vsp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gI :vsp<CR><Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
set updatetime=300
" }}}

" ALE {{{
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_virtualenv_dir_names = [] " otherwise slow on py files
let g:ale_linters_explicit = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
      \ 'borg'      : ['glint'],
      \ 'bzl'       : ['glint'],
      \ 'cpp'       : ['glint'],
      \ 'gcl'       : ['glint'],
      \ 'go'        : ['glint'],
      \ 'html'      : ['glint'],
      \ 'java'      : ['glint'],
      \ 'javascript': ['glint'],
      \ 'jslayout'  : ['glint'],
      \ 'proto'     : ['glint'],
      \ 'python'    : ['glint'],
      \ 'typescript': ['glint'],
\}
" }}}

" Load the automated blaze dependency integration for Go.
" Note: for Go, blazedeps uses the Go team's glaze tool, which is fully
" supported by the Go team. The plugin is currently unsupported for other
" languages.
"Glug blazedeps auto_filetypes=`['go']`

" Load piper integration (http://go/VimPerforce).
"Glug piper plugin[mappings]

" Load Critique integration. Use :h critique for more details.
"Glug critique plugin[mappings]

" Load blaze integration (http://go/blazevim).
"Glug blaze plugin[mappings]
" Load the ultisnips plugin (http://go/ultisnips).
" Note: this requires installing the upstream ultisnips plugin from
" https://github.com/SirVer/ultisnips.
"Glug ultisnips-google
