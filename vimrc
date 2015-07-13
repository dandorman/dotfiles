" bundles

"=bundle gabesoft/vim-ags
"=bundle godlygeek/csapprox
"=bundle godlygeek/tabular
"=bundle guns/vim-clojure-static
"=bundle guns/vim-sexp
"=bundle kana/vim-textobj-user
"=bundle morhetz/gruvbox
"=bundle nelstrom/vim-mac-classic-theme
"=bundle nelstrom/vim-textobj-rubyblock
"=bundle thoughtbot/pick.vim
"=bundle tommcdo/vim-exchange
"=bundle tpope/vim-commentary
"=bundle tpope/vim-endwise
"=bundle tpope/vim-eunuch
"=bundle tpope/vim-fireplace
"=bundle tpope/vim-fugitive
"=bundle tpope/vim-pathogen
"=bundle tpope/vim-rails
"=bundle tpope/vim-repeat
"=bundle tpope/vim-rsi
"=bundle tpope/vim-sensible
"=bundle tpope/vim-sexp-mappings-for-regular-people
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
nnoremap K :Ags<CR>

" search
nnoremap <Leader>g :Ag<SPACE>

" run tests
nnoremap <Leader>r :execute "!clear && rspec %\\:" . line(".")<CR>
nnoremap <Leader>R :execute "!clear && rspec %"<CR>

" pick.vim
nnoremap <Leader>p :call PickFile()<CR>
nnoremap <Leader>s :call PickFileSplit()<CR>
nnoremap <Leader>v :call PickFileVerticalSplit()<CR>
nnoremap <Leader>t :call PickFileTab()<CR>
nnoremap <Leader>b :call PickBuffer()<CR>

" local overrides

let s:local_config = $HOME . "/.vimrc.local"
if filereadable(s:local_config)
  execute "source " . s:local_config
endif
