" ### --- VIM CONFIG --- ###
" ### Basics ###
set mouse=a " enable mouse
set wildmenu " visual autocomplete for command menu
set timeoutlen=500 ttimeoutlen=0 " reduce O delay
set splitbelow splitright " splits open at bottom and right
filetype plugin indent on " load filetype-specific indent files
autocmd FileType * setlocal formatoptions-=cro " don't commment new lines

" ### UI ###
syntax enable
set showcmd " show command in status bar
hi Visual term=reverse cterm=reverse

" ### Indentation ###
set tabstop=2 " number of visual spaces per TAB
set expandtab " tabs are spaces
set shiftwidth=2
set smartindent

" ### Relative Line Numbers ###
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" ### Remaps ###
let mapleader=','

" ### Standard Editor Commands ###
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
noremap <C-s> :w <Enter>
" noremap <C-z> u
noremap <C-a> moGVgg
" needs +clipboard (check with vim --version)
vnoremap <C-c> "*y :let @+=@*<CR>gv
" vnoremap <C-c> "+ygv
vnoremap <C-x> "+ygvd
noremap <C-v> "+p
nnoremap <C-f> /
" autoformat
nnoremap <C-l> mogg=G`o
" remap visual block mode to leader v
nnoremap <leader>v <C-v>

" ### easier moving of code blocks ###
vnoremap > >gv
vnoremap < <gv
nnoremap > >>
nnoremap < <<

" ### Searching ###
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" ### Page Up/Down ###
nnoremap <PageUp> 4<C-y>
nnoremap <PageDown> 4<C-e>

" ### Buffers ###
nnoremap gb :ls<CR>:b<Space>

" ### ----VIM-PLUGINS---- ###
" Place this file at ~/.vimrc
" To install plugins type : then PlugInstall
" ### automatic installation of vim-plug ###
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ### load plugins ###
call plug#begin('~/.vim/plugged')

" # IDE features #
" vim-commentary, toggle comments
Plug 'tpope/vim-commentary'
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>gv

" vim-multiple-cursor, multiple selections for Vim
Plug 'https://github.com/terryma/vim-multiple-cursors.git'

" Vim Surround, change surronding brackets or quotes
Plug 'https://github.com/tpope/vim-surround.git'

" vim-easymotion, enable additional jump motions
Plug 'https://github.com/easymotion/vim-easymotion.git'
map  <space> <Plug>(easymotion-bd-w)

" Vim Better Whitespace, highlight trainling whitespace
Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1

" Nerd Tree, sidebar file browser
Plug 'https://github.com/scrooloose/nerdtree.git'
map <C-o> :NERDTreeToggle<CR>
let NERDTreeShowLineNumbers=1 " make sure relative line numbers are used
let g:NERDTreeMouseMode=3 " Single Click
autocmd FileType nerdtree setlocal relativenumber

" # language specific plugins #
" emmet-vim, Emmet for Vim
Plug 'mattn/emmet-vim'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" vim-css-color, highlight color
Plug 'https://github.com/ap/vim-css-color.git'

" vala.vim, Vala syntax highlighting
Plug 'arrufat/vala.vim'
let g:vala_syntax_folding_enabled=0

" Vue.JS, syntax and indent plugin
Plug 'leafOfTree/vim-vue-plugin'

"### Initialize plugin system ###
call plug#end()
