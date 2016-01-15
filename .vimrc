" ~/.vimrc
" attrib: vimrc_example by Bram Moolenaar
" attrib: http://briancarper.net/

"" Basic settings
set nocompatible                  " vim defaults (not vi)
syntax on                         " enable syntax highlighting
filetype plugin indent on         " filetype detection, w/ plugin, indent supprt

set encoding=utf-8
set fileencoding=utf-8

set backspace=indent,eol,start    " backspace erases in insert mode
set ruler                         " show cursor position in statusbar
set showcmd                       " show partial command in status line
set wrap                          " wrap lines automatically (create new line)
set history=5000                  " keep 5000 lines of command line history
"set number                        " show line numbers

"" Backups
set backup                                     " backup enable
set undofile                                   " undo enable
set backupdir=$HOME/.cache/vim/backup/,/tmp/   " backup directory
set directory=$HOME/.cache/vim/backup/,/tmp/   " backup directory for .swp
set undodir=$HOME/.cache/vim/backup/,/tmp/     " undosave directory
set viminfo+=n$HOME/.cache/vim/viminfo         " vim command history info
set runtimepath=$HOME/.local/share/vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after

"" Tab settings
set tabstop=2                     " tab character amount
set expandtab                     " tabs as space
set shiftwidth=2                  " number of spaces for autoindent
set softtabstop=2                 " spaced-tabs act as normal tabs (bksp...)
"set smartindent                   " smart autoindenting on a new line

"" Folding
set foldcolumn=0
set foldmethod=syntax
set foldlevelstart=1

"" Navigation
set nostartofline                 " navigate closest column character(up/down)
set showtabline=2                 " tab bar always on
set scrolloff=2                   " offset scrolling boundaries # of lines
set vb t_vb=                      " visual bells disable
"set showmatch                     " bouncy parenthesis

"" Search
set hlsearch                      " highlight searches
set incsearch                     " highlight immediately
set ignorecase                    " non-case-sensitive searches
set smartcase                     " additional parameters for above
set wrapscan                      " search will wrap after end of file

"" Appearance
if &term == "xterm"               " use 256 color palette if available
  set t_Co=256
  "colorscheme wombat256
  colorscheme jellybeans          " colorscheme
  autocmd Filetype markdown  setlocal background=dark syn=pandoc
  autocmd Filetype markdown  colorscheme pencil
  autocmd Filetype mediawiki setlocal background=dark
  autocmd Filetype mediawiki colorscheme pencil
else
  colorscheme default
  autocmd Filetype markdown  setlocal background=dark syn=pandoc
  autocmd Filetype markdown  colorscheme default
endif
set cursorline                    " highlight current line (disable underline)

"" Filetype specific
autocmd BufNewFile,BufReadPost *.md set filetype=markdown " .md as markdown
autocmd Filetype gitcommit setlocal spell textwidth=72 formatoptions+=t
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

"" Others
set wildmenu                      " helpmenu tab completion
set wildignore+=*.o,*~,.lo        " ignore suffixes
set suffixes+=.in,.a              " lower priority of these suffixes
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg,

:set formatoptions=l              " break comment lines...
:set lbr                          " but not at middle of words

augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END                       " restore cursor position on open

set noeol                         " attempt to stop prepending a newline at eof
au BufNewFile * set noeol

" set listchars=tab:.\ ,trail:•    " bullet trailing spaces and tabs
" set list
"autocmd bufwritepre * :%s/\s\+$//e " remove trailing whitespaces when saving
"set mouse=                        " mouse navigation (tabs, cursor...)
                                  " (n)ormal, (c)ommand, (i)nsert, (a)ll
                                  " interferes w/ pasting from x clipboard

"" Key mappings
map <F1> <nop>                          " F1 disable. Use :help instead
set pastetoggle=<F3>                    " F2: paste mode (disables autoindent)
nn <F5> :setlocal spell! spell?<CR>     " F3: spelling toggle
vmap <F7> :!xclip -f -sel clip<CR>      " F7: copy selection to xorg clipboard
map <F8> :-1r !xclip -o -sel p<CR>      " F8: paste xorg clipboard (middleclick)
map <F9> <Esc>:set mouse=<CR>           " F9: mouse support off
map <F10> <Esc>:set mouse=ni<CR>        " F10:mouse support on

map <CR> o<Esc>                         " Enter: newline, remain in command-mode
:noremap <silent> <Space> :silent noh<Bar>echo<CR> " Space: unhighlight search

noremap <C-J> gj                        " Ctrl + J: Joined line navigate down
noremap <C-K> gk                        " Ctrl + K: Joined line navigate up
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
