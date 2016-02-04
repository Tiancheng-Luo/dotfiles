" Use soft tabs
set expandtab

" Soft tabs equal two spaces
set shiftwidth=2

" Real tabs equal to spaces
set tabstop=2

" Change to the current buffer's parent directory
set autochdir

" Use relative line numbers with the current line the absolute line number
set number
set relativenumber

" Use a dark background
set background=dark

" Neovim's standard clipboard register = the system register
set clipboard+=unnamedplus

" Spell checking
set spell

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces

" Puts new vsplit windows to the right of the current
set splitright

" Puts new split windows to the bottom of the currentset hidden
set splitbelow

" Show matching brackets/parenthesis
set showmatch

" Case insensitive search
set ignorecase

" Highlight invisible whitespace
set list

" Remap mapleader
let mapleader = ','

" Add new mapping for Esc
:imap jh <Esc>

" Stupid shift key fixes, lifted from spf13
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

" True color!
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Toggle set wrap
nmap <silent><leader>w :set wrap!<CR>

" Display date and time
map <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Insert time into a document
command! -nargs=* Timestamp call Timestamp()
function! Timestamp()
  :r !date "+\%h \%d, \%Y, \%l:\%M:\%S \%p"
endfunction

" Plugins
call plug#begin('~/.config/nvim/plugged')

" Working with text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" Misc
Plug 'vim-scripts/fountain.vim'

" Themes
Plug 'mhartington/oceanic-next'

call plug#end()

" Autodetect extra file types
augroup filetypedetect
  autocmd BufNew,BufNewFile,BufRead *.fountain :setfiletype fountain
augroup END

" Set a colorscheme
colorscheme OceanicNext
