" bundles

"=bundle AndrewRadev/splitjoin.vim
"=bundle godlygeek/csapprox
"=bundle godlygeek/tabular
"=bundle guns/vim-clojure-static
"=bundle guns/vim-sexp
"=bundle jelera/vim-javascript-syntax
"=bundle kchmck/vim-coffee-script
"=bundle kien/ctrlp.vim
"=bundle morhetz/gruvbox
"=bundle mustache/vim-mode
"=bundle othree/html5.vim
"=bundle slim-template/vim-slim
"=bundle tommcdo/vim-exchange
"=bundle tpope/vim-commentary
"=bundle tpope/vim-eunuch
"=bundle tpope/vim-fireplace
"=bundle tpope/vim-fugitive
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-rails
"=bundle tpope/vim-repeat
"=bundle tpope/vim-sensible
"=bundle tpope/vim-sleuth
"=bundle tpope/vim-surround
"=bundle tpope/vim-vinegar
"=bundle vim-ruby/vim-ruby

set nocompatible
filetype off

" bundles

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}')
syntax on
filetype plugin indent on

" settings

set backupdir=$HOME/.vimbackup,.
set cursorline
set directory=$HOME/.vimswap,.
set formatoptions=croqwanl
set gdefault
set hidden
set list listchars=tab:»·,trail:·
set visualbell
set wildmode=list:longest
set wildignore=.git,public/images,tmp,vendor,*.gif,*.jpeg,*.jpg,*.png

" search

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" autocommands

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

function! TrimWhiteSpace()
  let l:cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', l:cursor)
endfunction

autocmd BufWritePre * :call TrimWhiteSpace()
autocmd FileWritePre * :call TrimWhiteSpace()

" mappings

let mapleader = " "
let maplocalleader = " "

" save file with sudo
cnoremap w!! %!sudo tee > /dev/null %
" current file's directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>

nnoremap <Leader><Leader> <C-^>

nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" search
nnoremap <Leader>g :Ag<SPACE>

" splitjoin
nnoremap <Leader>sj :SplitjoinSplit<CR>
nnoremap <Leader>sk :SplitjoinJoin<CR>

" abbreviations

iabbrev dbg require "ruby-debug"; Debugger.start; debugger; 1
iabbrev bbg require "byebug"; byebug
iabbrev doctype DOCTYPE

" local overrides

let s:local_config = $HOME . "/.vimrc.local"
if filereadable(s:local_config)
  execute "source " . s:local_config
endif
