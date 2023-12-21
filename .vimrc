""""""""""""""""""""""""""""""""""
" James Flohr       Medtronic    "
""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""
" New Stuff Tryouts              "
""""""""""""""""""""""""""""""""""
" netrw directory viewer opens in new vert buffer
let g:netrw_browse_split=2

""""""""""""""""""""""""""""""""""
" Internals                      "
""""""""""""""""""""""""""""""""""
"turn off vi strict compatability
set nocompatible
"history, undo
set history=128
"no bells
set novisualbell
set noerrorbells

""""""""""""""""""""""""""""""""""
" Code Standard stuff            "
""""""""""""""""""""""""""""""""""
"set ffs=dos

""""""""""""""""""""""""""""""""""
" Key Remap - Input Changes      "
""""""""""""""""""""""""""""""""""
"tabs
set tabstop=2
set expandtab
" automatical - Charles Barkley
set autoindent
"set smarttab - doesn't work in
"  gvim for txt files
"OP backspace
set backspace=indent,eol,start
set gdefault
" Highlight don't move to next search hit
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" keep cursor position over buffer switches
augroup CursorPosition
  autocmd!
  autocmd BufLeave * let b:winview = winsaveview()
  autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
augroup END

"no shift key in normal mode
" UPDATE: well we might want to repeat motions now
"nnoremap ; :

""""""""""""""""""""""""""""""""""
" Tags                           "
""""""""""""""""""""""""""""""""""
if has("cscope")
   let cscope_db=findfile("cscope.out", ".;")
   let cscope_path=matchstr(cscope_db, ".*/")
"echo "db"
"echo cscope_db
"echo "path"
"echo cscope_path
   if !empty(cscope_db) && filereadable(cscope_db)
      exe "cs add" cscope_db cscope_path
   endif
endif

""""""""""""""""""""""""""""""""""
" Visual                         "
""""""""""""""""""""""""""""""""""
" Dracula bwaaaahh
if v:version < 802
    packadd! dracula
endif
syntax enable
colorscheme dracula
""change font                     "
"set guifont=Consolas:h11
""search highlighted              "
set hlsearch
""relative line number            "
set relativenumber
""syntax highlighting             "
syntax enable
""custom color scheme             "
"colorscheme wombat256mod
""terminal window default title   "
"set title
"set titlestring=LOOKING-GLASS titlelen=70

"Color Column at width
"   Don't like because visual splits...
"   Also strict line width isnt in coding standards here
"set colorcolumn=120
"highlight ColorColumn ctermbg=0 guibg=lightgrey

"   use normal regex in /searches
"nnoremap / /\v
"vnoremap / /\v

""""""""""""""""""""""""""""""""""
" Functions                      "
""""""""""""""""""""""""""""""""""
function ShowFileFormatFlag(var)
  if ( a:var == 'dos' )
    return '[dos]'
  elseif ( a:var == 'mac' )
    return '[mac]'
  elseif ( a:var == 'unix' )
    return '[unix]'
  else
    return '[unknown]'
  endif
endfunction

""""""""""""""""""""""""""""""""""
" Status Line                    "
""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\                                          " buffer number
set statusline+=%#Visual#                                      " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#CursorIM#                                    " colour
set statusline+=%R                                             " readonly flag
set statusline+=%M                                             " modified [+] flag
set statusline+=%#Cursor#                                      " colour
set statusline+=%#CursorLine#                                  " colour
set statusline+=\ %t\                                          " short file name
set statusline+=%=                                             " right align
set statusline+=%#CursorLine#                                  " colour
set statusline+=\ %{ShowFileFormatFlag(&fileformat)}\          " fileformat
set statusline+=\ %Y\                                          " file type
set statusline+=%#CursorIM#                                    " colour
set statusline+=\ %3l:%-2c\                                    " line + column
set statusline+=%#Cursor#                                      " colour
set statusline+=\ %3p%%\                                       " percentage
