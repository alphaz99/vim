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

" Dein
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')

" NERDtree
call dein#add('scrooloose/nerdtree',
    \{'on_cmd': 'NERDTreeToggle'})
call dein#add('jistr/vim-nerdtree-tabs')

" Vim airline
call dein#add('bling/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" Code
call dein#add('Raimondi/delimitMate')
call dein#add('airblade/vim-gitgutter')
call dein#add('tpope/vim-surround')
call dein#add('scrooloose/nerdcommenter')
call dein#add('junegunn/vim-easy-align')

" Theme
call dein#add('joshdick/onedark.vim')

" Completion
call dein#add('sheerun/vim-polyglot')
call dein#add('majutsushi/tagbar')
call dein#add('ervandew/supertab')
call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
call dein#add('vim-erlang/vim-erlang-tags')

" FZF
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
call dein#add('yuki-ycino/fzf-preview.vim')

" Misc
call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'windows': 'tools\\update-dll-mingw',
    \     'cygwin': 'make -f make_cygwin.mak',
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })
call dein#add('tpope/vim-fugitive')
call dein#add('sjl/gundo.vim')

" Not used
"call dein#add('neomake/neomake')
"call dein#add('Shougo/deoplete.nvim',
    "\{'on_i': 1})
"call dein#add('zchee/deoplete-jedi')
"call dein#add('hyhugh/coc-erlang_ls', {'build': 'yarn install --frozen-lockfile'})

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

"set rtp+=/usr/local/opt/fzf

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
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#jedi#show_docstring = 1

"Airline"
let g:airline_theme='onedark'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"FZF
let g:fzf_preview_command = 'bat --color=always --style=grid {-1} --theme=ansi-dark'


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
  "autocmd vimenter * NERDTree
  "autocmd StdinReadPre * let s:std_in=1
  "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " Change focus to file"
  autocmd VimEnter * wincmd p

  " Open TagBar automatically"
  autocmd BufEnter * nested :call tagbar#autoopen(1) 

  " Run Neomake"
  "autocmd! BufWritePost * Neomake


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
colorscheme onedark
set colorcolumn=80

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

hi VertSplit guibg=bg guifg=lightred
"Keys"
nmap <F8> :TagbarToggle<CR>
nnoremap <F5> :GundoToggle<CR>
let mapleader=","
tnoremap <Esc> <C-\><C-n>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Python
let g:python_host_prog = "/home/rbachal/virtualenvs/neovim2/bin/python"
let g:python3_host_prog = "/home/rbachal/virtualenvs/neovim3/bin/python"

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"" inoremap <silent><expr> <TAB>
      "" \ pumvisible() ? "\<C-n>" :
      "" \ <SID>check_back_space() ? "\<TAB>" :
      "" \ coc#refresh()
"" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
