set nocompatible              " be iMproved, required

"Leader
let mapleader = " "

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'StanAngeloff/php.vim'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdtree'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'scrooloose/nerdcommenter'
Plugin 'wincent/Command-T'
Plugin 'vim-scripts/taglist.vim'
Plugin 'mileszs/ack.vim'
Plugin 'honza/vim-snippets'
Plugin 'bling/vim-airline'
Plugin 'dracula/vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:jsx_ext_required = 0

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<M-Space>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

runtime macros/matchit.vim

set backspace=indent,eol,start
set noswapfile                      " don't keep a swap file
set history=50		                  " keep 50 lines of command line history
set ruler		                        " show the cursor position all the time
set showcmd		                      " display incomplete commands
set incsearch		                    " do incremental searching
set ignorecase smartcase            "incremental search
set lbr                             "linewrapping on
set scrolloff=3
set title
set laststatus=2
set nu "set line numbers on
set hidden
set wildmenu
set wildmode=list:longest
set pastetoggle=<F5>
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set cursorline

syntax on
set t_Co=256
color dracula
 
inoremap <C-k> <C-R>=delimitMate#JumpAny()<CR>
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

let g:rspec_command = "Dispatch rspec {spec} --color"

let g:airline#extensions#tabline#enabled = 1
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_powerline_fonts=1

" RSpec.vim mappings
map <Leader>u ;call RunCurrentSpecFile()<CR>
map <Leader>s ;call RunNearestSpec()<CR>
map <Leader>l ;call RunLastSpec()<CR>
map <Leader>a ;call RunAllSpecs()<CR>

vmap <Tab>   >gv
vmap <s-Tab> <gv

nnoremap > :bn<CR>
nnoremap < :bp<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

 " Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
 
 " Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Make enter open a new line and exit insert mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")
