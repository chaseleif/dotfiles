" if backspace/del doesn't work right
" set t_kb=
" fix home/end messing up
" set <Home>=[7~
" set <End>=[8~
" make home/end go to start/end of file
" nnoremap (ctrl+v)(ctrl+home) to gg (beginning of file)
nnoremap [7^ gg
" nnoremap (ctrl+v)(ctrl+end) to G (end of file)
nnoremap [8^ G$
set number
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set hlsearch
syntax enable
hi Comment ctermfg=LightBlue
hi Constant ctermfg=Magenta
hi Identifier ctermfg=Cyan cterm=bold
hi LineNr ctermfg=Yellow
hi PreProc ctermfg=LightBlue
hi Statement ctermfg=Yellow
hi Type ctermfg=LightGreen
set colorcolumn=81
hi ColorColumn ctermbg=DarkGrey
filetype plugin indent off

function TabsOrSpaces()
  if getfsize(bufname("%")) > 256000
    return
  endif
  let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
  let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))
  if numTabs > numSpaces
    setlocal noexpandtab
  endif
endfunction

:autocmd BufReadPost * call TabsOrSpaces()
:autocmd FileType make set noexpandtab
