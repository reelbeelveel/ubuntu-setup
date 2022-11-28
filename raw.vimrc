" asdnsad Modified: 
let fancy_symbols_enabled = 1

set encoding=utf-8
set hidden
set ttimeoutlen=50
"set showtabline=0
let using_neovim = has('nvim')
let using_vim = !using_neovim

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing
let g:polyglot_disabled = ['autoindent']
let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif

" Now the actual plugins:

" Override configs by directory BREAKS SCP
" Plug 'arielrossanigo/dir-configs-override.vim'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" Better file browser
Plug 'scrooloose/nerdtree'
" Class/module browser
Plug 'majutsushi/tagbar'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Async autocompletion
"Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'
" Surround
 Plug 'tpope/vim-surround'
" Indent text object
Plug 'michaeljsmith/vim-indent-object'
" Indentation based movements
"Plug 'jeetsukumaran/vim-indentwise'
" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Window chooser
Plug 't9md/vim-choosewin'
" Generate html in a simple way
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Linters
Plug 'neomake/neomake'
" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'
" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

Plug 'edkolev/tmuxline.vim'

Plug 'jreybert/vimagit'

Plug 'chrisbra/csv.vim'

Plug 'scrooloose/syntastic'

Plug 'kien/ctrlp.vim'        
Plug 'tmhedberg/SimpylFold'  
Plug 'Xuyuanp/nerdtree-git-plugin'

" ALE for in-vim Linting
Plug 'dense-analysis/ale'
" Gutentags Auto Tag generator
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'NLKNguyen/pipe.vim'
Plug 'skywind3000/vim-rt-format'
Plug 'tpope/vim-commentary'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-characterize'
Plug 'github/copilot.vim', {'branch': 'release'}

if using_vim                 
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

" Code searcher. If you enable it, you should also configure g:hound_base_url
" and g:hound_port, pointing to your hound instance
" Plug 'mattn/webapi-vim'
" Plug 'jfo/hound.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    " no vi-compatible
    set nocompatible

    " allow plugins by file type (required for plugins!)
    filetype plugin on
    filetype indent on

    " always show status bar
    set ls=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    " syntax highlight on
    syntax on

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" show line numbers
set nu

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256\|screen\|xterm-kitty')
    if !has('gui_running')
        let &t_Co = 256
    endif
    colorscheme miamineon
endif

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

ca w!! w !sudo tee "%"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=6

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" ALE
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_fixers = {'javascript' : ['eslint']}

let g:ale_fix_on_save = 1

" COC ----
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" SimpylFold ---------------------------
let g:SimpylFold_docstring_preview=1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter *  call NERDTreeRefresh()

autocmd StdinReadPre * let s:std_in=1 
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | redraw | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_enabled_makers = ['pylint']

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 0

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,t :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wT :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,T :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wT :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

" Deoplete -----------------------------

" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" mappings
nmap ,r :Ack
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif

" Airline ------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'miamineon'
let g:airline#extensions#whitespace#enabled = 1

let g:airline#extensions#ctrlspace#enabled = 1
let g:airline#extensions#default#enabled = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#vimagit#enabled = 1

" Airline Extension Config

" vim-obsession
let g:airline#extensions#obsession#indicator_text = '💾'

" airline-tabline
set showtabline=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:xtabline_include_previews = 0

"nmap <C-T>1 <Plug>AirlineSelectTab1
"nmap <C-T>2 <Plug>AirlineSelectTab2
"nmap <C-T>3 <Plug>AirlineSelectTab3
"nmap <C-T>4 <Plug>AirlineSelectTab4
"nmap <C-T>5 <Plug>AirlineSelectTab5
"nmap <C-T>6 <Plug>AirlineSelectTab6
"nmap <C-T>7 <Plug>AirlineSelectTab7
"nmap <C-T>8 <Plug>AirlineSelectTab8
"nmap <C-T>9 <Plug>AirlineSelectTab9
"nmap <C-T>- <Plug>AirlineSelectPrevTab
"nmap <C-T>+ <Plug>AirlineSelectNextTab


if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
    let g:airline_symbols.maxlinenr = ' '
else
    let g:webdevicons_enable = 0
endif

" Custom configurations ----------------
let g:airline#extensions#coc#enabled = 1

" TMUXline -----------------------------
let airline#extensions#tmuxline#snapshot_file =
   \  "~/.tmuxlinerc"
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
      \'a'    : '',
      \'c'    : '#(whoami)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', ''],
      \'y'    : ['%a.','%I:%M:%S','%d'],
      \'z'    : '#H'}

let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '',
    \ 'right' : '',
    \ 'right_alt' : '',
    \ 'space' : ' '}

"MAKE COLORS WORKY"
"set term=pcansi
colorscheme miamineon

" ===== Remaps =====
" " --- Functions ---

let g:helpList = []

function! KBV_set_maps(mappings)
    for keymap in a:mappings
        let mapstring = keymap[3] . ' ' . keymap[1] . ' ' . keymap[2]
        execute mapstring
        call add(g:helpList, keymap)
    endfor
endfunction

function! Toggle_mouse()
    if &mouse=='a'
        set mouse=
    else
        set mouse=a
    endif
endfunction

function! LaunchCursor()
    :silent !launch <cfile>
endfunction

function! LaunchMyself()
    :silent !launch %
endfunction

function! CommandHelp()

    let tempList = []
    call add(tempList, ['Title', 'Inputs', 'Function'])

    execute 'source ~/.vim/helpList.vim'
    call uniq(sort(g:helpList ,'i'))

    for entry in g:helpList
        call add(tempList, entry)
    endfor

    echohl Title
    for entry in tempList
        let name = string(entry[0])[1:-2]
        let inputs = string(entry[1])[1:-2]
        let fnction = string(entry[2])[1:-2]
        while len(name) < 30
            let name = name . ' '
        endwhile
        while len(inputs) < 18
            let inputs = inputs . ' '
        endwhile
        while len(fnction) < 40
            let fnction = fnction . ' '
        endwhile
        echom '| ' . name . '| ' . inputs . '| ' . fnction '|'
        echohl Normal
    endfor
endfunction

function! AddCmndHelp() abort
    let name = ''
    while name == ''
        let name = input("Input a name for the command to be added. ")
        if len(string(name)) > 30
            echo "\n"
            echohl Error
            echom "Input too long! Summarize or change settings."
            echohl Normal
            let name = ''
        endif
    endwhile

    while len(name) < 30
        let name = name . ' '
    endwhile

    let inputs = ''
    while inputs == ''
        let inputs = input("Inputs for this command? ")
        if len(inputs) > 18
            echo "\n"
            echohl Error
            echom "Input too long! Summarize or change settings."
            echohl Normal
            let inputs = ''
        endif
    endwhile

    while len(inputs) < 18
        let inputs = inputs . ' '
    endwhile

    let fnction = ''
    while fnction == ''
        let fnction = input("Function of this command? ")
        if len(fnction) > 40
            echo "\n"
            echohl Error
            echom "Input too long! Summarize or change settings."
            echohl Normal
            let fnction = ''
        endif
    endwhile

    while len(fnction) < 40
        let fnction = fnction . ' '
    endwhile

    let tempList = [name, inputs, fnction]
    call add(g:helpList, tempList)
    let l:entryString = "call add(g:helpList, [\"" . name . "\",\"" . inputs . "\",\"" . fnction . "\"])"
    let tempList = [l:entryString]
    call writefile(tempList, glob("~/.vim/helpList.vim"), "a")
endfunction

let kbv_maps = []
call add(kbv_maps, ["git push", ",gp", ":silent !git push<CR>", "nmap"])
call add(kbv_maps, ["jekyll serve", ",js", ":Gcd<CR>:!jekyll serve<CR>", "nmap"])
call add(kbv_maps, ["tgMagit", ",vg", ":Magit<CR>", "nmap"])
call add(kbv_maps, ["tgDeoplete", "<C-T><F1>", ":call deoplete#toggle()<CR>", "map"])
call add(kbv_maps, ["usels"     , "<C-T><F9>", ":ls<CR>", "map"])
call add(kbv_maps, ["windowNavJ", "<C-J>", "<C-W><C-J>", "tmap"])
call add(kbv_maps, ["windowNavK", "<C-K>", "<C-W><C-K>", "tmap"])
call add(kbv_maps, ["windowNavL", "<C-L>", "<C-W><C-L>", "tmap"])
call add(kbv_maps, ["windowNavH", "<C-H>", "<C-W><C-H>", "tmap"])
call add(kbv_maps, ["windowNavJ", "<C-J>", "<C-W><C-J>", "nnoremap"])
call add(kbv_maps, ["windowNavK", "<C-K>", "<C-W><C-K>", "nnoremap"])
call add(kbv_maps, ["windowNavL", "<C-L>", "<C-W><C-L>", "nnoremap"])
call add(kbv_maps, ["windowNavH", "<C-H>", "<C-W><C-H>", "nnoremap"])
call add(kbv_maps, ["addHelp", "<C-T>a" , ":call AddCmndHelp()<CR>" , "nmap"])
call add(kbv_maps, ["mapHelp", "<C-T>h" , ":call CommandHelp()<CR>" , "nmap"])
call add(kbv_maps, ["launchC", "<C-T>lc", ":call LaunchCursor()<CR>", "nmap"])
call add(kbv_maps, ["launchS", "<C-T>ls", ":call LaunchMyself()<CR>", "nmap"])
call add(kbv_maps, ["tgMouse", "<C-T>m" , ":call Toggle_mouse()<CR>", "nmap"])
call add(kbv_maps, ["vsource", "<C-T>`" , ":source ~/.vimrc<CR>"    , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>1", "<Plug>AirlineSelectTab1" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>2", "<Plug>AirlineSelectTab2" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>3", "<Plug>AirlineSelectTab3" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>4", "<Plug>AirlineSelectTab4" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>5", "<Plug>AirlineSelectTab5" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>6", "<Plug>AirlineSelectTab6" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>7", "<Plug>AirlineSelectTab7" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>8", "<Plug>AirlineSelectTab8" , "nmap"])
call add(kbv_maps, ["airlnTab#","<C-T>9", "<Plug>AirlineSelectTab9" , "nmap"])
call add(kbv_maps, ["airlnTab-","<C-T>-", "<Plug>AirlineSelectPrevTab", "nmap"])
call add(kbv_maps, ["airlnTab+","<C-T>+", "<Plug>AirlineSelectNextTab", "nmap"])
call add(kbv_maps, ["xTabsToggle", "<F5>", "<Plug>XTablineToggleTabs"  , "nmap"])
call add(kbv_maps, ["xTabsReopen","<C-T>r", "<Plug>XTablineReopen <SID>ReopenLastTab", "nmap"])
call add(kbv_maps, ["fBuffnext", "]l"   , "<Plug>XTablineNextBuffer"  , "nmap"])
call add(kbv_maps, ["fBuffprev", "[l"   , "<Plug>XTablinePrevBuffer"  , "nmap"])

call add(kbv_maps, ["addHelp", "<C-T>a" , "<Esc>:call AddCmndHelp()<CR>" , "imap"])
call add(kbv_maps, ["mapHelp", "<C-T>h" , "<Esc>:call CommandHelp()<CR>" , "imap"])
call add(kbv_maps, ["launchC", "<C-T>lc", "<Esc>:call LaunchCursor()<CR>", "imap"])
call add(kbv_maps, ["launchS", "<C-T>ls", "<Esc>:call LaunchMyself()<CR>", "imap"])
call add(kbv_maps, ["tgMouse", "<C-T>m" , "<Esc>:call Toggle_mouse()<CR>", "imap"])
call add(kbv_maps, ["vsource", "<C-T>`" , "<Esc>:source ~/.vimrc<CR>"    , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>1", "<Esc><Plug>AirlineSelectTab1" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>2", "<Esc><Plug>AirlineSelectTab2" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>3", "<Esc><Plug>AirlineSelectTab3" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>4", "<Esc><Plug>AirlineSelectTab4" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>5", "<Esc><Plug>AirlineSelectTab5" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>6", "<Esc><Plug>AirlineSelectTab6" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>7", "<Esc><Plug>AirlineSelectTab7" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>8", "<Esc><Plug>AirlineSelectTab8" , "imap"])
call add(kbv_maps, ["airlnTab#","<C-T>9", "<Esc><Plug>AirlineSelectTab9" , "imap"])
call add(kbv_maps, ["airlnTab-","<C-T>-", "<Esc><Plug>AirlineSelectPrevTab", "imap"])
call add(kbv_maps, ["airlnTab+","<C-T>+", "<Esc><Plug>AirlineSelectNextTab", "imap"])

call add(kbv_maps, ["chooseWin (slct)","<C-T>w-", "<Plug>(choosewin)","nmap"])
call add(kbv_maps, ["chooseWin (swap_w/)","<C-T>wo", ":ChooseWinSwap<CR>","nmap"])
call add(kbv_maps, ["chooseWin (swap_to)","<C-T>wp", ":ChooseWinSwapStay<CR>","nmap"])

" Hypershift leader
let mapleader="" 

call add(kbv_maps, ["redraw", "<Leader>r",":silent redraw!<CR>","map"])
call add(kbv_maps, ["ALE prev", "[c", "<Plug>(ale_previous_wrap)", "nmap"])
call add(kbv_maps, ["ALE next", "]c", "<Plug>(ale_next_wrap)", "nmap"])
call add(kbv_maps, ["ALE Fix", "<F6>", "<Plug>(ale_fix)", "nmap"])
call add(kbv_maps, ["IDsyntax", "<C-T>g", ":call SynStack()<CR>", "nmap"])
call add(kbv_maps, ["QuickInclude", "<C-T>i", "G?#include<CR>o#include <>\<esc>i", "nmap"])

call KBV_set_maps(kbv_maps)

" Enable folding
set foldlevel=99
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END
" Enable folding with the spacebar
nnoremap <space> za
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <Up> <Up>
inoremap <Down> <Down>
inoremap <Left> <Left>
inoremap <Right> <Right>

" fill/listchars
set fillchars=vert:\▚
set fillchars=fold:\▚
set list
set listchars=tab:>-
set listchars=trail:░
set noshowmode

set whichwrap+=<,>,h,l,[,]

set cursorline

set splitbelow
set splitright

set textwidth=0
set mouse=a

" Date Time stuff"
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    if (&filetype=='html' || &filetype=='htmldjango')
    keepjumps exe '1,' . n . 's#^\(.\{,10}modified: \).*#\1' .
        \ strftime('%a %B %d, %Y @ %I:%M:%S %Z -->') . '#e'
    elseif (&filetype=='css')
    keepjumps exe '1,' . n . 's#^\(.\{,10}modified: \).*#\1' .
        \ strftime('%a %B %d, %Y @ %I:%M:%S %Z */') . '#e'
    else
    keepjumps exe '1,' . n . 's#^\(.\{,10}modified: \).*#\1' .
        \ strftime('%a %B %d, %Y @ %I:%M:%S %Z') . '#e'
    endif
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()

" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastRevised()
  if &modified
    let save_cursor = getpos(".")
    let n = min([40, line("$")])
    if (&filetype=='html' || &filetype=='htmldjango')
        keepjumps exe '1,' . n . 's#^\(.\{,30}revised: \).*#\1' .
            \ strftime('%a %B %d, %Y @ %I:%M:%S %Z -->') . '#e'
    elseif (&filetype=='css')
        keepjumps exe '1,' . n . 's#^\(.\{,30}revised: \).*#\1' .
            \ strftime('%a %B %d, %Y @ %I:%M:%S %Z */') . '#e'
    else
        keepjumps exe '1,' . n . 's#^\(.\{,30}revised: \).*#\1' . 
            \ strftime('%a %B %d, %Y @ %I:%M:%S %Z') . '#e'
    endif
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastRevised()

" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastBuilt()
  if &modified
    let save_cursor = getpos(".")
    let n = min([40, line("$")])
    if (&filetype=='html' || &filetype=='htmldjango')
        keepjumps exe '1,' . n . 's#^\(.\{,30}built: \).*#\1' .
            \ strftime('%a %B %d, %Y @ %I:%M:%S %Z -->') . '#e'
    elseif (&filetype=='css')
        keepjumps exe '1,' . n . 's#^\(.\{,30}built: \).*#\1' .
            \ strftime('%a %B %d, %Y @ %I:%M:%S %Z */') . '#e'
    else
        keepjumps exe '1,' . n . 's#^\(.\{,30}built: \).*#\1' .
            \ strftime('%a %B %d, %Y @ %I:%M:%S %Z') . '#e'
    endif
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastBuilt()

function! SynStack ()
    for i1 in synstack(line("."), col("."))
        let i2 = synIDtrans(i1)
        let n1 = synIDattr(i1, "name")
        let n2 = synIDattr(i2, "name")
        echo n1 "->" n2
    endfor
endfunction

let g:pipemysql_login_info = [
                             \ {
                             \ 'description' : 'Centos8 Server',
                             \ 'ssh_address' : 'kbelv@centos8', 
                             \ 'ssh_port' : '20',
                             \ 'mysql_hostname' : 'centos8-server', 
                             \ 'mysql_username' : 'kbelv' 
                             \ }
                             \ ]
map <F12> gg<C-o>
let asmsyntax='armasm'
let filetype_inc='armasm'
autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' |  clip.exe')

" By default, it will be triggered by `ENTER` in insert mode.
" set this to 1 to use `CTRL+ENTER` instead, and keep the
" default `ENTER` behavior unchanged.
let g:rtf_ctrl_enter = 0

" Enable formatting when leaving insert mode
let g:rtf_on_insert_leave = 1

" transparent bg
 autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" " For Vim<8, replace EndOfBuffer by NonText
 autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE

nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
