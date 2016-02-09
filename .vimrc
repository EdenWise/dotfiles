" Vim configuration
" thanks: vimrc_example by Bram Moolenaar

" Add-on manager
set nocompatible                          " add-on manager init. req. these off
filetype off
set runtimepath+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin("$HOME/.vim/bundle")
  Plugin 'VundleVim/Vundle.vim'           " add-on manager
  Plugin 'nanotech/jellybeans.vim'        " colorscheme
  Plugin 'noahfrederick/vim-hemisu'       " colorscheme
  Plugin 'reedes/vim-colors-pencil'       " colorscheme
  Plugin 'vim-pandoc/vim-pandoc'          " markdown add-on
  Plugin 'vim-pandoc/vim-pandoc-syntax'   " markdown add-on
  " Plugin 'vim-scripts/AfterColors.vim'    " colorscheme customization
  " Manual $HOME/colors/github.vim
call vundle#end()

" Generic
set encoding=utf-8                  " character encoding as Unix-standard
set fileencoding=                   " character encoding to convert to on save
set nocompatible                    " vim preferences over vi-only
filetype plugin indent on           " ft. detect., indent., & plugin support
set wrap                            " lines display wrapped not scroll horiz.
set history=5000                    " recorded command-history number
"set number                          " column for line-numbering display

" Navigation
set scrolloff=4                     " scrolling boundary lines offset by number
set showtabline=2                   " tabline display (tabs with document names)
set nostartofline                   " up/down navigation to closest character
set novisualbell                    " visual-feedback disable for errors
set showmatch                       " bracket match notification

" Backup
set backup                                       " backup enable
set backupdir=~/.vim/backup/,/tmp                " backup directory
set backupdir+=$HOME/_vim/backup,c:temp          " backup directory Windows
set directory=~/.vim/backup/,/tmp                " swap file directory 
set directory+=$HOME/_vim/backup/,c:/temp        " swap file directory Windows
set undofile                                     " undos enable
set undodir=~/.vim/backup/,/tmp                  " undo directory
set undodir+=$HOME/_vim/backup,c:/temp           " undo directory Windows

" Formatting
set backspace=indent,eol,start      " backspace erasures recogs. in insert mode
set formatoptions=l lbr             " comment lines add a newline at end of line
set tabstop=2                       " tab character amount
set expandtab                       " tabs expand as spaces
set autoindent                      " auto-indent
set shiftwidth=2                    " auto-indent number of spaces
set softtabstop=2                   " spaced-tabs act as normal tabs (bksp...)
"set smartindent                     " smart auto-indenting on a new line

" Diffing and folding
set diffopt+=vertical               " diffsplits as vertical
set foldcolumn=0
"set foldmethod=syntax
set foldmethod=manual
"set foldlevelstart=1

" Search
set hlsearch                        " searches are highlighted
set incsearch                       " searches are highlighted while typed
set ignorecase                      " searches non-case-sensitive
set smartcase                       " searches override ignorecase w/ specchars.
set wrapscan                        " searches wrap after end of file

" Statusline and wildmenu
set ruler                           " cursor position display in statusbar
set showcmd                         " partial-command display in statusbar
set laststatus=2                    " last-line as status always on
set wildmenu                        " help-menu tab completion
set wildignore+=*.o,*~,.lo          " help-menu file suffixes to ignore
set suffixes+=.in,.a                " help-menu file suffixes prioritize
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg,  

" Key maps
map <F1> <Esc>                                " F1—as [Esc.] key, for help ":h"
imap <F1> <Esc>
set pastetoggle=<F2>                          " F2—paste mode, auto-ind. disable
map <F3> :setlocal spell! spelllang=en_us<CR> " F3—spelling checker toggle
nmap <F4> :set invnumber<CR>            " F4-numbered lines toggle
nmap <F5> :set invautoindent<CR>              " F5—autoindent toggle
map <CR> o<Esc>                               " Enter—newline add below current
noremap <silent> <Space> :silent noh<Bar>echo<CR> " Space—search un-highlight

" Filetype-specific
autocmd Filetype gitcommit setlocal spell textwidth=72 formatoptions+=t
"autocmd Filetype markdown  setlocal syn=pandoc
let g:pandoc#folding#mode = ['manual']
let g:pandoc#folding#fdc = 0

" Others
set mouse=a                       " mouse nav: (n)orm (c)ommand (i)nsert (a)ll
set clipboard=unnamed             " system clipboard under windows hack — ggyG
autocmd BufReadPost *							" restore cursor position on file open
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
if !exists(":DiffOrig")						" differentiate original file command
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  	\ | wincmd p | diffthis
endif
set noeol                         " newline-appending-automation at EOF stop
au BufNewFile * set noeol

" Appearance
syntax on                           " syntax highlighting enable
"set cursorline                      " highlight cursor line (disable underline)
"set cursorcolumn                    " highlight cursor col. (both slow render)

" Appearance: GUI
if has ('gui_running')
  set guioptions-=T                 " toolbar hide 
  set lines=54                      " number of lines 
  set columns=80                    " number of columns
  if has ('gui_gtk2')
    set guifont=Inconsolata\ 12
  elseif has ("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has ("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" Appearance: colorscheme
if has ('gui_running') || &t_Co == 256
  set background=light
  if &background == "light"
    colorscheme pencil
    set background=light            " override dark as colorscheme forces
  else
    colorscheme jellybeans
  endif
else
  colorscheme default
endif

" Appearance: colorscheme customizations
if g:colors_name == "github"
  "highlight Normal       ctermbg=235
  highlight CursorLine   ctermbg=254
  highlight CursorColumn ctermbg=254
endif

if g:colors_name == "jellybeans"
  highlight Normal     guifg=#dddddd guibg=#272727
  highlight Comment    gui=none
  highlight Cursorline ctermbg=234 guibg=#222222
  highlight Visual     ctermbg=240
  " Old from blog:
  " "\   'Normal': { 'ctermbg': '242' },
  "\   'CursorLine': { 'ctermbg': '238' },
  "\}
  "highlight Normal     ctermbg=323232
  "highlight Normal     ctermbg=303030
  "highlight CursorLine ctermbg=238
  "highlight Visual     ctermbg=240
endif

if g:colors_name == "pencil"
  highlight CursorColumn ctermbg=255
  highlight CursorLine   ctermbg=255
  highlight Normal       ctermbg=none
  highlight IncSearch    ctermfg=197 ctermbg=none
  highlight Search       ctermfg=199 ctermbg=none
endif

" vim:set tabstop=2 shiftwidth=2 expandtab
