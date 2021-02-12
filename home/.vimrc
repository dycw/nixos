" symlink=~/.vimrc

" =============================================================================
" settings
" =============================================================================
set autoread
set clipboard=unnamed
set colorcolumn=80
set completeopt+=noselect                                          " MUcomplete
set expandtab
set gdefault
set ignorecase
set linebreak
set list
set mouse=
set noshowmode
set noswapfile
set number
set pastetoggle=<F2>
set relativenumber
set scrolloff=5
set shiftwidth=2
set shortmess+=c                                                   " MUcomplete
set showtabline=2
set smartcase
set smartindent
set splitbelow
set splitright
set tabstop=2

" =============================================================================
" mappings
" =============================================================================
" clear first
mapclear

" leader
let mapleader=' '

" color
colorscheme elflord

" exit normal mode
imap jk <Esc>
imap kj <Esc>

" save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

" quit
nnoremap <C-q> :q<CR>

" =============================================================================
" plugins
" =============================================================================
" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" auto-pairs
Plug 'jiangmiao/auto-pairs'

" fzf
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>c :Commands<CR>
  nnoremap <Leader>C :History<CR>
  nnoremap <Leader>f :GFiles<CR>
  nnoremap <Leader>F :Files<CR>
  nnoremap <Leader>h :History<CR>
  nnoremap <Leader>H :Helptags!<CR>
  nnoremap <Leader>m :Marks<CR>
  nnoremap <Leader>M :Maps<CR>
  nnoremap <Leader>t :Tags<CR>
  nnoremap <Leader>T :BTags<CR>
  nnoremap <Leader>w :Windows<CR>
  if executable('rg')
    nnoremap <Leader>l :Rg<CR>
  elseif executable('ag')
    nnoremap <Leader>l :Ag<CR>
  else
    nnoremap <Leader>l :Lines<CR>
  endif
  nnoremap <Leader>L :BLines<CR>

" NERDCommenter
Plug 'preservim/nerdcommenter'
  let g:NERDCreateDefaultMappings = 0
  nnoremap <Leader>- :call NERDComment(0, "toggle")<CR>
  vnoremap <Leader>- :call NERDComment(0, "toggle")<CR>

" NERDTree
Plug 'preservim/nerdtree'
  nnoremap <Leader>nt :NERDTreeToggle<CR>
  let g:NERDTreeMenuDown = 'e'
  let g:NERDTreeMenuUp = 'i'
  let g:NERDTreeNaturalSort = 1

" scratch.vim
Plug 'mtth/scratch.vim'
  let g:scratch_no_mappings = 1

" vim-bufkill
Plug 'qpkorr/vim-bufkill'
  let g:BufKillCreateMappings = 0
  nnoremap <C-c> :BD<CR>

" vim-eunuch
Plug 'tpope/vim-eunuch'

" vim-exchange
Plug 'tommcdo/vim-exchange'

" vim-repeat
Plug 'tpope/vim-repeat'

" vim-fugitive
Plug 'tpope/vim-fugitive'
  nnoremap gd :Gdiff<CR>
  nnoremap gs :Gstatus<CR>
  nnoremap gp :Gpush<CR>

" vim-lastplace
Plug 'farmergreg/vim-lastplace'

" vim-lightline
Plug 'itchyny/lightline.vim'
  let g:lightline = {'component_function': {'filename': 'LightlineFilename'}}

  function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
      return path[len(root)+1:]
    else
      return expand('%')
    endif
  endfunction

" vim-mergetool
Plug 'samoshkin/vim-mergetool'
  let g:mergetool_layout = 'bmr'
  nnoremap <Leader>mt :MergetoolToggle<CR>
  nnoremap <Leader>mn :MergetoolDiffExchangeLeft<CR>
  nnoremap <Leader>mo :MergetoolDiffExchangeRight<CR>

" vim-sensible
Plug 'tpope/vim-sensible'

" vim-signify
Plug 'mhinz/vim-signify'
  highlight SignifySignAdd    ctermfg=green  guifg=#00ff00 cterm=NONE gui=NONE
  highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
  highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE

" vim-speeddating
Plug 'tpope/vim-speeddating'

" vim-startify
Plug 'mhinz/vim-startify'
  let g:startify_lists = [
    \ { 'type': 'dir',       'header': ['MRU '. getcwd()] },
    \ { 'type': 'files',     'header': ['MRU']            },
    \ { 'type': 'sessions',  'header': ['Sessions']       },
    \ { 'type': 'bookmarks', 'header': ['Bookmarks']      },
    \ { 'type': 'commands',  'header': ['Commands']       },
    \ ]
  let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
  let g:ascii = []
  let g:startify_custom_header = ['Hello, Derek']

" vim-surround
Plug 'tpope/vim-surround'

call plug#end()
