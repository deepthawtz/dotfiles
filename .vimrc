" ==== Plugins =====================  {{{
" ==================================
filetype off

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'bruno-/vim-husk'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'sickill/vim-pasta'
" Plug 'rking/ag.vim', { 'on': 'Ag' }
" Plug 'scratch.vim', { 'on': 'Scratch' }
" Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/gitignore'
Plug 'editorconfig/editorconfig-vim'
" Plug 'SirVer/ultisnips'
Plug 'cespare/vim-toml'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/molokai'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'

" Language support
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" Plug 'tpope/vim-rails', { 'for': 'ruby' }
" Plug 'tpope/vim-cucumber', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

Plug 'fatih/vim-go'
Plug 'dense-analysis/ale'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/vim-hclfmt'

" Avro
Plug 'gurpreetatwal/vim-avro'

" COFEESCRIPT
" Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" HANDLEBARS
" Plug 'nono/vim-handlebars', { 'for': 'handlebars' }

" JADE
" Plug 'digitaltoad/vim-jade', { 'for': 'jade' }

" SLIM
" Plug 'slim-template/vim-slim', { 'for': 'slim' }

" EMBLEM
" Plug 'heartsentwined/vim-emblem', { 'for': 'emblem' }

" JAVASCRIPT
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'

" The best colors
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }

call plug#end()

" }}}

" ==== General ===================== {{{
" ==================================
filetype plugin indent on
syntax enable

set shell=/bin/zsh " Use zsh as shell
" set foldmethod=syntax " fold based on syntax
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " dont fold by default
" set foldlevel=1 " this is just what i use
set modelines=0 " turn off modelines
set tabstop=2  " 2 space indents by default
set shiftwidth=2 " ...
set softtabstop=2 " ...
set expandtab " ...
" set undofile " Save a file of all of the undos
set undolevels=400 " Maximum number of changes that can be undone
set backupdir=~/.vim/vimtmp,. " store backups in the .vim directory
set directory=~/.vim/vimtmp,. " ...
set undodir=~/.vim/vimtmp,. " ...
set encoding=utf-8 " Always use UTF8 encodding
set scrolloff=3 " Min. lines to keep above or below the cursor when scrolling
set autoindent " Auto indent new lines
set noshowmode " Don't show current mode, let airline handle that
set hidden " Don't unload buffers when leaving them
set wildmenu " Enable command-line like completion
set wildmode=list:longest " List all matches and complete till longest common string
set visualbell " Disable annoying beep
set cursorline " Show line where cursor is
set ruler " Show current cursor position
set backspace=indent,eol,start " Backspace over everything in insert mode
set laststatus=2 " Always show the status line
set number
" set relativenumber " Use relative line numbers
set ignorecase " Ignore case when searching
set smartcase " Be case sensitive when there are capital letters
set gdefault " Globally replace be default
set incsearch " Start searching after first letter
set showmatch " Show the matching paren when hovering over one
set hlsearch " Highlight found search results
set splitbelow " Split below by default
set splitright " Split to the right by default
set textwidth=79 " Wrap text around the 79 column
set formatoptions=qrn1 " Misc formating options
set colorcolumn=100 " Color the 100th column
set pastetoggle=<F3> " Go into paste mode with F3
set complete=.,b,u,] " Tab complete correctly
set t_Co=256 " Give me all the colors pls
set nobackup " Don't make backups
set noswapfile " Don't make swap files
set list " Show unprintable characters
set listchars=tab:▸\  " Char representing a tab
set listchars+=extends:❯ " Char representing an extending line
set listchars+=precedes:❮ " Char representing an extending line in the other direction
set listchars+=nbsp:␣ " Non breaking space
set listchars+=trail:· " Show trailing spaces as dots
set showbreak=↪  " Show wraped lines with this char
set linebreak " Don't break lines in the middle of words
set fillchars+=vert:\  " Don't show pipes in vertical splits
set background=dark " I use a dark background
set nowrap " Don't wrap lines

" colorscheme Tomorrow-Night-Bright
let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai
" let g:gruvbox_italic=1
colorscheme gruvbox

let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}
let g:ale_fix_on_save = 1
call ale#linter#Define('go', {
\   'name': 'revive',
\   'output_stream': 'both',
\   'executable': 'revive',
\   'read_buffer': 0,
\   'command': 'revive %t',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\})

" }}}

" ==== Auto commands =============== {{{
" ==================================

fun! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfun

augroup miscGroup
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufWritePre * call StripTrailingWhitespace()
  autocmd FileType snippets let b:noStripWhitespace=1
  autocmd FocusLost * :wa " Save on focus

  autocmd BufNewFile,BufRead Gemfile set filetype=ruby
  autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
  autocmd BufNewFile,BufRead Berksfile set filetype=ruby
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  "Fugitive
  autocmd QuickFixCmdPost *grep* cwindow " Auto open quickfix after grep
  autocmd QuickFixCmdPost *log* cwindow " Auto open quickfix after log

  "Spelling
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd FileType gitcommit setlocal spell

  " vim-go shortcuts
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
augroup END

" }}}

" ==== Mappings ==================== {{{
" ==================================

" Rspec
map <Leader>t :call RunCurrentSpecFile()<CR>

"NERDTree
map <F2> :NERDTreeToggle<CR>

"Gundo
nnoremap <F5> :GundoToggle<CR>

" `noremap` means to make a nonrecursive mapping
" that means that vim will not take other mapping
" into account when doing your new map

" Disable useless and annoying keys
noremap Q <Nop>
noremap K <Nop>

" Remap :E to :e
cnoreabbrev <expr> E getcmdtype() == ":" && getcmdline() == "E" ? "e" : "E"
" Remap :W to :w
cnoreabbrev <expr> W getcmdtype() == ":" && getcmdline() == "W" ? "w" : "W"
cnoreabbrev <expr> Q getcmdtype() == ":" && getcmdline() == "q" ? "q" : "Q"

" Make Y work as expected
nnoremap Y y$

" Always use very magic regex mode when searching
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v

nnoremap <tab> %
vnoremap <tab> %

" Resize windows with the arrow keys
" nnoremap <up> <C-W>+
" nnoremap <down> <C-W>-
" nnoremap <left> 3<C-W>>
" nnoremap <right> 3<C-W><

" toggle wrap
nmap <C-H> :set wrap!<bar>set wrap?<CR>

" Don't use those stupid arrow keys!
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

"Don't need help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"Fast escapes
inoremap jj <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

"Tabcomplete
imap <Tab> <C-P>

" Fix for nvim
if has('nvim')
  nmap <BS> <C-W>h
endif

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
vmap <C-L> :Align "="<CR>

" cool window commands
map  <C-J> <C-W>j<C-W>_
map  <C-K> <C-W>k<C-W>_

" }}}

" ==== Leader Mappings ============= {{{
" ==================================

let mapleader=","
let maplocalleader = '\\'

" nnoremap <leader><space> :noh<cr>
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <leader><leader> :CtrlP<cr>


"-- a --"
"-- b --"
nnoremap <leader>b :CtrlPBuffer<CR>
"-- c --"
"-- d --"
vmap <leader>d "+d
"-- e --"
"-- f --"
nnoremap <leader>ff :NERDTreeFind<CR>
nnoremap <leader>F :CtrlPMRUFiles<CR>
"-- g --"
nnoremap <leader>git :e ~/.gitconfig<cr>
nnoremap <leader>gs [<C-d><cr>
"-- h --"
nnoremap <leader>hr :%s/\v:(\w+) \=\> /\1: /<CR>
"-- i --"
"-- j --"
"-- k --"
"-- l --"
nnoremap <leader>l :call NumberToggle()<cr>
"-- m --"
nnoremap <leader>md :!mkdir -p %:p:h<cr>
"-- n --"
"-- o --"
"-- p --"
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P
"-- q --"
"-- r --"
nnoremap <leader>rvim :so $MYVIMRC<cr>
nnoremap <leader>rs :call RunCurrentSpecFile()<cr>
nnoremap <leader>rts :call RunNearestSpec()<cr>
"-- s --"
nnoremap <leader>S :%S/<C-r><C-w>/
"-- t --"
nnoremap <leader>tmux :e ~/.tmux.conf<cr>
"-- u --"
" nnoremap <leader>us :UltiSnipsEdit<cr>
"-- v --"
" Edit vimrc file
nnoremap <leader>vim :e $MYVIMRC<CR>
"-- w --"
"-- x --"
"-- y --"
vmap <leader>y "+y
"-- z --"
nnoremap <leader>zsh :e ~/.zshrc<cr>

" }}}


" === Abolish ============== {{{
" ==========================



" }}}

" ==== Misc Plugin Configs ========= {{{
" ==================================

" go-vim Settings
let g:go_fmt_command = "goimports"
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
" let g:go_auto_type_info = 1
" set updatetime=100
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" Gundo Settings
let g:gundo_right = 1

"Syntastic Settings
" let g:syntastic_debug=1
" let g:syntastic_enable_signs=1
" let g:syntastic_auto_jump=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_html_validator_parser='html5'
" let g:syntastic_ruby_mri_exec='/Users/dc/.rbenv/versions/2.5.1/bin/ruby'
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" let g:syntastic_sass_checkers = []
" let g:syntastic_scss_checkers = []
" " let g:syntastic_javascript_checkers = ['`npm bin`/eslint']
" let g:syntastic_html_checkers = []
" let g:syntastic_python_checkers = []
" let g:loaded_syntastic_chef_foodcritic_checker=1

" ctrlp
set runtimepath^=~/.nvim/bundle/ctrlp.vim

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|tmp|ebin|deps|logs|docs|public|node_modules|vendor)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" vim-spec
let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"

" airline
let g:airline_theme='tomorrow'

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" editorconfig-vim
" Work with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ultisnips
" let g:UltiSnipsExpandTrigger="<leader><tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" ==== Functions =============== {{{
" ==================================

"Switch between numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

"Find replace in a project
function! FindReplace(find, replace)
  call Ag(find)
  call Cdo
endfunc

com! -range Align <line1>,<line2>call AlignOnRE(<q-args>)
fun! AlignOnRE(re) range
    let last = 0
    let i = a:firstline
    while i <= a:lastline
        exec "let col" . i . "= match(getline(i)," . a:re . ")"
        exec 'if col' . i . '> last | let last = col' . i . '| endif'
        let i = i + 1
    endwhile
    let i = a:firstline
    while i <= a:lastline
        exec ' let col = col' . i
        if col > 0
            exec 'let N = last - col' . i
            let s = ""
            let j = 1
            while j <= N
                let s = s . " "
                let j = j + 1
            endwhile
            let dots = strpart(getline(i), 0, col)
            let dots = substitute(dots, '.', '.', 'g')
            let str = substitute(getline(i), '^' . dots, '&' . s, '')
            call setline(i, str)
        endif
        let i = i + 1
    endwhile
endfunc

" }}}
