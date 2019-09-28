let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
" Programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" Project navigation
Plug 'airblade/vim-rooter'
Plug '/urs/bin/fzf'
Plug 'junegunn/fzf.vim'

" Editor enhancement
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-css-color'
call plug#end()

" set bg=light
set mouse=a
set nohlsearch
set clipboard=unnamedplus
set backupcopy=yes

" indenting
set expandtab
set shiftwidth=4
set softtabstop=4

" Some basics:
filetype plugin on
set hidden
set nocompatible
set number relativenumber
set encoding=utf-8
syntax on

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults
set splitright splitbelow

" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Automatically deletes all trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e

" Leader bindings
nmap <leader>q :q<CR>
nmap <leader>w :w<CR>
nmap <leader><Tab> <c-^>
nmap <leader>d :lcd %:p:h<CR>
noremap <leader>s :Rg<space>
" Open fzf's modals
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>

let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" requires proximity-sort to work, run: cargo install proximity-sort
function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)
