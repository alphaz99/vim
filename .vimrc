" Maintainer:	Rahul Bachal 
" Last change:	2017 March 21

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein plugin manager {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim " path to dein.vim

if dein#load_state('~/.vim/dein')
    call dein#begin(expand('~/.vim/dein'))
    call dein#add('Shougo/dein.vim')

    " Integrations {{{2
    " -------------------------------------------------------------------------

    " NERDTree {{{3
    call dein#add('scrooloose/nerdtree',
                \{'on_cmd': 'NERDTreeToggle'})
    call dein#add('jistr/vim-nerdtree-tabs')

    " FZF {{{3
    call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
    call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
    call dein#add('yuki-ycino/fzf-preview.vim', { 'rev': 'release' })
    call dein#add('pbogut/fzf-mru.vim')

    " Git {{{3
    call dein#add('tpope/vim-fugitive')
    call dein#add('rhysd/git-messenger.vim', {
            \   'lazy' : 1,
            \   'on_cmd' : 'GitMessenger',
            \   'on_map' : '<Plug>(git-messenger)',
            \ })

    " Tmux {{{3
    call dein#add('christoomey/vim-tmux-navigator')

    " Internal {{{3
    call dein#add('voldikss/vim-floaterm')
    call dein#add('liuchengxu/vim-which-key')
    call dein#add('mhinz/vim-startify')
    call dein#add('romainl/vim-qf')
    call dein#add('tpope/vim-unimpaired')



    " Code {{{2
    " -------------------------------------------------------------------------
    call dein#add('Raimondi/delimitMate')
    call dein#add('tpope/vim-surround')
    call dein#add('scrooloose/nerdcommenter')
    call dein#add('junegunn/vim-easy-align')
    call dein#add('sjl/gundo.vim')

    " Visual {{{2
    " -------------------------------------------------------------------------
    call dein#add('joshdick/onedark.vim')
    call dein#add('mhinz/vim-signify')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('ryanoasis/vim-devicons')

    " Vim airline {{{3
    call dein#add('bling/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')


    " Navigation and completion {{{2
    " -------------------------------------------------------------------------
    call dein#add('majutsushi/tagbar')
    call dein#add('ervandew/supertab')
    call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
    call dein#add('psliwka/vim-smoothie')
    " Erlang specific
    call dein#add('vim-erlang/vim-erlang-tags')

    " Misc {{{2
    " -------------------------------------------------------------------------
    call dein#add('Shougo/vimproc.vim', {
                \ 'build': {
                \     'windows': 'tools\\update-dll-mingw',
                \     'cygwin': 'make -f make_cygwin.mak',
                \     'mac': 'make -f make_mac.mak',
                \     'linux': 'make',
                \     'unix': 'gmake',
                \    },
                \ })

    " Not used
    "call dein#add('neomake/neomake')
    "call dein#add('Shougo/deoplete.nvim',
    "\{'on_i': 1})
    "call dein#add('zchee/deoplete-jedi')
    "call dein#add('hyhugh/coc-erlang_ls', {'build': 'yarn install --frozen-lockfile'})

    call dein#end()
    call dein#save_state()
endif

"On startup, install not-installed plugins.
if dein#check_install()
  call dein#install()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

set timeoutlen=500

" if hidden is not set, TextEdit might fail.
set hidden

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

"set rtp+=/usr/local/opt/fzf

set cmdheight=1

" Set undodir
set undodir=~/.vim/undodir
set undofile

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Python {{{2
" -----------------------------------------------------------------------------
let g:python_host_prog = "$HOME/virtualenvs/neovim2/bin/python"
let g:python3_host_prog = "$HOME/virtualenvs/neovim3/bin/python"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin-specific configuration {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree {{{2
" -----------------------------------------------------------------------------
" NERDTreeTabs
let g:nerdtree_tabs_open_on_console_startup=1

" NERDTree
let g:NERDTreeWinSize = 25

" Tagbar {{{2
" -----------------------------------------------------------------------------
let g:tagbar_width = 30

" SuperTab {{{2
" -----------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType = "<c-n>"
if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

" Deoplete {{{2
" -----------------------------------------------------------------------------
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources#jedi#show_docstring = 1

" FZF {{{2
" -----------------------------------------------------------------------------
let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
let g:fzf_preview_lines_command = 'bat --color=always --style=grid --plain'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"' " Installed ripgrep
let g:fzf_preview_use_dev_icons = 0
let g:fzf_preview_dev_icons_limit = 10000

let g:fzf_layout = { 'window': {
            \ 'width': 0.9,
            \ 'height': 0.7,
            \ 'highlight': 'Comment',
            \ 'rounded': v:false } }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Git Messenger {{{2
" -----------------------------------------------------------------------------
let g:git_messenger_no_default_mappings = v:true

" Startify {{{2
" -----------------------------------------------------------------------------
let g:startify_change_to_dir = 0

" Coc {{{2
" -----------------------------------------------------------------------------
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Airline {{{2
" -----------------------------------------------------------------------------
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

let g:airline_theme='onedark'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.dirty='⚡'

"vim-airline theme
let g:airline_theme='onedark'

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#fnamemod = ':t'

" onedark {{{2
" -----------------------------------------------------------------------------
let g:onedark_terminal_italics = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme and visual {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color {{{2
" -----------------------------------------------------------------------------

" True color
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
    set termguicolors
endif

" Theme
colorscheme onedark

set winblend=10

" Puts line numbers for reference
set number relativenumber

" Switch syntax highlighting on, when the terminal has colors
syntax on

" Set color column at 80
set colorcolumn=80

" Change color of vertical split
hi VertSplit guibg=bg guifg=lightred

" Colors them grey.
"highlight LineNr guifg=grey

" Misc {{{2
" -----------------------------------------------------------------------------
" Switch on highlighting the last used search pattern.
set hlsearch

" Set insert cursor
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrc
      au!

      " Open NERDTree automatically"
      "autocmd vimenter * NERDTree
      "autocmd StdinReadPre * let s:std_in=1
      "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

      " Change focus to file"
      autocmd VimEnter * wincmd p

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      " Also don't do it when the mark is in the first line, that is the default
      " position when opening a file.
      autocmd BufReadPost *
                  \ if line("'\"") > 1 && line("'\"") <= line("$") |
                  \   exe "normal! g`\"" |
                  \ endif

      " Always show line numbers, but only in current window.
      :au WinEnter * :setlocal number relativenumber
      :au WinLeave * :setlocal nonumber norelativenumber

      " Switch to absolute line numbers in insert mode
      :au InsertEnter * :setlocal norelativenumber
      :au InsertLeave * :setlocal relativenumber

  augroup end

  " Tagbar {{{2
  " ---------------------------------------------------------------------------

  augroup tagbar
      au!
      " Open TagBar automatically"
      "autocmd FileType * call tagbar#autoopen(1) 
  augroup end

  " Coc {{{2
  " ---------------------------------------------------------------------------

  augroup coc
      au!
      " Highlight symbol under cursor on CursorHold
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

endif " has("autocmd")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions and commands {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" FZF {{{2
" -----------------------------------------------------------------------------

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Coc {{{2
" -----------------------------------------------------------------------------

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keys {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Leader
let mapleader=" "

" Use semicolon for commands
noremap ; :

" Terminal escape
tnoremap <Esc> <C-\><C-n>

" Control-L is escape.
 nmap <C-L> <ESC>
 imap <C-L> <ESC>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" buffer cycling
nnoremap <bs> <c-^>

" File
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>

" If we have mapped <C-i> to F6 using keyboard
nnoremap <F6> <C-i>

" Use tab to toggle folds
nnoremap <Tab> za

" Clear search
"nnoremap <C-l> :nohlsearch<cr>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" EasyAlign {{{2
" -----------------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Tagbar {{{2
" -----------------------------------------------------------------------------

" Toggle tagbar with F8
nmap <F8> :TagbarToggle<CR>

" Git Messenger {{{2
" -----------------------------------------------------------------------------

" Run GitMessenger
" Remapping here to get lazy loading
nmap <Leader>gm <Plug>(git-messenger)

" Fugitive {{{2
" -----------------------------------------------------------------------------

" Git blame
" Remapping here to get lazy loading
nmap <leader>gb :Gblame<enter>

" Vim Which Key {{{2
" -----------------------------------------------------------------------------

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

" FZF {{{2
" -----------------------------------------------------------------------------
nnoremap <silent> <Leader>fp     :<C-u>FzfPreviewFromResources mru directory<CR>
nnoremap <silent> <Leader>fgs    :<C-u>FzfPreviewGitStatus<CR>
nnoremap <silent> <Leader>fb     :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> <Leader>fB     :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> <Leader>fo     :<C-u>FzfPreviewFromResources buffer project_mru<CR>
nnoremap <silent> <Leader>f<C-o> :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> <Leader>fg;    :<C-u>FzfPreviewChanges<CR>
nnoremap <silent> <Leader>f/     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'"<CR>
nnoremap <silent> <Leader>f*     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          <Leader>fgr    :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          <Leader>fgr    "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> <Leader>ft     :<C-u>FzfPreviewBufferTags<CR>
nnoremap <silent> <Leader>fq     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> <Leader>fl     :<C-u>FzfPreviewLocationList<CR>

nnoremap <silent> <Leader>p      :<C-u>Buffers<CR>
nnoremap <silent> <Leader>/      :<C-u>RG<CR>
nnoremap <silent> <Leader>*      :<C-u>Rg <C-R><C-W><CR>

" Gundo {{{2
" -----------------------------------------------------------------------------

" Toggle Gundo with F5
nnoremap <F5> :GundoToggle<CR>

" Coc {{{2
" -----------------------------------------------------------------------------

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

" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)

" vim:foldmethod=marker:foldlevel=0
