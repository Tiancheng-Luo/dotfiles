"""""""""""
" Plugins "
"""""""""""

call plug#begin('~/.config/nvim/plugged')

" Working with text
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Working with the file system
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Programming
Plug 'benekastah/neomake'
Plug 'editorconfig/editorconfig-vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntaxes
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'htmldjango' ] }
Plug 'othree/html5.vim', { 'for': [ 'html', 'htmldjango' ] }
Plug 'JulesWang/css.vim', { 'for': [ 'css', 'scss', 'sass', 'less' ] }
Plug 'vim-scripts/fountain.vim', { 'for': 'fountain' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'mustache/vim-mustache-handlebars', { 'for': [ 'mustache', 'handlebars', 'html.mustache', 'html.handlebars' ] }
Plug 'sudar/vim-arduino-syntax', { 'for': 'ino' }

" Themes
Plug 'mhartington/oceanic-next'

call plug#end()

""""""""""""""""""
" Configurations "
""""""""""""""""""

" Use soft tabs
set expandtab

" Soft tabs equal two spaces
set shiftwidth=2

" Real tabs equal to spaces
set tabstop=2

" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full

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

" Allow switching buffers without saving
set hidden

" Set hard wrapping guide to 80 columns
set colorcolumn=80

" Status line
set statusline=%{fugitive#statusline()}
set statusline+=%<\ %f

" Remap mapleader
let mapleader = ','

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Add new insert mode mapping for Esc
:imap jh <Esc>

" Esc exits insert mode in Neovim terminal
tnoremap <Esc> <C-\><C-n>

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

" File explorer format - tree view
let g:netrw_liststyle=3

" Hide file explorer banner
" let g:netrw_banner=0

" Shortcut to open file explorer
nmap <C-e> :Lexplore<cr>

" True color!
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Cursor is line in insert mode, block in normal mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Toggle set wrap
nmap <silent><leader>w :set wrap!<CR>

""""""""""""""""
" Autocommands "
""""""""""""""""

" django templates (syntax is built in to vim) are very similar to twig.
autocmd BufNewFile,BufRead *.html.twig set filetype=htmldjango
" Support Drupal .module and .theme files.
autocmd BufNewFile,BufRead *.theme,*.module set filetype=php

"""""""""""""
" Functions "
"""""""""""""

" Display date and time
map <F2> :echo 'It is ' . strftime('%a %b %e %I:%M %p')<CR>

" Insert time into a document
command! -nargs=* Timestamp call Timestamp()
function! Timestamp()
  :r !date "+\%h \%d, \%Y, \%l:\%M:\%S \%p"
endfunction

" Check if the working directory is managed in git
function! IsGitRepo()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    return 0
  endif
  return 1
endfunction

" fzf: use git when possible, otherwise ag for file search.
function! SearchForFiles()
  if IsGitRepo()
    :GitFiles
  else
    :Files
  endif
endfunction

" fzf: search files with ag from system root.
function! s:ag_with_git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  return v:shell_error ? {} : { 'dir': root }
endfunction

command! -nargs=* Rag
  \ call fzf#vim#ag(<q-args>, extend(s:ag_with_git_root(), g:fzf#vim#default_layout))

" fzf: File search; from git root if available.
" TODO use git grep inside git directories.
function! SearchInsideFiles()
  if IsGitRepo()
    :Rag
  else
    :Ag
  endif
endfunction

"""""""""""""""""""""""""
" Plugin configurations "
"""""""""""""""""""""""""

" Autodetect extra file types
augroup filetypedetect
  autocmd BufNew,BufNewFile,BufRead *.fountain :setfiletype fountain
augroup END

" fzf
nmap <C-P> :call SearchForFiles()<cr>
nmap <C-S> :call SearchInsideFiles()<cr>

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>

" Neomake
let g:neomake_open_list=0
let g:neomake_javascript_enabled_makers = ['jshint', 'eslint']
let g:neomake_json_enabled_makers = ['jsonlint']

autocmd! BufWritePost * Neomake

" Disable editorconfig on fugitive and remote buffers.
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"""""""""""""""
" Colorscheme "
"""""""""""""""

colorscheme OceanicNext
