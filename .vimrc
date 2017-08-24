" Maintainer:	Rahul Bachal 
" Last change:	2017 March 21
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" ==== Dein plugins ====

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'windows': 'tools\\update-dll-mingw',
    \     'cygwin': 'make -f make_cygwin.mak',
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })
call dein#add('scrooloose/nerdtree',
    \{'on_cmd': 'NERDTreeToggle'})
call dein#add('neomake/neomake')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('bling/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('majutsushi/tagbar')
call dein#add('tpope/vim-fugitive')
call dein#add('Raimondi/delimitMate')
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-surround')
call dein#add('scrooloose/nerdcommenter')
call dein#add('sjl/gundo.vim')
call dein#add('sheerun/vim-polyglot')
call dein#add('Shougo/deoplete.nvim',
    \{'on_i': 1})
call dein#add('zchee/deoplete-jedi')
call dein#add('ervandew/supertab')
call dein#add('joshdick/onedark.vim')
call dein#add('vim-erlang/vim-erlang-tags')
"call dein#add('junegunn/fzf')
call dein#add('junegunn/fzf.vim')
call dein#add('vim-erlang/vim-erlang-omnicomplete')

call dein#end()

" ==== Custom navigation ====
"
" " Control-L is escape.
 nmap <C-L> <ESC>
 imap <C-L> <ESC>
"
" " Navigating tabs and windows.
 nmap <C-J> :tabprevious<CR>
 nmap <C-K> :tabnext<CR>
"
"

" Puts line numbers for reference
" Colors them grey.
set number
highlight LineNr ctermfg=grey

" Always show line numbers, but only in current window.
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set tabstop=4           " size of a hard tabstop
set shiftwidth=4        " size of an indent
set softtabstop=4
set expandtab
filetype plugin indent on

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set rtp+=/usr/local/opt/fzf

set cmdheight=1

" TABs in Makefiles
autocmd FileType make set noexpandtab 

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
syntax on
set hlsearch

"NERDTreeTabs"
let g:nerdtree_tabs_open_on_console_startup=1

"NERDTree"
let g:NERDTreeWinSize = 25

"Tagbar"
let g:tagbar_width = 30

"vim-airline theme"
let g:airline_theme='dark'

"SuperTab"
let g:SuperTabDefaultCompletionType = "<c-n>"

"Deoplete"
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#show_docstring = 1

"Airline"
let g:airline_theme='dark'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " Open NERDTree automatically"
  autocmd vimenter * NERDTree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " Change focus to file"
  autocmd VimEnter * wincmd p

  " Open TagBar automatically"
  autocmd VimEnter * nested :call tagbar#autoopen(1) 

  " Run Neomake"
  autocmd! BufWritePost * Neomake


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Color
set t_Co=256
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
    set termguicolors
endif
let g:onedark_termcolors=16
colorscheme desert
set colorcolumn=80
"Keys"
nmap <F8> :TagbarToggle<CR>
nnoremap <F5> :GundoToggle<CR>
let mapleader=","
tnoremap <Esc> <C-\><C-n>
