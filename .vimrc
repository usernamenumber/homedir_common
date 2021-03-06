
"
" TO RELOAD AFTER CHANGES:  `:source %` or `:so %`
"

" $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set mouse=a
"set paste
set ai

" https://www.youtube.com/watch?v=XA2WjJbmmoM
set wildmenu
set path+=**
command! MakeTags !ctags -R .

" visible whitespace
set listchars=tab:>-,space:·
set list

" auto-reload changes
" http://vimdoc.sourceforge.net/htmldoc/options.html#'autoread'
set autoread

"vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'vim-ruby/vim-ruby'

Plugin 'VundleVim/Vundle.vim'
"git interface
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set laststatus=2
"filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim' 

"html
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'
"python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_python_checkers=['flake8','pylint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let b:syntastic_mode = "passive"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" matchit
Plugin 'adelarsq/vim-matchit'

" Ranger file manager integration
Plugin 'francoiscabrol/ranger.vim'

" 
" requires nodejs, yarn
call plug#begin('~/.vim/plugged')
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}

"auto-completion stuff
"Plugin 'klen/python-mode'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'klen/rope-vim'
"Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'

""code folding
"Plugin 'tmhedberg/SimpylFold'

"object browsing
Plugin 'majutsushi/tagbar'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'tpope/vim-vividchalk'

call vundle#end()

"map <Leader>o :TagbarToggle<CR>
nmap <Leader>t :TagbarToggle<CR>

map <Leader>n <plug>NERDTreeTabsToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let NERDTreeQuitOnOpen=3 "close tree after opening
" This opens directories, too. :\
" https://stackoverflow.com/questions/8680752/how-to-open-a-file-in-new-tab-by-default-in-nerdtree
"let NERDTreeMapOpenInTab='<ENTER>' " open in tab by default

filetype plugin indent on    " enables filetype detection
let g:SimpylFold_docstring_preview = 1

"autocomplete
let g:ycm_autoclose_preview_window_after_completion=1

"custom keys
let mapleader=" "
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"
call togglebg#map("<F5>")
colorscheme vividchalk
set guifont=Monaco:h14

"I don't like swap files
"set noswapfile

"turn on numbering
set nu

"python with virtualenv support
"py << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUA_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  sys.path.insert(0, project_base_dir)
"  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags "tags for ctags and taglist
"omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
au BufRead,BufNewFile *md set tabstop=2

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerfull
set backspace=indent,eol,start


"----------Stop python PEP 8 stuff--------------

"js stuff"
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" (not) word wrapping
:set wrap
":set linebreak
":set nolist  " list disables linebreak

" CAPS to esc
"au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" indentation and line wrapping defaults
set tabstop=2
set shiftwidth=2
set expandtab
set wrap
set linebreak
"set nolist

" Normal copy/paste in gvim
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+


" Ctrl+PgUp/Dn to switch tabs
" https://stackoverflow.com/a/35930788
nnoremap [5;5~ :tabprevious<Enter>
nnoremap [6;5~ :tabnext<Enter>
"nnoremap <C-PageUp> :tabprevious
"nnoremap <C-PageDown> :tabnext



"nnoremap <F5> :r !date<CR>
map <Leader>t :r !date<CR>P
"nnoremap <F5> "=strftime("%c")<CR>P
"nnoremap <Leader>t "=strftime("%c")<CR>P


