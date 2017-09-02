set number
set nocompatible
filetype plugin indent on
syntax on
silent! runtime macros/matchit.vim
set autochdir
set backspace=indent,eol,start
set foldenable
set hidden
set incsearch
set laststatus=2
set ruler
set switchbuf=useopen,usetab
set tags=./tags,tags;/
set wildmenu
nnoremap gb :buffers<CR>:sb<Space>
set expandtab                  " use spaces instead of tabs
set tabstop=4                  " see :h 'tabstop'
set softtabstop=4              " see :h 'softtabstop'
set shiftwidth=4               " see :h 'shiftwidth'
set shiftround
nnoremap ; :
set mouse=a
set pastetoggle=<F2>
set showtabline=2