"=plugin AlessandroYorba/Despacio
"=plugin cespare/vim-toml
"=plugin gabesoft/vim-ags
"=plugin godlygeek/csapprox
"=plugin godlygeek/tabular
"=plugin guns/vim-clojure-static
"=plugin guns/vim-sexp
"=plugin jasonlong/vim-textobj-css
"=plugin jelera/vim-javascript-syntax
"=plugin kana/vim-textobj-user
"=plugin morhetz/gruvbox
"=plugin nelstrom/vim-mac-classic-theme
"=plugin nelstrom/vim-textobj-rubyblock
"=plugin rust-lang/rust.vim
"=plugin thoughtbot/pick.vim
"=plugin tommcdo/vim-exchange
"=plugin tpope/vim-commentary
"=plugin tpope/vim-endwise
"=plugin tpope/vim-eunuch
"=plugin tpope/vim-fireplace
"=plugin tpope/vim-fugitive
"=plugin tpope/vim-rails
"=plugin tpope/vim-repeat
"=plugin tpope/vim-rsi
"=plugin tpope/vim-sensible
"=plugin tpope/vim-sexp-mappings-for-regular-people
"=plugin tpope/vim-sleuth
"=plugin tpope/vim-surround
"=plugin tpope/vim-vinegar
"=plugin vim-ruby/vim-ruby

set nocompatible
filetype off

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
set smartcase
set visualbell
set wildmode=list:longest
set wildignore=.git,public/images,tmp,vendor,*.gif,*.jpeg,*.jpg,*.png

" search

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" autocommands

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

function! TrimWhiteSpace()
  let l:cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', l:cursor)
endfunction

" autocmd BufWritePre * :call TrimWhiteSpace()
" autocmd FileWritePre * :call TrimWhiteSpace()

autocmd BufWinEnter *.* silent loadview
autocmd BufWinLeave *.* mkview

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
nnoremap K :Ags<CR>

" search
nnoremap <Leader>g :Ag<SPACE>

" run tests
nnoremap <Leader>r :execute "!clear && rspec %\\:" . line(".")<CR>
nnoremap <Leader>R :execute "!clear && rspec %"<CR>

" pick.vim
let g:pick_executable="pick -X"
nnoremap <Leader>p :call PickFile()<CR>
nnoremap <Leader>s :call PickFileSplit()<CR>
nnoremap <Leader>v :call PickFileVerticalSplit()<CR>
nnoremap <Leader>t :call PickFileTab()<CR>
nnoremap <Leader>b :call PickBuffer()<CR>

" extract let
nnoremap <Leader>l :s/\(\w\+\)\s*=\s*\(.*\)$/let(:\1) { \2 }<CR>
nnoremap <Leader>L :s/let(:\([^)]\+\))\s*{\s*\(.*\)\s*}/\1 = \2<CR>:s/\s\+$//e<CR>

" tab navigation
nnoremap <Leader>> :tabn<CR>
nnoremap <Leader>< :tabp<CR>

" ruby stuff
" tap 'n' inspect
nnoremap <Leader>i a.tap { \|o\| warn "#{o.inspect}" }<ESC>F#

" local overrides

let s:local_config = $HOME . "/.vimrc.local"
if filereadable(s:local_config)
  execute "source " . s:local_config
endif
