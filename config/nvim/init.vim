" plugins

call plug#begin("$HOME/.local/share/nvim/plugged")

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction

Plug 'clojure-vim/nvim-parinfer.js'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'gabesoft/vim-ags'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-sexp'
Plug 'jasonlong/vim-textobj-css'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '$HOME/.local/share/fzf', 'do': './install --all' }
Plug 'kana/vim-textobj-user'
Plug 'morhetz/gruvbox'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'sheerun/vim-polyglot'
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'

call plug#end()

" settings

set cursorline
set formatoptions=croqwanl
set gdefault
set hidden
set nohlsearch
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

autocmd! BufReadPost ?* if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

function! TrimWhiteSpace()
  let l:cursor = getpos(".")
  %s/\s\+$//e
  call setpos('.', l:cursor)
endfunction

" autocmd! BufWritePre ?* :call TrimWhiteSpace()
" autocmd! FileWritePre ?* :call TrimWhiteSpace()

autocmd! BufWinEnter ?* silent! loadview
autocmd! BufWinLeave ?* mkview

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

" search
nnoremap <Leader>g :Ag<SPACE>

" run tests
nnoremap <Leader>r :execute "!clear && rspec %\\:" . line(".")<CR>
nnoremap <Leader>R :execute "!clear && rspec %"<CR>

" fuzzy finding
nnoremap <Leader>p :FZF<CR>

" extract let
nnoremap <Leader>l :s/\(\w\+\)\s*=\s*\(.*\)$/let(:\1) { \2 }<CR>
nnoremap <Leader>L :s/let(:\([^)]\+\))\s*{\s*\(.*\)\s*}/\1 = \2<CR>:s/\s\+$//e<CR>

" tab navigation
nnoremap <Leader>> :tabn<CR>
nnoremap <Leader>< :tabp<CR>

" ruby stuff
" tap 'n' inspect
nnoremap <Leader>i a.tap { \|o\| warn "#{o.inspect}" }<ESC>F#

" clojure stuff
" toggle parinfer mode
function! ToggleParinferMode()
  if g:parinfer_mode == 'indent'
    let g:parinfer_mode = 'paren'
  else
    let g:parinfer_mode = 'indent'
  end
endfunction

nnoremap <Leader>k :call ToggleParinferMode()<CR>

" color scheme
colorscheme onedark
