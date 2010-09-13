" ant_menu.vim : VIM menu for ant
" Another Neat Tool (http://ant.apache.org)
" Author : Shad Gregory <captshadg@gmail.com>
" http://shadgregory.net
" License : GNU Lesser General Public License
" $Date: 06/03/2009 $
" $Revision: 0.5.7.1$
"
"Configuration comments:
"  You can set ant_menu.vim options.  Let's say that you always use the
"  '-debug' option and for some reason you've called your build 
"  file 'JimBob.'  Then you should put the following lines in
"  your .vimrc or _vimrc.
"
"  let g:userBuildFile = 'JimBob'
"  let g:antOption = '-debug'
"
"  ant_menu.vim dynamically loads your build.xml on start up and when you 
"  switch buffers.  This behaviour will be disabled if you manually set the 
"  build file via your start-up file or the ant menu.
"
"Keyboard Commands:
"  ,s -> This will prompt you for the location and name of the build
"    file.  Not necessary if the build file is in the current
"    directory and named 'build.xml'
"
"  ,b -> Executes 'ant -buildfile <build file>'  This will include any
"    option you have set via the menu.
"
"  ,f -> Executes 'ant -find' along with any option you have set via
"    the menu.
"
"  ,l -> Sets log file.  All ant output will be directed to the
"    file you set with this option.
"
"  ,g -> If you are in the error buffer, and you press ',g' at a the
"    line that identifies which file the error came from,
"    then vim will open that file in a new buffer.  The cursor
"    should be at the line containing the first error.
"
"  ,t -> Prompts you for the name of the build target and executes
"    the specified target after enter is pressed.  (Thanks to
"    Anton Straka for this bit of code.)
"    
"  ,z -> Prompts you for a build target that will be executed with 
"    'ant -find'.
"
"  Thanks:
"    Anton Straka, Ronny Wilms, Nathan Smith, Keith Corwin, Mark
"    Healy, David Fishburn, Jou Wei Huang, Michael Scheper, Phil
"    McCarthy, Derek Pomery, David, Amit Jain
"    Special thanks to David Fishburn for the quick fix code.


"convenience function for GetProbFile()
function! JumpToLineNoCol(windowNumber, lineNumber, badFile)
  if ( a:windowNumber == -1 )
    silent! exec 'split +' . a:lineNumber . ' ' .a:badFile
  else
    silent! exec "wincmd t"
    if ( a:windowNumber > 1 )
      silent! exec a:windowNumber-1 . "wincmd j"
    endif
    silent! exec "normal!" . a:lineNumber . "G"
  endif
endfunction

"convenience function for GetProbFile()
function! JumpToLineWithCol(windowNumber, lineNumber, badFile)
    if ( a:windowNumber == -1 )
      silent! exec 'split +' . a:lineNumber . "normal!" . a:columnNumber . '| ' .a:badFile
    else
      silent! exec "wincmd t"
      if ( a:windowNumber > 1 )
        silent! exec a:windowNumber-1 . "wincmd j"
      endif
      silent! exec a:lineNumber . "normal!" . a:columnNumber . '|'
    endif
endfunction

function! GetProbFile()
  let l:badFile = getline(".")
  "Is this jikes 1.17?
  if getline(".") =~ 'Found \d.*syntax'
    echo "jikes117!"
    let l:badFile = substitute(l:badFile,'^||\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'\[javac\]\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'Found.*"\(.*\.java\)":','\1','')
    let l:badFile = substitute(l:badFile,'^\s*\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'^\s*\(.*\)\s*\s$','\1','')
    let l:current = line('.') + 2
    let l:lineNumber = getline(l:current)
    let l:lineNumber = substitute(l:lineNumber,'^.*\s\(\d*\)\..*','\1','')
    let l:windowNumber = bufwinnr( l:badFile )
    call JumpToLineNoCol(l:windowNumber, l:lineNumber, l:badFile)
    return
  "is this jikes 1.15?
  elseif getline(".") =~ '\.java:\d*:\d'
    echo "jikes115!"
    let l:badFile = substitute(l:badFile,'^||\(.*\)','\3','')
    let l:badFile = substitute(l:badFile,'\(^.*\):\d*:.*','\1','')
    let l:badFile = substitute(l:badFile,'\(^.*.java\):\d*:.*','\1','')
    let l:badFile = substitute(l:badFile,'\[javac\]\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'^\s*\(.*\)','\1','')
    let l:current = getline(".")
    let l:lineNumber = substitute(l:current,'.*:\(\d*\):.*','\1','')
    let l:lineNumber = substitute(l:current,'.*.java:\(\d*\):.*','\1','')
    let l:windowNumber = bufwinnr( l:badFile )
    call JumpToLineNoCol(l:windowNumber, l:lineNumber, l:badFile)
    return
  "Is this kjc with -emacs?
  elseif getline(".") =~ '^||.*\.java:\d*:.*'
    echo "kjc!"
    let l:badFile = substitute(l:badFile,'^||\s*\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'\(^.*\.java\):\d*:.*$','\1','')
    let l:current = getline(".")
    let l:lineNumber = substitute(l:current,'.*:\(\d*\):.*','\1','')
    let l:windowNumber = bufwinnr( l:badFile )
    call JumpToLineNoCol(l:windowNumber, l:lineNumber, l:badFile)
  "Is this sun's jdk?
  elseif getline(".") =~ '\.java:\d.*:'
    echo "javac!"
    let l:badFile = substitute(l:badFile,'^||\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'\(^.*\):\d*:.*','\1','')
    let l:badFile = substitute(l:badFile,'\[javac\]\(.*\)','\1','')
    let l:badFile = substitute(l:badFile,'^\s*\(.*\)','\1','')
    let l:current = getline(".")
    let l:lineNumber = substitute(l:current,'.*:\(\d*\):.*','\1','')
    let l:windowNumber = bufwinnr( l:badFile )
    call JumpToLineNoCol(l:windowNumber, l:lineNumber, l:badFile)
    return
  "Is this sun's jdk 1.4? (This block added by Michael Scheper <ant.vim@michaelscheper.com>)
  elseif getline(".") =~ '^.*\.java|\d\+\scol\s\d\+|'
    echo "javac 1.4!"
    let l:current = getline(".")
    let l:badFile = l:current
    let l:verticalBar = stridx( l:badFile, '|' )
    if l:verticalBar != -1
      let l:badFile = strpart( l:badFile, 0, l:verticalBar )
    endif
    let l:lineNumber = substitute( l:current, '^[^|]*|', "", "" )
    let l:lineNumber = substitute( l:lineNumber, '\s*col.*$', "", "" )
    let l:columnNumber = substitute( l:current, '^[^|]*|\d\+\scol\s', "", "" )
    let l:columnNumber = substitute( l:columnNumber, '|.*$', "", "" )
    let l:windowNumber = bufwinnr( l:badFile )
    call JumpToLineWithCol(l:windowNumber, l:lineNumber, l:badFile)
    return
  else
    redraw
    echo 'Cannot parse file from this line!'
    return
  endif
endfunction

function! ParseBuildFile()
  if v:version > 601
    let saveReg = getreg('"')
    let saveRegType = getregtype('"')
  else
    let saveReg = @"
  endif
  new
  silent! exec 'read '.g:buildFile
  silent! exec 'g/^$/d'
  "leave only target tags
  silent! exec 'g/^\s*<!--.*-->\s*$/d'
  silent! exec 'g/<target.*[^>]$/exe "norm! v/>\<CR>J"'
  silent! exec 'g/<!--.*\_.*.*-->/exe "norm! v/-->\<CR>J"'
  silent! exec '%s/\([^>]\)\s*\n\s*\([^<\s]\)/\1 \2/g'
  silent! exec '%s/<\/target>//'
  silent! exec 'g!/<target\s/d'
  silent! exec '%s/^\s*<target\s.*name="\([^"]*\)".\+/\1/eg'

  "escape any periods
  silent! exec '%s/\./\\./g'
  let entries=line("$")
  let target = 1
  silent! exec 'aunmenu &Plugin.&ANT.\ Target'
  while target <= entries
    let cmdString = ':call DoAntCmd(g:antOption." -buildfile",g:buildFile,"'.getline(target).'")<cr>'
    let menuString = '&Plugin.&ANT.\ Target.\ ' . getline(target) . '  ' . cmdString
    exe 'amenu ' . menuString . '<cr>'
    let target = target + 1
  endwhile
  set nomodified
  bwipeout
  if v:version > 601
    call setreg('"', saveReg, saveRegType) 
  else
    let @" = saveReg
  endif
  return 1
endfunction

function! BuildTargetMenu()
    if !filereadable(g:userBuildFile)
        let g:buildFile=expand('%:p:h').'/build.xml'
    else
        let g:buildFile=g:userBuildFile
    endif
    if !filereadable(g:buildFile)
        redraw
        let g:buildFile = './build.xml'
        return
    endif
    call ParseBuildFile()
    return
endfunction

function! SetBuildFile()
    let g:userBuildFile=escape(input('build.xml location: '), '"<>|&')
    if !filereadable(g:userBuildFile)
        redraw
        echo g:userBuildFile.' does not exist!'
        return
    endif
    let g:buildFile = g:userBuildFile
    call BuildTargetMenu()
    return
endfunction

function! SetLogFile()
  let g:logFile=escape(input('name of log file: '), '"<>|&')
  return
endfunction

function! DoAntCmd(cmd,...)
  if !exists("a:1")
    let ant_cmd='ant -emacs '.a:cmd
  else
    if !filereadable(a:1) && match(a:cmd ,"-find") == -1
            echo a:cmd
      redraw
      echo 'build.xml is not readable!'
      return
    endif
    if exists("a:2")
      if (g:logFile == '')
        let ant_cmd='ant -emacs '.a:cmd.' '.a:1.' '.a:2
      else
        let ant_cmd='ant -emacs -logfile '.g:logFile.' '.a:cmd.' '.a:1.' '.a:2
      endif
    else
      if (g:logFile == '')
        let ant_cmd='ant -emacs '.a:cmd.' '.a:1
      else
        let ant_cmd='ant -emacs -logfile '.g:logFile.' '.a:cmd.' '.a:1
      endif
    endif
  endif
  " jikes format 
  "let &errorformat="\ %#[javac]\ %#%f:%l:%c:%*\\d:%*\\d:\ %t%[%^:]%#:%m"
  " ant [javac] format 
  let &errorformat= "\%A%f:%l:\ %m,Symbol:\ %m,Class:\ %m,%-Z%p^"
  let &makeprg=ant_cmd
  silent! execute 'make'
  silent! execute 'cwindow'
  silent! execute 'copen'
endfunction

function! SetBuildTarget()
  let target=escape(input('name of build target: '), '"<>|&')
  call DoAntCmd(g:antOption.' -buildfile',g:buildFile, target)
endfunction

function! FindAndRunTarget()
  let target=escape(input('name of build target: '), '"<>|&')
  chdir %:p:h
  call DoAntCmd(g:antOption.' -find', 'build.xml', target)
  chdir -
endfunction

function! SetAntOption(option)
  silent! exec 'aunmenu &Plugin.&ANT.\ Set\ Option'
  silent! exec 'amenu 100 &Plugin.&ANT.\ Set\ Option'

  if (a:option == 'quiet')
    if (g:antOption !~ 'quiet')
      let g:antOption = g:antOption . ' -quiet'
    else
      let g:antOption = substitute(g:antOption, ' -quiet', '', 'g')
    endif
  endif
  if (a:option == 'verbose')
    if (g:antOption !~ 'verbose')
      let g:antOption = g:antOption . ' -verbose'
    else
      let g:antOption = substitute(g:antOption, ' -verbose', '', 'g')
    endif
  endif
  if (a:option == 'debug')
    if (g:antOption !~ 'debug')
      let g:antOption = g:antOption . ' -debug'
    else
      let g:antOption = substitute(g:antOption, ' -debug', '', 'g')
    endif
  endif
  if (a:option == 'emacs')
    if (g:antOption !~ 'emacs')
      let g:antOption = g:antOption . ' -emacs'
    else
      let g:antOption = substitute(g:antOption, ' -emacs', '', 'g')
    endif
  endif
  if (a:option == 'clear')
    let g:antOption = ''
  endif
  if (g:antOption =~ 'quiet')
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Quiet\ * :call SetAntOption('quiet')<cr>
  else
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Quiet :call SetAntOption('quiet')<cr>
  endif
  if (g:antOption =~ 'verbose')
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Verbose\ * :call SetAntOption('verbose')<cr>
  else
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Verbose :call SetAntOption('verbose')<cr>
  endif
  if (g:antOption =~ 'debug')
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Debug\ * :call SetAntOption('debug')<cr>
  else
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Debug :call SetAntOption('debug')<cr>
  endif
  if (g:antOption =~ 'emacs')
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Emacs\ * :call SetAntOption('emacs')<cr>
  else
    amenu  &Plugin.&ANT.\ &Set\ Option.\ &Emacs :call SetAntOption('emacs')<cr>
  endif
  amenu  &Plugin.&ANT.\ &Set\ Option.\ &None  :call SetAntOption('clear')<cr>

endfunction

"It all starts here
if exists("loaded_antmenu")
  aunmenu ANT
else
  let loaded_antmenu=1
endif

"globals
if !exists("g:logFile")
  let g:logFile = ''
endif
if !exists("g:antOption")
  let g:antOption = ''
endif
if !exists("g:userBuildFile")
    let g:userBuildFile = ''
endif

"This also sets the global varibale buildFile
call BuildTargetMenu()

"keyboard shortcuts
map  ,b  :call DoAntCmd(g:antOption.' -buildfile',g:buildFile)<cr>
map  ,s  :call SetBuildFile()<cr>
map  ,f  :chdir %:p:h<cr> :call DoAntCmd(g:antOption.' -find',g:buildFile)<cr> :chdir -<cr>
map  ,l  :call SetLogFile()<cr>
map  ,g  :call GetProbFile()<cr>
map  ,t  :call SetBuildTarget()<cr>
map  ,z  :call FindAndRunTarget()<cr>

"build ant menu
amenu  &Plugin.&ANT.\ &Build  :call DoAntCmd(g:antOption.' -buildfile',g:buildFile)<cr>
amenu  &Plugin.&ANT.\ &Find   :chdir %:p:h<cr> :call DoAntCmd(g:antOption.' -find',g:buildFile)<cr> :chdir -<cr>

amenu &Plugin.&ANT.\ &Files.\ set\ build\ file  :call SetBuildFile()<cr>
amenu &Plugin.&ANT.\ &Files.\ echo\ build\ file  :echo g:buildFile<cr>
amenu &Plugin.&ANT.\ &Files.\ set\ log\ file  :call SetLogFile()<cr>
amenu &Plugin.&ANT.\ &Files.\ echo\ log\ file  :echo g:logFile<cr>
amenu &Plugin.&ANT.\ &Files.\ no\ log\ file  :let g:logFile = ''<cr>
amenu &Plugin.&ANT.\ &Project\ Help   :call DoAntCmd('-projecthelp')<cr>
amenu &Plugin.&ANT.\ &Help     :call DoAntCmd('-help')<cr>
amenu &Plugin.&ANT.\ &Version     :call DoAntCmd('-version')<cr>

au BufEnter * :call BuildTargetMenu()
au BufEnter * :call SetAntOption('')
