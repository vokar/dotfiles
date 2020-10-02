let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
" Programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

" Project navigation
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'

" Editor enhancement
Plug 'lifepillar/vim-gruvbox8'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ap/vim-css-color'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'vimwiki/vimwiki'

" xbps-install on Void Linux and pacman on Arch save plugins there
Plug '/usr/share/vim/vimfiles'
call plug#end()


" Fix vim-airline in Goyo. See https://github.com/junegunn/goyo.vim/issues/198
autocmd! User GoyoEnter nested set eventignore=FocusGained
autocmd! User GoyoLeave nested set eventignore=

" Some basics
set termguicolors
set mouse=a
set encoding=utf-8
set hidden
set number relativenumber
set nohlsearch
set clipboard=unnamedplus
set backupcopy=yes
set noshowmode
set undofile
set splitright splitbelow
let g:gruvbox_transp_bg = 1
let g:sneak#label = 1
colorscheme gruvbox8

" indenting
set expandtab
set shiftwidth=2
set softtabstop=2

" For coc.nvim
set updatetime=300
set cmdheight=2
set shortmess+=c
set signcolumn=yes

" Automatically deletes all trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Leader bindings
noremap <leader>s :Rg<space>
noremap <leader>m :Man<space>
nmap <leader><Tab> <c-^>
nmap <leader>e :e<CR>
map <leader>o :setlocal spell! spelllang=en_us<CR>
map <leader>p :Goyo \| set linebreak \| highlight StatusLineNC ctermfg=white<CR>
nmap <leader>d :lcd %:p:h<CR>
nmap <leader>g :G<CR>
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
