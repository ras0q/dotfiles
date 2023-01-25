colorscheme zellner
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
if expand("%:r") == 'Makefile'
  set noexpandtab
endif

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

" git commit prefix
augroup gitabbr
  autocmd!
  " ✨ fe: Introduce new features.
  autocmd FileType gitcommit iabbrev fe :sparkles:
  " 🐛 bu: Fix a bug.
  autocmd FileType gitcommit iabbrev bu :bug:
  " 🩹 ad: Simple fix for a non-critical issue.
  autocmd FileType gitcommit iabbrev ad :adhesive_bandage:
  " ♻️ re: Refactor code.
  autocmd FileType gitcommit iabbrev re :recycle:
  " 💥 bo: Introduce breaking changes.
  autocmd FileType gitcommit iabbrev bo :boom:
  " 🔥 rm: Remove code or files.
  autocmd FileType gitcommit iabbrev rm :fire:
  " 💄 li: Add or update the UI and style files.
  autocmd FileType gitcommit iabbrev ui :lipstick:
  " 🔧 co: Add or update configuration files.
  autocmd FileType gitcommit iabbrev co :wrench:
  " 📝 do: Add or update documentation.
  autocmd FileType gitcommit iabbrev do :memo:
  " ⬆️ up: Upgrade dependencies.
  autocmd FileType gitcommit iabbrev up :arrow_up:
augroup END
