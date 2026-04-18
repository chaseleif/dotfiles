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
" status bar is line above insert-mode cursor row
set laststatus=2
":help statusline
" status line is filepath/filename row:col
set statusline+=%F\ %l\:%c
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

hi DiffAdd ctermfg=White ctermbg=DarkGreen
hi DiffChange ctermfg=None ctermbg=None
hi DiffDelete ctermfg=LightBlue ctermbg=Red
hi DiffText ctermfg=Yellow ctermbg=Red

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

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufReadPost * call TabsOrSpaces()
  autocmd FileType make setlocal noexpandtab
  autocmd BufWritePost * if getline(1) =~ '^#!.*'
    \ | silent execute '!chmod +x ' . shellescape(expand('%')) | endif
endif
