"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Owner: Ktmud <i@yjc.me>
" Last Change: 2010-10-09 19:37:05
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

" basic end }}}

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
" line height, the space between each line, in pixel
set lsp=2
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

" 重启后撤销历史可用 persistent undo 
set undofile
set undodir=$VIMFILES/\_undodir
set undolevels=1000 "maximum number of changes that can be undone

" Always switch to the current file directory
set autochdir
"Set the terminal title
set title
" Don't break the words with following character
set iskeyword+=_,$,@,%,#,- et title

"set foldopen
set foldmethod=marker  "fold based on marker
set foldmarker={{{,}}}
nmap <leader>.m1 :setlocal fmr={{{,}}}<cr>
nmap <leader>.m2 :setlocal fmr=>>>,<<<<cr>
set foldnestmax=10     "deepest fold is 10 levels
nmap <leader>fn :set fdm=manual<cr>
nmap <leader>fi :set fdm=indent<cr>
nmap <leader>fm :set fdm=marker<cr>
nmap <leader>fs :set fdm=syntax<cr>
" Audosave and autoload views, include foldings
autocmd BufWinLeave {*.wiki,*.css,*.html,*.htm,*.php,*.js,*.json,*.vim,*.info,*.txt,*vimrc,*.snippets} mkview 
autocmd BufRead     {*.wiki,*.css,*.html,*.htm,*.php,*.js,*.json,*.vim,*.info,*.txt,*vimrc,*.snippets} silent loadview

" Quit readonly files (like help.cnx) quickly
au BufRead *       exe 'if &buftype != "" | nmap <buffer> q :close<cr> | endif'
au BufRead */doc/* set buftype=help

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

set shellslash

" interface end }}}

" => Shortcuts Mapping {{{

set timeout timeoutlen=600 ttimeoutlen=50
" Adapt vim to common habits {{{

" Select All
nnoremap <leader>a :call RememberCursor()<cr>ggVG
nnoremap <C-a> :call RememberCursor()<cr>ggVG
inoremap <C-a> <Esc>:call RememberCursor()<cr>ggVG
vnoremap <Esc> <Esc><cr>

function! RememberCursor()
    let cursorPos=getpos(".")
endfunction

function! ResetCursor()
    setpos('.', cursorPos)
endfunction


" Clipboard
vmap <leader>.c "+y
vmap <leader>.x "+x
vmap <C-c> "+y
vmap <C-x> "+x
"map <leader>.v "+gp
"inoremap <leader>.v <C-O>"+gP
nnoremap <C-v> "+p
"使用lmap就可以在命令行模式也粘贴
inoremap <C-v> <C-r>+
vnoremap <C-v> <Delete>i<C-r>+
" 我靠，原来用<C-R>就能解决问题！

" Set clipboard+=unnamed

" Undo
inoremap <C-z> <C-o>u
" Redo
inoremap <C-y> <C-o><C-r>
nnoremap t <C-r>

"end }}}

" BufExplorer
map <leader>b :BufExplorer<cr>
" Switch to current dir, see also :set autochdir
map <leader>cd :cd %:p:h<cr>
" Temp text buffer
"map <leader>e :e ~/.buffer<cr>
" Remove the Windows ^M
map <leader>M :%s/\r//g<cr>
" Fast Quit
map <leader>q :q<cr>
" Fast reloading of the .vimrc
map <leader>s :source $V<cr>
nnoremap <leader>.v :tabedit $V<cr>
" Undolist
map <leader>u :undolist<cr>
" Fast saving
map <leader>w :w!<cr>
nmap <silent> <C-S> :if expand("%") == ""<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
imap <silent> <C-S> <Esc><C-s>a
map <silent> <S-s> :browse confirm saveas<CR>

" Mapping Q to exit instead of Ex mode
map Q :x<cr>
nmap :X :x
nmap :W :w
nmap :Q :q

" Command-line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>

" Key mappings to ease browsing long lines
noremap <C-J> gj
noremap <C-K> gk

" Usefull when insert a new indent line
imap <C-J> <cr><C-O>O
" Remove tag content | see :help object-select
nmap `i cit
imap <C-i> <C-O>cit

" Move lines (Eclipse like)
nmap <C-Down> :<C-u>move .+1<cr>
nmap <C-Up> :<C-u>move .-2<cr>
imap <C-Down> <C-o>:<C-u>move .+1<cr>
imap <C-Up> <C-o>:<C-u>move .-2<cr>
vmap <C-Down> :move '>+1<cr>gv
vmap <C-Up> :move '<-2<cr>gv

" Use shell with ctrl-z
map <C-Z> :shell<cr>

" Remove indentation on empty lines 以及行尾空白
map <leader>ri :%s/\s*$//g<cr>:noh<cr>
" Paste toggle - when pasting something in, don't indent.
nnoremap <F5> :set invpaste paste?<CR>
set pastetoggle=<F5>
set showmode
" SVN Diff
map <F8> :new<cr>:read !svn diff<cr>:set syntax=diff buftype=nofile<cr>gg

" Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>th :set ft=html<cr>
map <leader>tc :set ft=css<cr>
map <leader>tj :set ft=javascript<cr>
map <leader>ty :set ft=python<cr>
map <leader>tp :set ft=php<cr>
map <leader>$ :syntax sync fromstart<cr>

" Format all then pos the cursor back
nmap <silent> <leader>= :let cursorPos=getpos(".")<cr>gg=G:call setpos('.', cursorPos)<cr>:unlet cursorPos<cr>
" Format a compressed css file
map <leader>css :%s/;\s*\([a-z*_-}]\)/;\r\1/g<cr>:%s/\(\w\)\s*{\([^\r]\)/\1\ {\r\2/g<cr>:%s/:\(\w\)/:\ \1/g<cr>:%s/}\(\w\\|#\\|\.\)/}\r\1/g<cr>,=

function! FormartCSS()
  let cursorPos = getPos(".")
endfunction



" === operator-pending mode ==

" mapping end }}}

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
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <Tab> <C-o>v>
inoremap <S-Tab> <C-o>v<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

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
nmap <S-C-Tab> gT
imap <C-Tab> <C-O>gt


function! TabCloseCheck()
  if tabpagenr('$') == 1
    let choice = confirm("Close the last tab?", "&Yes\n&No", 1, "Warning")
    if choice == 1
      exe 'confirm q'
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

" Favorite filetypes
"set fileformats=unix,dos,mac
" tabs end }}}

" => Statusline {{{

" Always show the statusline
set laststatus=2

function! CurDir()
  let curdir = substitute(getcwd(), $HOME, "~/", "g")
  return curdir
endfunction

"Format the statusline
set statusline=%#Pmenu#%M%*\%F\ %r%h%w[%Y,%{&ff},%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ @%v\ %l/%L\ %#Pmenu#%p%%%*\ %r%{CurDir()} 

" statusline end }}}

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

" Replace
nmap <leader>s :%s//
"imap <leader>s :%s//
vmap <leader>s #

" visual end }}}

" => Parenthesis/bracket expanding {{{

" Map auto complete of (, ", ', [,{
"inoremap ( ()<ESC>i
"inoremap <silent> ( <c-r>=OpenPair('(')<CR>
"inoremap <silent> ) <c-r>=ClosePair(')')<CR>
"inoremap { {}<ESC>i
"inoremap <silent> { <c-r>=OpenPair('{')<CR>
"inoremap <silent> } <c-r>=ClosePair('}')<CR>
"inoremap [ []<ESC>i
"inoremap <silent> [ <c-r>=OpenPair('[')<CR>
"inoremap <silent> ] <c-r>=ClosePair(']')<CR>
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

"inoremap ' <c-r>=CompleteQuote("'")<CR>
"inoremap 
" <c-r>=CompleteQuote('"')<CR>
"autocmd FileType vim inoremap <buffer> " "
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


"bracets end }}}

" => Plugin Settings {{{

" zencoding.vim
let g:user_zen_expandabbr_key = '<M-e>'
let g:user_zen_leader_key = ';'

" indent/html.vim
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

nmap <leader>.y :YankRing<cr>

" taglist.vim
"set tags=./tags "now using autotags.vim to set tags
map <F10> :TlistToggle<cr>
"let Tlist_Auto_Open=1 "let the tag list open automagically
"let Tlist_Close_OnSelect = 1
let Tlist_Compact_Format = 1 " show small menu
"ctags执行文件所在位置把VIM目录加入PATH系统变量就不用这句了
"let Tlist_Ctags_Cmd = 'd:\dev\vim\ctags.exe' 
"let Tlist_Enable_Fold_Column = 1 " do not show folding tree
let Tlist_Exit_OnlyWindow = 1 " exit vim when only the taglist window is present.
let Tlist_File_Fold_Auto_Close = 1 " fold taglists of unopened files.
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Inc_Winwidth = 0
"let Tlist_Show_Menu = 1 "turn on the gui menu
let Tlist_Sort_Type = "name" " 指定为默认按字母顺序排序，可以在taglist窗口按 s 切换
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_WinWidth = 35 " 
let g:tlist_javascript_settings = 'javascript;f:function;c:class;o:object;m:method;s:string;a:array;n:constant'
let tlist_php_settings = 'php;c:class;d:constant;f:function'
let g:tlist_ant_settings = 'ant;p:Project;t:Target;r:Property'

" ant_menu.vim
let g:buildFile = 'build.xml'
let g:antOption = '-debug'
let g:logFile = 'build.log' 
"set shellpipe="2>"


" NERD_tree.vim
map <F9> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.pyc$', '\.svn$', '\.tmp$', '\.bak', '\~$', '\.swp$', 'Thumbs\.db']
let NERDTreeQuitOnOpen=1

" html.vim
"let g:no_html_toolbar = 1
"let g:do_xhtml_mappings = 'yes'
"let g:html_tag_case = 'lowercase'

" closetag.vim
"let g:closetag_html_style=1

" ToHTML
let use_xhtml = 1
let html_use_css = 1
let html_number_lines = 0

" mru.vim (History file List, Most Recent Used)
map <leader>.r :MRU<cr>
let MRU_Max_Entries=80
"let MRU_Exclude_Files='^/tmp/.*\|^/var/tmp/.*'
let MRU_Include_Files='\.wiki\|\.css$\|\.html$\|\.htm$\|\.php$\|\.js$\|\.json$\|\.vim$\|\.info$\|\.txt$\|vimrc$\|\.snippets'

let MRU_Window_Height=20
let MRU_Filter_Not_Exists=1
let MRU_Add_Menu=1
let MRU_File=$VIM . '/.vim_mru_files'

" fencview.vim
let g:fencview_autodetect = 1

" acp.vim & SnipMate.vim
"let g:acp_behaviorSnipmateLength = 1
let g:acp_behaviorHtmlOmniLength = 1
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
let g:vimim_cloud_sogou=3

" => Set OmniComplete
set completeopt=longest,menu
set ofu=syntaxcomplete#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal dictionary+=$VIMFILES\dict\javascript.dict
autocmd FileType html,htm setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType php setlocal dict+=$VIMFILES\dict\php_functions.txt
autocmd FileType c setlocal omnifunc=ccomplete#Complete
imap <S-Space> <C-X><C-O>

" vimwiki
"     \ 'auto_export': 1,
let g:vimwiki_list = [{'path': 'E:/My Dropbox/vimwiki/', 
      \ 'html_header': 'E:/My Dropbox/vimwiki_template/header.htm',
      \ 'html_footer': 'E:/My Dropbox/vimwiki_template/footer.htm',
      \ 'diary_link_count': 5},
      \{'path': 'Z:\demo\qiuchi\wiki'}]
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_menu = ''
"let g:vimwiki_folding = 1
let g:vimwiki_CJK_length = 1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1'

map <F4> :Vimwiki2HTML<cr>
map <S-F4> :VimwikiAll2HTML<cr>
map <leader>wg :exec 'silent !cmd.exe /k "cd "'.VimwikiGet('path').'" & sync"'<cr>
map <leader>wh :exec 'silent !cmd.exe /k "cd "'.VimwikiGet('path_html').'" & sync"'<cr>
map <C-F4> <S-F4>,w.

" calendar
map <F8> :Calendar<cr>

" plugin end }}}

" => Colors & Fonts & Syntax {{{
" Enable syntax
syntax enable

if has("gui_running")
  colorscheme molokai
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
    exec 'set guifont='.iconv('Courier\ New', &enc, 'gbk').':h12:cANSI'
    exec 'set guifontwide='.iconv('Yahei\ Mono', &enc, 'gbk').':h12'
    au GUIEnter * simalt ~x
  elseif has("unix")
    au GUIEnter * winpos 0 0
    "set lines=999 columns=9999
  end
else
  "colorscheme zellner
  colorscheme astronaut
endif

" Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

" Syntax JavaScript
"let b:javascript_fold=1  "一旦使用语法折叠，会引起高亮显示错误... 可能语法配置有问题。暂时不能解决。 还是用人工折叠吧！
let javascript_enable_domhtmlcss=1

" JSLint
"let jslint_command = $VIM . '\vimfiles\etc\jsl-0.3.0\jsl.exe'
"map <leader>jsl :call JavascriptLint()<cr>
"map <leader>gjsl :call GJSLint()<cr>
"map <C-n>  :cn<cr>
"map <S-C-n>  :cp<cr>

"set makeprg=cat\ %\ \\\|\ /my/path/to/js\ /my/path/to/mylintrun.js\ %
"set errorformat=%f:%l:%c:%m


au BufRead,BufNewFile *.json  set filetype=javascript
"end }}}

" => File Operation and encodings{{{

" Turn backup off
set nobackup
set nowb
set noswapfile


" Open Windows Explorer and Fouse current file.
if has("win32") || has("win64")
  "需要把斜杠（/）替换成反斜杠（\）
  nmap <F6> :!start explorer /e,/select, "%:p:gs?/?\\?"<CR>
  imap <F6> <C-o><F6>
  "view file in Chrome browser
  map <silent> <F12> :call Chromeit()<cr>
  au FileType javascript map <buffer> <f12> :call g:Jsbeautify()<cr>
endif

function! Chromeit()
  exec '!start "'.$HOME.'\AppData\Local\Google\Chrome\Application\chrome.exe" --enable-extension-timeline-api "%:p"'
endfunction

function! SetFileEncodings(encodings)
  let b:my_fileencodings_bak=&fileencodings
  let &fileencodings=a:encodings
endfunction

function! RestoreFileEncodings()
  let &fileencodings=b:my_fileencodings_bak
  unlet b:my_fileencodings_bak
endfunction

set fileencoding=gbk
"set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,gbk,big5,euc-jp,euc-kr,latin1
set formatoptions+=mM
set nobomb " Don' use Unicode

if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
  set ambiwidth=double
endif


if has("gui_running")
  set encoding=utf-8
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
  lang mes zh_CN
  set encoding=chinese
endif

" Convert fileencoding
nmap <leader>eg :set fenc=gbk<cr>,w
nmap <leader>ee :set fenc=utf-8<cr>,w

function QfMakeConv()
   let qflist = getqflist()
   for i in qflist
      let i.text = iconv(i.text, "cp936", "utf-8")
   endfor
   call setqflist(qflist)
endfunction

au QuickfixCmdPost make call QfMakeConv()

" end }}}

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

" Function to insert the current date
function! InsertCurrentDate()
  let curr_date=strftime('%Y-%m-%d %X', localtime())
  silent! exec 'normal! gi' .  curr_date . "\<ESC>"
endfunction

" Key mapping to insert the current date
inoremap <silent> <C-D> <C-O>:call InsertCurrentDate()<CR>

"end }}}

" For projects... {{{
nmap <leader>.cdos :cd d:\projects\opensearch\<cr>

"end }}}

"测试中文
