""""""""""""""""""""""""""""""""""
" James Flohr       Mxdtr0nic    "
""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""
" New Stuff Tryouts -            "
""""""""""""""""""""""""""""""""""
"access man pages inside vim
runtime! ftplugin/man.vim

function! GetVisual()
    try
        let v_save = @v
        normal! gv"vy
        return @v
    finally
        let @v = v_save
    endtry
endfunction

fun! Center()
    let v = GetVisual()
    "let l = getline('.')
    let lre = '^\zs\s*\ze\S'
    let rre = '\s*$'
    let sp= matchstr(v,lre)
    let sp .= matchstr(v,rre)
    let ln=len(sp)
    let v = substitute(v,lre,sp[:ln/2-1],'')
    let v = substitute(v,rre,sp[ln/2:],'')
    let ve_save = &virtualedit
    let v_save = @v
    let &virtualedit = 'all'
    call setreg('v', v,visualmode())
    normal! gvx"vP
    let @v = v_save
    let &virtualedit = ve_save
endf

set splitright

" using vimdiff with multiple versions of file,
"   this should keep the scroll lock of all versions of the file
"   when I turn off the diff for some of them
"set scrollbind  " I think its screwing up split cursor, making me scroll 
"   the entire file when I change bufers
"   Yes just for diff. :diffoff or :!diff should reset these options
""""""""""""""""""""""""""""""""""
" New Stuff Tryouts - Charles    "
""""""""""""""""""""""""""""""""""
"  Set the automatic load when the file is changed
set autoread
set cursorline              "  Highlight the current line
"  Pixel row inserted between characters
set linespace=1

" netrw directory viewer opens in new vert buffer
"let g:netrw_browse_split=2
" just use smarter buffering, this is a bad sol

" stupid place uses 120 line width but has tiny monitors
" BuT ThEY ArE cOMfoRt MoNItoRs.... kill me
set nowrap

"  Highlight matching parentheses
set showmatch

" prefer vertical orientation when using :diffsplit
set diffopt+=vertical
" VIM auto complete for vim commands
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum
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
set tabstop=4
set shiftwidth=4
set smartindent
set expandtab
" automatical - Charles Barkley
"set autoindent

set smarttab
"  gvim for txt files
"OP backspace
set backspace=indent,eol,start
set gdefault
" Highlight don't move to next search hit
nnoremap * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" keep cursor position over buffer switches
" THIS SHIT IS not playing nice when I have the same file open three times man...
" This shit moves to a search result on any buffer change, disgusting...
" why did I ever need this? isn't this built in????
"augroup CursorPosition
"  autocmd!
"  autocmd BufLeave * let b:winview = winsaveview()
"  autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
"augroup END

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
"set relativenumber
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
"set statusline=
"set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
"set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
"set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
"set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
"set statusline+=\ %n\                                          " buffer number
"set statusline+=%#Visual#                                      " colour
"set statusline+=%{&paste?'\ PASTE\ ':''}
"set statusline+=%{&spell?'\ SPELL\ ':''}
"set statusline+=%#CursorIM#                                    " colour
"set statusline+=%R                                             " readonly flag
"set statusline+=%M                                             " modified [+] flag
"set statusline+=%#Cursor#                                      " colour
"set statusline+=%#CursorLine#                                  " colour
"set statusline+=\ %t\                                          " short file name
"set statusline+=%=                                             " right align
"set statusline+=%#CursorLine#                                  " colour
"set statusline+=\ %{ShowFileFormatFlag(&fileformat)}\          " fileformat
"set statusline+=\ %Y\                                          " file type
"set statusline+=%#CursorIM#                                    " colour
"set statusline+=\ %3l:%-2c\                                    " line + column
"set statusline+=%#Cursor#                                      " colour
"set statusline+=\ %3p%%\                                       " percentage
""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\                                          " buffer number
set statusline+=%#WildMenu#                                      " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#WildMenu#                                    " colour
set statusline+=%R                                             " readonly flag
set statusline+=%M                                             " modified [+] flag
set statusline+=%#WildMenu#                                      " colour
set statusline+=%#WildMenu#                                  " colour
set statusline+=\ %t\                                          " short file name
set statusline+=%=                                             " right align
set statusline+=%#WildMenu#                                  " colour
set statusline+=\ %{ShowFileFormatFlag(&fileformat)}\          " fileformat
set statusline+=\ %Y\                                          " file type
set statusline+=%#WildMenu#                                    " colour
set statusline+=\ %3l:%-2c\                                    " line + column
set statusline+=%#WildMenu#                                      " colour
set statusline+=\ %3p%%\                                       " percentage
