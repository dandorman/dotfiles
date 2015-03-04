" bundles

"=bundle AndrewRadev/splitjoin.vim
"=bundle godlygeek/csapprox
"=bundle godlygeek/tabular
"=bundle guns/vim-clojure-static
"=bundle guns/vim-sexp
"=bundle jelera/vim-javascript-syntax
"=bundle kana/vim-textobj-user
"=bundle kien/ctrlp.vim
"=bundle morhetz/gruvbox
"=bundle mustache/vim-mustache-handlebars
"=bundle nelstrom/vim-mac-classic-theme
"=bundle nelstrom/vim-textobj-rubyblock
"=bundle othree/html5.vim
"=bundle tommcdo/vim-exchange
"=bundle tpope/vim-commentary
"=bundle tpope/vim-endwise
"=bundle tpope/vim-eunuch
"=bundle tpope/vim-fireplace
"=bundle tpope/vim-fugitive
"=bundle tpope/vim-haystack
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-rails
"=bundle tpope/vim-repeat
"=bundle tpope/vim-rsi
"=bundle tpope/vim-sensible
"=bundle tpope/vim-sleuth
"=bundle tpope/vim-surround
"=bundle tpope/vim-vinegar
"=bundle vim-ruby/vim-ruby
"=bundle vim-scripts/dbext.vim

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

augroup filetype_markdown
  autocmd!
  autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown
augroup END

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

" run tests
nnoremap <Leader>r :execute "!clear && ./bin/rspec %:" . line(".")<CR>
nnoremap <Leader>R :execute "!clear && ./bin/rspec %"<CR>

" local overrides

let s:local_config = $HOME . "/.vimrc.local"
if filereadable(s:local_config)
  execute "source " . s:local_config
endif
