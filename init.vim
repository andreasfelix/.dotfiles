" options
set mouse=a                                    " enable mouse
set number                                     " enable line numbering
set expandtab tabstop=4 shiftwidth=4           " indent using 4 spaces
set splitbelow splitright                      " splits open at bottom and right
autocmd FileType * setlocal formatoptions-=cro " don't comment new lines

" standard editor commands
noremap <C-s> :w <Enter>
noremap <C-a> moGVgg
noremap <C-v> "+P
" needs +clipboard (see vim --version)
vnoremap <C-c> "*y :let @+=@*<CR>gv
vnoremap <C-x> "+ygvd

" easier moving of code blocks
nnoremap > >>
nnoremap < <<
vnoremap > >gv
vnoremap < <gv

" toggle comment with ctrl / (needs vim-commentary)
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>gv

" remap visual block mode to leader v
nnoremap <leader>v <C-v>

" clear search highlight
nnoremap <leader><space> :nohlsearch<CR>


if has('nvim')
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>

lua << EOF
require'lspconfig'.pyright.setup{}
EOF
endif

if !has('nvim')
    " defaults in neovim
    syntax enable
    filetype plugin indent on " load filetype-specific indent files
    set autoindent            " use indentation of previous line
    set hlsearch              " highlight matches
    set incsearch             " search as characters are entered
    set showcmd               " show command in status bar
    set ttimeoutlen=0         " reduce O delay
    set wildmenu              " visual autocomplete for command menu

    " automatic installation of vim-plug
    if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

    " load plugins
    call plug#begin('~/.vim/plugged')

    " vim-commentary, toggle comments
    Plug 'tpope/vim-commentary'

    " vim-multiple-cursor, multiple selections for Vim
    Plug 'https://github.com/terryma/vim-multiple-cursors.git'

    " Vim Surround, change surrounding brackets or quotes
    Plug 'https://github.com/tpope/vim-surround.git'

    " vim-easymotion, enable additional jump motions
    Plug 'https://github.com/easymotion/vim-easymotion.git'
    map  <space> <Plug>(easymotion-bd-w)

    " Vim Better Whitespace, highlight trainling whitespace
    Plug 'https://github.com/ntpeters/vim-better-whitespace.git'
    let g:better_whitespace_enabled=1
    let g:strip_whitespace_on_save=1

    " Initialize plugin system
    call plug#end()
endif
