"--------------------------------------------------------------
" .vimrc
"--------------------------------------------------------------

"--------------------------------------------------------------
" Behavior
"--------------------------------------------------------------
set nocompatible        " Do not act overly VI-compatible

syntax on		        " Highlight syntax
filetype plugin indent on
set incsearch		    " Display matches as you write the pattern
set hlsearch		    " Highlight matches
set ignorecase          " Search ignores case
set smartcase           " Ignore 'ignorecase' if pattern contains capitals

set autoread		    " Automatically read a file that was changed outside vim
set hidden		        " Do not unload a buffer when no longer shown in a window
set wildmenu		    " Display options when pressing tab on command line
			            " e.g. :color <tab> USETHIS
set whichwrap=h,l,[,],~ " list of flags specifying which commands wrap to another line
set scrolloff=5         " Show 5 lines above and below cursor
                        " - e.g. when scrolling below screen edge
set nojoinspaces        " Do not add spaces after . when joining lines
set linebreak           " Break lines at 'breakat' chars
"set brk=\ \    !@*-+;:,./? " Characters to break line at
set laststatus=2        " When to use status line for the last window
set backspace=2         " Allow backspacing over characters entered in previous inserts 

"--------------------------------------------------------------
" GUI related
"--------------------------------------------------------------
set guioptions-=T                    " TODO
set grepprg=grep\ -nH\ $*\ /dev/null " program used for the ":grep" command
set guifont=Andale\ Mono\ 12         " TODO

"--------------------------------------------------------------
" Tags
"--------------------------------------------------------------
let Tlist_WinWidth = 40
let Tlist_Sort_Type = "name"
let g:tex_flavor = "latex"

"--------------------------------------------------------------
" Look - colors etc.
"--------------------------------------------------------------
set t_Co=256        " 256 colors
colorscheme wombat256 " Use colorscheme called wombat
			        " Put scheme.vim in ~/.vim/colors

"--------------------------------------------------------------
" Text formatting
"--------------------------------------------------------------

set expandtab		    " Convert tabs to spaces
set shiftwidth=2	    " number of spaces used for each step of (auto)indent
set tabstop=2           " number of spaces a <Tab> in the text stands for
set softtabstop=2       " if non-zero, number of spaces to insert for a <Tab>

" Command line two rows high
set ch=2

"--------------------------------------------------------------
" Status line
"--------------------------------------------------------------
" name, encoding, changed, content, errorflag, col#, line#/len
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%<\ %#errormsg#%{SyntasticStatuslineFlag()}%*%h%m%r%y%=%c,%l/%L\ %P
" Derek Wyatts line
"set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]

"--------------------------------------------------------------
" Textwidths for different filetypes
"--------------------------------------------------------------
autocmd FileType ruby set sw=4  " Shiftwidth (# spaces for each step of autoident)
autocmd FileType ruby set tw=4

autocmd FileType tex set tw=70

autocmd FileType python set sw=4
autocmd FileType python set tw=110

"--------------------------------------------------------------
" Syntax highligting for log4j
"--------------------------------------------------------------
autocmd BufRead,BufNewFile *.log set syntax=log4j
autocmd BufRead,BufNewFile *.out set syntax=log4j


"--------------------------------------------------------------
" \\Highlight trailing whitespaces
"--------------------------------------------------------------
highlight ExtraWhitespace ctermbg=darkred guibg=#382424
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Related to bugfixing
autocmd BufReadPost quickfix set cursorline

" Mappings
" Move neatly through wrapped lines
noremap j gj
noremap k gk
" Disable arrows to encourage hjkl movement
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" ESC is far away, map it to C-c
noremap <C-c> <Esc>
"
" TODO: Use functionkeys
noremap <F1> :Rake<CR>

" Jump between buffers
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-l> :bnext<CR>

" mappings to search for the highlighted word when pressing * or # in visual mode
vnoremap * <Esc>/<c-r>=escape(@*, '\/.*$^~[]')<CR><CR>
vnoremap # <Esc>?<c-r>=escape(@*, '\/.*$^~[]')<CR><CR>

"--------------------------------------------------------------
" Addons
"--------------------------------------------------------------
set runtimepath^=~/.vim/bundle/ctrlp.vim
execute pathogen#infect()
