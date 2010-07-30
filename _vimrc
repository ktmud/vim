"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Owner: Ktmud <i@yjc.me>
" Last Change: 2010-07-30 21:22:05
"
" set runtimepath=~/vim,$VIMRUNTIME
" source ~/vim/vimrc

" Get out of VI's compatible mode..
set nocompatible

" Basic {{{
if has("win32")
    let $VIMFILES = $VIM.'/vimfiles'
    let $V = $VIM.'/_vimrc'
else
    let $VIMFILES = $HOME.'/.vim'
    let $V = $HOME.'/.vimrc'
endif

" }}}

" => VIM UserInterface Settings {{{

" Enable filetype plugin
filetype indent on
filetype plugin on
" Set mapleader
let mapleader = ","
let g:mapleader = ","
" How many rows would be kept when moving cursor down?
set so=5
" Turn on Wild menu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.bak,*.o,*.e,*~,*.p:yc,*.svn
" Always show current position
set ruler
" The commandbar is 2 high
set cmdheight=2
" Show line number
set number
" Do not redraw, when running macros.. lazyredraw
set lazyredraw
" Change buffer - without saving
set hidden
" Set backspace
set backspace=eol,start,indent
" Break long line or not
"set nowrap
" Backspace and cursor keys wrap to
set whichwrap+=<,>,h,l
set listchars+=precedes:<,extends:>
" Ignore case when searching
set ignorecase smartcase
set incsearch
" Set magic on
set magic
" No sound on errors.
set noerrorbells
set novisualbell
set t_vb=
" Make GUI File Open use current directory
set browsedir=buffer
" Show matching bracets
set showmatch
set showfulltag
" How many tenths of a second to bli<C-o><C-o>nk
set mat=2
" Highlight search things
set hlsearch
nmap <silent> <F2> <esc>:call ToggleHighLightSearch()<cr>
func! ToggleHighLightSearch()
    if &hls
        set nohls
    else
        set hls
    endif
endfunction

" Have the mouse enabled all the time:
set mouse=a
" show incomplete commands
set showcmd
" Sets how many lines of history VIM har to remember
set history=800
" Always switch to the current file directory
set autochdir
"Set the terminal title
set title
" Don't break the words with following character
set iskeyword+=_,$,@,%,#,- et title

"set foldopen
set foldmethod=marker   "fold based on marker
set foldnestmax=10     "deepest fold is 10 levels
nmap <leader>fn :set fdm=manual<cr>
nmap <leader>fi :set fdm=indent<cr>
nmap <leader>fm :set fdm=marker<cr>
nmap <leader>fs :set fdm=syntax<cr>
" Audosave and autoload views, include foldings
autocmd BufUnload *.* mkview
autocmd BufRead *.* silent loadview

" Text options
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab
set lbr
set textwidth=450
set isfname-=\= " fix filename completion in VAR=/path

" Don't display start text :help iccf
set shortmess=atI

" }}}

" => Shortcuts Mapping {{{

set timeout timeoutlen=600 ttimeoutlen=50

" Adapt vim to common habits {{{

" Select All
nnoremap <leader>a ggVG
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG
vnoremap <Esc> <Esc><C-o><>

" Clipboard
vmap <leader>.c "+y
vmap <leader>.x "+x
vmap <C-c> "+y
vmap <C-x> "+x
map <leader>.v "+gp
inoremap <leader>.v <C-O>"+gp
inoremap <C-v> <C-O>"+gp

" Set clipboard+=unnamed

" Undo
inoremap <C-z> <C-o>u
" Redo
inoremap <C-y> <C-o><C-r>
nnoremap t <C-r>


"}}}

" BufExplorer
map <leader>b :BufExplorer<cr>
" Switch to current dir, see also :set autochdir
map <leader>cd :cd %:p:h<cr>
" Temp text buffer
map <leader>e :e ~/.buffer<cr>
" Remove the Windows ^M
map <leader>M :%s/\r//g<cr>
" Fast Quit
map <leader>q :q<cr>
" Fast reloading of the .vimrc
map <leader>s :source $V<cr>
nnoremap <leader>.v :tabedit $V
" Undolist
map <leader>u :undolist<cr>
" Fast saving
map <leader>w :w!<cr>
map <silent> <C-S> :if expand("%") == ""<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
imap <silent> <C-S> <C-o>:if expand("%") == ""<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
map <silent> <S-s> :browse confirm saveas<CR>

" Mapping Q to exit instead of Ex mode
map Q :x<cr>
nmap :X :x
nmap :W :w
nmap :Q :q
" Bash like
imap <C-A> <Home>
"imap <C-E> <End>
imap <C-K> <Esc>d$i
imap <C-B> <Left>
imap <C-F> <Right>

" Command-line
cnoremap <C-A> <Home>
"cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

" Key mappings to ease browsing long lines
noremap <C-J> gj
noremap <C-K> gk

" Usefull when insert a new indent line
imap `j <cr><C-O>O
" Remove tag content see :help object-select
imap `i <C-O>cit


" Move lines (Eclipse like)
nmap <C-Down> :<C-u>move .+1<cr>
nmap <C-Up> :<C-u>move .-2<cr>
imap <C-Down> <C-o>:<C-u>move .+1<cr>
imap <C-Up> <C-o>:<C-u>move .-2<cr>
vmap <C-Down> :move '>+1<cr>gv
vmap <C-Up> :move '<-2<cr>gv

" Use shell with ctrl-z
"map <C-Z> :shell<cr>

" Remove indentation on empty lines
map <leader>ri :%s/\s*$//g<cr>:noh<cr>
" Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>
" SVN Diff
map <F8> :new<cr>:read !svn diff<cr>:set syntax=diff buftype=nofile<cr>gg

" Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>th :set syntax=html<cr>
map <leader>tc :set ft=css<cr>
map <leader>tj :set ft=javascript<cr>
map <leader>ty :set syntax=python<cr>
map <leader>tp :set ft=php<cr>
map <leader>$ :syntax sync fromstart<cr>

" Quit readonly files (like help.cnx) quickly
au BufRead */doc/* nnoremap <buffer> <silent> q :close<cr>
au BufRead */doc/* set buftype=help

"}}}

" => tabs, windows, indentation {{{

" Win Alt Key
set winaltkeys=menu

" more handful operation of buffers
nmap <S-Left> :bp<cr>
nmap <S-Right> :bn<cr>
nmap <S-Delete> :bd<cr>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Tab key to indent
imap <Tab> <C-o>v>
imap <S-Tab> <C-o>v<
vmap <Tab> >gv
vmap <S-Tab> <gv

" Jump between windows
nmap <M-z> <C-w>W
nmap <M-x> <C-w>w
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <c-k> <C-w>k
nmap <C-l> <C-w>l

" Tab page configuration
set guitablabel=%M%N.%t
map <leader>.n :tabnext<cr>
map <leader>.e :tabedit 

map <leader>.q :tabnew<cr>
map <silent> <leader>.w :call TabCloseCheck()<cr>
nmap <C-Tab> gt
imap <C-Tab> <C-O>gt


function! TabCloseCheck()
    if tabpagenr('$') == 1
        let choice = confirm("Close the last tab?", "&Yes\n&No", 1, "Warning")
        if choice == 1
            exe 'conirm q'
        else
            return
        endif
    else
        exe 'confirm q'
    endif
endfunction

try
    set switchbuf=usetab
    set showtabline=2  "Always show the tabline.
catch
endtry

" Indentation
set autoindent
set smartindent
map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>

" Format all and then pos the cursor back
nmap <leader>= :let cursorPos=getpos(".")<cr>gg=G:call setpos('.', cursorPos)<cr>:unlet cursorPos<cr>

" Favorite filetypes
"set fileformats=unix,dos,mac
"}}}

" => Statusline {{{

" Always show the statusline
set laststatus=2

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~/", "g")
    return curdir
endfunction

"Format the statusline
set statusline=%#Pmenu#%M%*\%F\ %r%h%w[%Y,%{&ff},%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ @%v\ %l/%L\ %#Pmenu#%p%%%*\ %r%{CurDir()} 

" Function to insert the current date
function! InsertCurrentDate()
    let curr_date=strftime('%Y-%m-%d %X', localtime())
    silent! exec 'normal! gi' .  curr_date . "\<ESC>"
endfunction

" Key mapping to insert the current date
inoremap <silent> <C-D> <C-O>:call InsertCurrentDate()<CR>

"}}}

" => Visual {{{
vnoremap <BS> <Delete>i

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    else
        execute "normal /" . l:pattern . "^M"
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<cr>
vnoremap <silent> # :call VisualSearch('b')<cr>

"}}}

" => Parenthesis/bracket expanding {{{

" Map auto complete of (, ", ', [,{
"inoremap ( ()<ESC>i
inoremap <silent> ( <c-r>=OpenPair('(')<CR>
inoremap <silent> ) <c-r>=ClosePair(')')<CR>
"inoremap { {}<ESC>i
inoremap <silent> { <c-r>=OpenPair('{')<CR>
inoremap <silent> } <c-r>=ClosePair('}')<CR>
"inoremap [ []<ESC>i
inoremap <silent> [ <c-r>=OpenPair('[')<CR>
inoremap <silent> ] <c-r>=ClosePair(']')<CR>
"inoremap < <><ESC>i
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                \ '{' : '}',
                \ '[' : ']',
                \ '(' : ')',
                \ '<' : '>'
                \}
    let ol = len(split(getline('.'), a:char, 1))-1
    let cl = len(split(getline('.'), PAIRs[a:char], 1))-1
    "if ol==cl
        return a:char . PAIRs[a:char] . "\<Left>"
    "else
        return a:char
    "endif
endfunction
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
autocmd FileType vim inoremap <buffer> " "
function! CompleteQuote(quote)
    let ql = len(split(getline('.'), a:quote, 1))-1
    " a:quote length is odd.
    if (ql%2)==1
        return a:quote
    elseif getline('.')[col('.') - 1] == a:quote
        return "\<Right>"
    else
        return a:quote . a:quote . "\<Left>"
    endif
endfunction

vnoremap #( <esc>`>a)<esc>`<i(<esc>
vnoremap #[ <esc>`>a]<esc>`<i[<esc>
vnoremap #{ <esc>`>a}<esc>`<i{<esc>
vnoremap #< <esc>`>a><esc>`<i<<esc>
vnoremap #' <esc>`>a'<esc>`<i'<esc>
vnoremap #" <esc>`>a"<esc>`<i"<esc>


" Auto close html tags
iabbrev </ </<C-X><C-O>


"}}}

" => Plugin Settings {{{

" zencoding.vim
let g:user_zen_expandabbr_key = '<M-e>'
let g:user_zen_leader_key = ';'

" html.vim
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

nmap <leader>.y :YankRing<cr>

" taglist.vim
"set tags=./tags "now using autotags.vim to set tags
map <F10> :TlistToggle<cr>
let Tlist_Auto_Open=0 " let the tag list open automagically
let Tlist_Compact_Format = 1 " show small menu
let Tlist_Ctags_Cmd = 'd:\dev\vim\ctags.exe' "location of ctags
let Tlist_Enable_Fold_Column = 0 " do show folding tree
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_WinWidth = 35 " 35 cols wide, so i can (almost always) read my functions
let Tlist_Exit_OnlyWindow = 1
let Tlist_Show_Menu = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_OnSelect = 1
let Tlist_Inc_Winwidth = 0
let g:tlist_javascript_settings = 'javascript;f:function;c:class;o:object;m:method;s:string;a:array;n:constant'
let tlist_php_settings = 'php;c:class;d:constant;f:function'

" NERD_tree.vim
map <F9> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.pyc$','\.svn$','\.tmp$','\.bak','\~$','\.swp$']

" matrix.vim
map <leader>.m :Matrix<cr>

" html.vim
let g:no_html_toolbar = 1
let g:do_xhtml_mappings = 'yes'
let g:html_tag_case = 'lowercase'

" closetag.vim
let g:closetag_html_style=1

" ToHTML
let use_xhtml = 1
let html_use_css = 1
let html_number_lines = 0

" mru.vim (History file List, Most Recent Used)
map <leader>.r :MRU<cr>
let MRU_Max_Entries = 50
"let MRU_Exclude_Files='^/tmp/.*\|^/var/tmp/.*'
let MRU_Include_Files='\.css$\|\.html$\|\.htm$\|\.js$\|\.vim$\|\.info$\|\.txt$\|vimrc$\|\.snippets'

let MRU_Window_Height=15
let MRU_Filter_Not_Exists=1
let MRU_Add_Menu=1
let MRU_File=$VIM . '\_vim_mru_files'

" fencview.vim
let g:fencview_autodetect = 0

" acp.vim & SnipMate.vim
let g:acp_behaviorSnipmateLength = 1
let g:acp_enableAtStartup = 1
let g:acp_completeOption = '.,w,b,u,t,i,k'
let g:acp_ignorecaseOption = 0
let g:snips_author = 'Ktmud <http://ktmud.com/>'
"autocmd FileType python set ft=python.django " For SnipMate
"autocmd FileType html set ft=html.django_template.jquery " For SnipMate & jquery

" fuf.vim  fuzzyfinder
nmap <leader>fb :FufDirWithCurrentBufferDir<cr>
nmap <leader>fd :FufDir<cr>
nmap <leader>ff :FufFile<cr>
nmap <leader>ft :FufTag<cr>
nmap <leader>fh :FufHelp<cr>

" VIM
autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>:w!<cr>
"autocmd bufwritepost _vimrc source %

" vimim.vim 中文输入法
let g:vimim_cloud_sogou=1
let g:vimim_static_input_style=0

" => Set OmniComplete
set completeopt=longest,menu
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript set dictionary+=$VIMFILES\dict\javascript.dict
autocmd FileType html,htm set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php setlocal dict+=$VIMFILES\dict\php_functions.txt
autocmd FileType c set omnifunc=ccomplete#Complete
imap <S-Space> <C-X><C-O>

" }}}

" => Colors & Fonts & Syntax {{{
" Enable syntax
syntax enable

if has("gui_running")
    colorscheme rdark
    " Highlight cursor position
    "set cursorline
    "set cursorcolumn
    " Toggle Menu and Toolbar and switch fullscreen mode
    "set guioptions-=B " Hide bottom scrollbar
    "set guioptions-=R " Hide right scrollbar
    "set guioptions-=r
    "set guioptions-=l " Hide left scrollbar
    set guioptions-=L
    set guioptions-=m " Hide Menu
    set guioptions-=T " Hide Toolbar
    map <silent> <F11> :if &guioptions =~# 'm' <Bar> set guioptions-=m <bar> else <Bar> set guioptions+=m <Bar> endif<cr>
    "map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    " Auto Maximize when vim starts.
    if has("win32")
        exec 'set guifont='.iconv('Courier_New', &enc, 'gbk').':h12:cANSI'
        exec 'set guifontwide='.iconv('Yahei\ Mono', &enc, 'gbk').':h12'
        au GUIEnter * simalt ~x
    elseif has("unix")
        au GUIEnter * winpos 0 0
        "set lines=999 columns=9999
    end
else
    set background=dark
    "colorscheme zellner
    colorscheme torte
endif

" Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

" Syntax JavaScript
autocmd FileType javascript set syntax=jquery
let b:javascript_fold=1
let javascript_enable_domhtmlcss=1

"}}}

" => File Operation and encodings{{{

" Turn backup off
set nobackup
set nowb
set noswapfile

" Open Windows Explorer and Fouse current file.
if has("win32") || has("win64")
    nmap <F6> :!start explorer /e,/select, %:p<CR>
    imap <F6> <C-o><F6>
    "view file in Chrome browser
    map <silent> <F12> :call Chromeit()<cr>
    au FileType javascript map <f12> :call g:Jsbeautify()<cr>
endif

function! Chromeit()
    exec '!start "'.$HOME.'\AppData\Local\Google\Chrome\Application\chrome.exe" --enable-extension-timeline-api %:p"'
endfunction

function! SetFileEncodings(encodings)
    let b:my_fileencodings_bak=&fileencodings
    let &fileencodings=a:encodings
endfunction

function! RestoreFileEncodings()
    let &fileencodings=b:my_fileencodings_bak
    unlet b:my_fileencodings_bak
endfunction

if has("multi_byte")
    set encoding=utf-8
    set fileencoding=chinese
    set fileencodings=ucs-bom,gb18030,gbk,utf-8,big5,euc-jp,euc-kr,latin1
    set formatoptions+=mM
    set nobomb " Don' use Unicode

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("gui_running")
        set langmenu=zh_CN
        "let $LANG='chinese'
        "language messages en_US.utf-8
        language messages zh_CN.utf-8
        "let &termencoding=&encoding
        source $VIMRUNTIME\delmenu.vim
        source $VIMRUNTIME\menu.vim
        if version >= 603
            set helplang=cn
        endif
    else
        "set fileencoding=utf-8
        set enc=chinese
        lang mes zh_CN.gbk
    endif

    " Convert fileencoding to gbk
    nmap <leader>gbk :set fenc=gbk<cr>,w
else
    echoerr "Sorry, this version of gvim was not compiled with +multi_byte"
endif

" }}}

" => Misc  {{{

function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=2
    setlocal tabstop=8
endfunction

function! UpdateLastChangeTime()
    let last_change_anchor='\(" Last Change:\s\+\)\d\{4}-\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}'
    let last_change_line=search('\%^\_.\{-}\(^\zs' . last_change_anchor . '\)', 'n')
    if last_change_line != 0
        let last_change_time=strftime('%Y-%m-%d %H:%M:%S', localtime())
        let last_change_text=substitute(getline(last_change_line), '^' . last_change_anchor, '\1', '') . last_change_time
        call setline(last_change_line, last_change_text)
    endif
endfunction

function! RemoveTrailingSpace()
    if $VIM_HATE_SPACE_ERRORS != '0' &&
                \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim')
        normal! m`
        silent! :%s/\s\+$//e
        normal! ``
    endif
endfunction

" Let TOhtml output <PRE> and style sheet
let html_use_css=1

" Automatically find scripts in the autoload directory
au FuncUndefined Syn* exec 'runtime autoload/' . expand('<afile>') . '.vim'

" Automatically update change time
"au BufWritePre *vimrc,*.vim   call UpdateLastChangeTime()
"}}}
"
" For projects... {{{
nmap <leader>.cdos :cd d:\projects\opensearch\demo\<cr>

"}}}

"测试中文
"alala
