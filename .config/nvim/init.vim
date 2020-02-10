"Base vim setup
" Jump to last open
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"Indentation rules for language
filetype plugin indent on
syntax on
"what am I typing
set showcmd
"what did I pick
set showmatch
"follow case like a normal person
set ignorecase
set smartcase
"I only have so much screen space
set wrap
set tw=80
"go back like a normal person
set backspace=indent,eol,start
"duh
set autoindent
set copyindent
"use hybrid line number
set relativenumber
set number
"whats open?
set title
"dont care if its not valid,dont tell me
set noerrorbells
"PLEASE SAVE ALL MY MISTAKES
"(when i didnt have this before i wiped my hosts file)
set undofile
set undolevels=100
set undoreload=1000
"reload when i change it with say git
set autoread
"manage buffers nicely
set hidden
"give it a little bigger of a bump when i go off the edge
set scrolloff=3
set sidescrolloff=5
"i dont want to press enter when a command is done
set shortmess=atI
"the extension likely isnt lying
filetype plugin on
"visualize whitepsace
set listchars=tab:→→,trail:●,nbsp:○
set list
"share vim and system clipboard
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
endif
"ex mode is BS disable it
nnoremap Q <nop>
"this is why we have airline
set noshowmode
"delete comment character when joining commented lines
set formatoptions+=j
"this enables true color support but will break how everything looks if you
"use a terminal that doesnt support it such as urxvt
set tgc
"set the encodings to be sane
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
"tabs are bad, also set this after encoding or weird things happen
set expandtab
"4 spaces is only spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set leader to ;; (default is backslash \)
let mapleader = ";"
"tell me whats going on
"only enable when stuff breaks and you dont know why
"let &verbose = 1
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/bash
endif
"for full code pastes may as well use pastemode
set pastetoggle=<leader>v

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

"to avoid the mistake of uppercasing these
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa

"make sure i can actually save my stuff somewhere
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views':  'viewdir',
                \ 'swap':   'directory',
                \ 'undo':   'undodir' }

    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
    let g:scratch_dir = common_dir . 'scratch'. '/'
    if exists("*mkdir")
        if !isdirectory(g:scratch_dir)
            call mkdir(g:scratch_dir)
        endif
    endif
    if !isdirectory(g:scratch_dir)
        echo "Warning: Unable to create scratch directory: " . g:scratch_dir
        echo "Try: mkdir -p " . g:scratch_dir
    endif
endfunction
call InitializeDirectories()

"==>all fancy plugin/magic stuff<==

"ensure we actually have vim plug
let s:vim_plug = '~/.local/share/nvim/site/autoload/plug.vim'
"if we dont have vimplug yet use this to disable erring first run sections
let s:first_run = 0
if empty(glob(s:vim_plug, 1))
    let s:first_run = 1
    execute 'silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

"been around for ages yet isnt default for % to match if else etc
runtime macros/matchit.vim

"extra keybinds
"to quickly clear highlight press ^/
nmap <C-_> :nohlsearch<CR>
"split nav with control dir
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>
"scroll with alt directions
nnoremap <A-j> <C-e>
nnoremap <A-k> <C-y>
"change buffer with Ctrl+Shfit+Tab
nnoremap <S-Tab> :bnext<CR>
"close all buffer except the current one
nnoremap <leader>ca :w <bar> %bd <bar> e# <bar> bd# <CR><CR>
"tab nav with alt
nnoremap <A-h> gT
nnoremap <A-l> gt
"tab management with t leader
nnoremap tn :tabnew<CR>
nnoremap tq :tabclose<CR>
"so that line wraps are per terminal line not per global line
nnoremap j gj
nnoremap k gk
"work around for mouse selection to clipboard
"if term supports mouse then the selection will be visual anyway
vnoremap <LeftRelease> "*ygv
"i dont actually want visual mode mouse control
"but i still do want scroll and cursor clicking
set mouse=ni

"Navigating with guides/placeholders
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

"some of these require the neovim pip package
call plug#begin('~/.local/share/nvim/plugged')
"Plug 'isaacmorneau/vim-fibo-indent' "for maximal indentation viewing pleasure
Plug 'SirVer/ultisnips' "who knew? turns out snippets are a thing and they are dope!
Plug 'airblade/vim-gitgutter' " The git gutter being the extra column tracking git changes by numbering
Plug 'chrisbra/Colorizer' "highlight hex codes with the color they are
Plug 'honza/vim-snippets' "we do actually need the snippets as they are not in the engine
Plug 'joshdick/onedark.vim' "main color theme
Plug 'junegunn/fzf' "fuzzy jumping arround
Plug 'junegunn/vim-easy-align' "allow mappings for lots of aligning
Plug 'luochen1990/rainbow' "rainbow highlight brackets
Plug 'mhinz/vim-startify' "A nice start menu
Plug 'mtth/scratch.vim' "notes file that saves daily
"Plug 'neomake/neomake' "do full syntax checking for most languages
Plug 'ntpeters/vim-better-whitespace' "show when there is gross trailing whitespace
Plug 'sbdchd/neoformat' "allows the formatting of code sanely
Plug 'scrooloose/nerdtree' "file browser
"Plug 'sheerun/vim-polyglot' "a super language pack for a ton of stuff
Plug 'tpope/vim-surround' "change things surounding like ()->[]
Plug 'vim-airline/vim-airline' "a statusbar
Plug 'vim-airline/vim-airline-themes' "themes for the statusbar
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } "lively previewing LaTeX PDF output
Plug 'lervag/vimtex' "modern vim plugin for editing LaTeX files
Plug 'racer-rust/vim-racer' "auto-completion for rust
Plug 'alx741/vim-rustfmt' "rustfmt https://github.com/alx741/vim-rustfmt
Plug 'jremmen/vim-ripgrep' "integrate ripgrep into vim
Plug 'stefandtw/quickfix-reflector.vim' "this makes ripgrep works with vim much better
Plug 'tpope/vim-fugitive' "Git wrapper for vim
Plug 'LokiChaos/vim-tintin' "tintin++ syntax highlighting

"horribly slow dont use neoinclude its several orders of magnitude higher
"Plug 'Shougo/neoinclude.vim' "also check completion in includes
"looks good but one of these slows down scrolling (probably both)
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "file type icons < this is the slow one
"this one also causes vim scratch and nerd tree to go into a forever loop.
"Plug 'Xuyuanp/nerdtree-git-plugin' "filebrowser git status

"this needs to go after other syntax plugins so it can override their rules
Plug 'dodie/vim-disapprove-deep-indentation'
"this should always be the last plugin
Plug 'ryanoasis/vim-devicons'

"[startify]
"this needs to before plug end or it wont take
let g:startify_custom_header = ['   ███╗███╗   ██╗███╗██╗   ██╗██╗███╗   ███╗',
            \'   ██╔╝████╗  ██║╚██║██║   ██║██║████╗ ████║',
            \'   ██║ ██╔██╗ ██║ ██║██║   ██║██║██╔████╔██║',
            \'   ██║ ██║╚██╗██║ ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            \'   ███╗██║ ╚████║███║ ╚████╔╝ ██║██║ ╚═╝ ██║',
            \'   ╚══╝╚═╝  ╚═══╝╚══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝']

let g:startify_lists = [
            \ { 'type': 'files',    'header': [ 'MRU']      },
            \ { 'type': 'commands', 'header': [ 'Commands'] },
            \ ]
"i dont want to be moved to a dir if chose a file there
let g:startify_change_to_dir = 0
"tried to be clever and make this the winheight - padding so it filled the
"screen but turns out that winheight isnt correct at this point in the config
"and it needs to be here to be respected
let g:startify_files_number = 25
call plug#end()

"i put this here so it doesnt look dumb when doing an update and the colors
"are not appllied
if s:first_run == 0
    colorscheme onedark
endif
set background=dark

"check if we need an upgrade or an update
command! PU PlugUpgrade | PlugUpdate | UpdateRemotePlugins

let s:need_install = keys(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
let s:need_clean = len(s:need_install) + len(globpath(g:plug_home, '*', 0, 1)) > len(filter(values(g:plugs), 'stridx(v:val.dir, g:plug_home) == 0'))
let s:need_install = join(s:need_install, ' ')

"when entering a terminal enter in insert mode
autocmd BufWinEnter,WinEnter term://* startinsert

"first install stuff
if s:first_run
    echom '==>Initial Setup<=='
    echom 'Several packages require the python3 neovim package. Please install this to have full functionality.'
    echom 'After neovim is installed restart nvim to complete the install.'
endif
if has('vim_starting')
    if s:need_clean
        autocmd VimEnter * PlugClean!
    endif
    if len(s:need_install)
        if s:first_run
            execute 'autocmd VimEnter * PlugInstall --sync' s:need_install '| source $MYVIMRC | only! | term'
        else
            execute 'autocmd VimEnter * PlugInstall --sync' s:need_install ' | source $MYVIMRC'
        endif
        finish
    endif
else
    if s:need_clean
        PlugClean!
    endif
    if len(s:need_install)
        if s:first_run
            execute 'PlugInstall --sync' s:need_install | source $MYVIMRC | only! | term
        else
            execute 'PlugInstall --sync' s:need_install | source $MYVIMRC
        endif
        finish
    endif
endif

"[one]
"it was the first run so now we need to enable it again
if s:first_run == 1
    colorscheme onedark
endif
"nice transparent background
"(actually looks really bad with one, i just leave it here so i dont make the
"same mistake again)
"hi Normal ctermbg=NONE

"[NerdTree]
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
let g:NERDTreeSortHiddenFirst=1
"^n to open the file browser
map <C-n> :NERDTreeFocus<CR>
"close if its the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"[fzf]
map <C-m> :FZF<CR>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" The Silver Searcher
if executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
    set grepprg=ag\ --nogroup\ --nocolor
endif

" ripgrep
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

"[Polyglot]
let g:polyglot_disable = ['latex'] "disable LaTeX-Box and use vimtex plug instead

"[Easy Align]
"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"[Airline]
set laststatus=2
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"airline symbols
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1

"[NeoMake]
" When reading a buffer (after 1s), and when writing (no delay).
"call neomake#configure#automake('rw', 1000)
"
"let g:neomake_javascript_jshint_maker = {
"            \ 'args': ['--verbose'],
"            \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
"            \ }
"let g:neomake_javascript_enabled_makers = ['jshint']
"let g:neomake_rust_enabled_makers = ['cargo']
"let g:neomake_cargo_args = ['check']


"[Scratch]
let g:scratch_persistence_file = g:scratch_dir . strftime("scratch_%Y-%m-%d")
let g:scratch_no_mappings = 1
nmap <silent> gs <plug>(scratch-insert-reuse)
xmap <silent> gs <plug>(scratch-selection-reuse)
nnoremap gZzZz gs

"[ultisnips]
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsSnippetDirectories=["~/.local/snippets"]

"[rainbow]
let g:rainbow_active = 1
"honestly the default config is fine

"[neoformat]
"good for debugging broken formatters
"let g:neoformat_verbose = 1
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_c_clang_format = {
    \ 'exe': 'clang-format',
    \ 'args': ['-style=~/.clang-format'],
    \ }
let g:neoformat_cpp_clang_format = {
    \ 'exe': 'clang-format',
    \ 'args': ['-style=~/.clang-format'],
    \ }

let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_enabled_cpp = ['clangformat']
nmap <C-f> :Neoformat<CR>

"[LookOfDisaproval]
let g:LookOfDisapprovalTabThreshold=5
let g:LookOfDisapprovalSpaceThreshold=(&tabstop*4)

"[vim-racer]
let g:racer_cmd = "/home/rudo/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"[vim-rustfmt]
let g:rustfmt_on_save = 1
let g:rustfmt_edition = '2018'
let g:rustfmt_backup = 0

""" ALL THE LATEX GOODNESS
"[vimtex]
" This will let us compile document with syntax highlighting (minted package)
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
" To prevent conceal in LaTeX files
let g:tex_conceal = ''
" To prevent conceal in any file
let conceallevel = 0
" put these in echo $VIMRUNTIME/indent/tex.vim
" let g:tex_indent_items = 0
" let g:tex_indent_brace = 0
"[vim-latex-live-preview] "https://github.com/xuhdev/vim-latex-live-preview
let g:livepreview_previewer = 'qpdfview' "insert your fav pdf viewer here
"let g:livepreview_engine  = 'your_engine'
"let g:livepreview_cursorhold_recompile = 0

" Word count:
    autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
    " Code snippets
    autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
    autocmd FileType tex inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
    autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
    autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
    autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
    autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
    autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
    autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
    autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
    autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
    autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
    autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ,li <Enter>\item<Space>
    autocmd FileType tex inoremap ,lv \selectlanguage{vietnamese}<Enter>
    autocmd FileType tex inoremap ,le \selectlanguage{english}<Enter>
    autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
    autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
    autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ,v io{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
    autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
    autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
    autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
    autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
    autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
    autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ,bt {\blindtext}
    autocmd FileType tex inoremap ,nu $arnothing$
    autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
    autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i
    "live preview with leader pv (preview)
    autocmd FileType tex map <leader>pv :LLPStartPreview<CR>
"i dont know what adds this bullshit but its annoying as hell
let g:omni_sql_no_default_maps = 1
