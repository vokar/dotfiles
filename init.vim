let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
" Rust programming
" Plug 'rust-lang/rust.vim'
" Plug 'racer-rust/vim-racer'
Plug 'w0rp/ale'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sheerun/vim-polyglot'

" fzf
Plug 'airblade/vim-rooter'
Plug '/urs/bin/fzf'
Plug 'junegunn/fzf.vim'

" Editor enhancement
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-css-color'

" Other
" Plug 'mboughaba/i3config.vim'
" Plug 'vimwiki/vimwiki'
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
    " color dracula
    filetype plugin on
    set hidden
    set nocompatible
    set number relativenumber
    set encoding=utf-8
    syntax on

" Rust
let g:rustfmt_autosave = 1
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
    set splitright splitbelow

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" Leader bindings
nmap <leader>q :q<CR>
" nmap <leader>q! :q!<CR>
nmap <leader>w :w<CR>
nmap <leader><leader> <c-^>
" Open hotkeys
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>

" <leader>s for Rg search
noremap <leader>s :Rg<space>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', expand('%'))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

