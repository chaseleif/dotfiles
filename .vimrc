" if backspace/del doesn't work right
" set t_kb=
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
:autocmd FileType make set noexpandtab
