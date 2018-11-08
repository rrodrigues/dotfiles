
" vim shortcuts
" Operators
"  d - delete/cut
"  c - change
"  y - yank/copy
"  v - visual select
" Movement (Operator + key)
"  w - to next word
"  i* - inside *
"  t* - until * in the same line
"  /** - until next **
"  f/F - move forward/backwards to in the same line
"  za -> unfold/fold sections


let mapleader = ","


" setter -> options ------------------------ {{{

" line number
set number
set numberwidth=5

" highlighting
set hlsearch
" incremental search
set incsearch
" ignore case in search (\c \C override)
set ignorecase
" don't ignore case if in caps
set smartcase

" tabs
set tabstop=2
set shiftwidth=2
set expandtab

" show list instead of just
set wildmenu
" command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

" lines to scroll when cursor leaves screen
set scrolljump=5
" minimum lines to keep above and below cursor
set scrolloff=3

" remove error sound
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" spell checking on
"set spell

" show dots for whitespaces
set listchars=tab:▸\ ,trail:·
set list

" }}}



"""""""" mappings  {{{

" remap <esc> to jk
inoremap jk <esc>
" disable <esc> while in insert mode
"inoremap <esc> <nop>

" edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>cv :source $MYVIMRC<CR> :close <CR>

" put " around the word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" put ' around the word;
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" wrap/unwrap
nnoremap <leader>w :set wrap<CR>
nnoremap <leader>nw :set nowrap<CR>

" put ; at the end of line
inoremap <leader>; <esc>mqA;<esc>`qi
noremap <leader>; <esc>mqA;<esc>`q

noremap <leader>h <esc>:nohl<cr>

" splits navigation - Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

"}}}



"""""""" abbreviations {{{
" :iabbrev adn and
" :iabbrev @@ rrodrigues99@gmail.com

"}}}


"""""""" autocommands   {{{
" :autocmd 'event' 'pattern' 'action'
" :autocmd ButNewFile * :write
" :autocmd FileType python 'action'
" grouping autocommands
" augroup 'name'
"   autocmd .....
"   autocmd .....
" augroup END
" clearing groupd adding autocmd! at begging of the group

"autocmd FileType python :iabbrev <buffer> iff if:<left>


" }}}



"""""""" operator-pending mappings  {{{
" dw -> delete - to next word
" ci( -> change - inside parens
" yt, -> yank - until comma
" :onoremap p i(
" http://learnvimscriptthehardway.stevelosh.com/chapters/15.html
" http://learnvimscriptthehardway.stevelosh.com/chapters/16.html
" :onoremap in( :,c-u>normal! f(vi(<cr>
" in( - the movement like cin( or din(
" normal! - insert commands in normal mode
" f( - go to next (
" vi( - visual mode inside (

" select inside next (
onoremap in( :<c-u>normal! f(vi(<cr>
" select inside last (
onoremap il( :<c-u>normal! F)vi(<cr>


"}}}


" status line {{{
set statusline=[%.20F]\
set statusline+=FileType:\ %y
set statusline+=%=
set statusline+=Line:\ %l\ [\%L]\
set statusline+=Column:\ %-2c
set laststatus=2
"}}}


" Vimscript file settings ---------------------- {{{
"augroup filetype_vim
"    autocmd!
"    autocmd FileType vim setlocal foldmethod=marker
"augroup END
" }}}




" Vundle configs ---------------------- {{{

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" plugins in here

Plugin 'https://github.com/scrooloose/nerdcommenter'

Plugin 'Valloric/YouCompleteMe'

" ctags auto-update
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

" better whitespace
Plugin 'ntpeters/vim-better-whitespace'

" neocomplete
Plugin 'Shougo/neocomplete.vim'

Plugin 'jnurmine/Zenburn'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" colorscheme
colorscheme zenburn

" ctags configs --- using easytags ------- {{{
set tags=tags,./tags;$HOME/.vim/tags/

let g:easytags_cmd = '/usr/local/bin/ctags'
" async update
"let g:easytags_async=1

let g:easytags_file = '~/.vim/tags/tags'
let g:easytags_dynamic_files=2
" }}}



" python configuration ----------------- {{{

augroup filetype_python

  autocmd!
  autocmd FileType python :iabbrev <buffer> iff if:<left>
  autocmd FileType python set omnifunc=pythoncomplete#Complete

augroup END

" }}}


" YCM configs -------------------------- {{{

"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = 'ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1

" shortcuts

nnoremap <leader>gg :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>


" }}}


