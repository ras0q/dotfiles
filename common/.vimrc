colorscheme delek
syntax enable

" basic settings
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" appearance settings
set number
set cursorline
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest

" tab settings
set expandtab
set tabstop=2
set shiftwidth=2

" search settings
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" keymap settings
inoremap jk <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
