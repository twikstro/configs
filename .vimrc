"--------------------------------------------------------------
" .vimrc
"--------------------------------------------------------------

"--------------------------------------------------------------
" Behavior
"--------------------------------------------------------------

" These are for Vundle
set nocompatible        " Do not act overly VI-compatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

syntax on		            " Highlight syntax


" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" My bundles

" Libaries
Bundle 'L9'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Bundle 'kien/ctrlp.vim'
" Syntax highlighting
Bundle 'scrooloose/syntastic'
" Omnicompletion done better
Bundle 'Valloric/YouCompleteMe'
" Control git from vim
Bundle 'tpope/vim-fugitive'
" Display and manipulate directorty tree
"Bundle 'scrooloose/nerdtree'
" Textmateish snipets with vim
Bundle 'SirVer/ultisnips'
Bundle 'mfukar/robotframework-vim'
Bundle 'tpope/vim-surround'
Bundle 'sjl/gundo.vim'

filetype plugin indent on
cabbrev E Explore

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
                        " set brk=\ \    !@*-+;:,./? " Characters to break line at
set laststatus=2        " When to use status line for the last window
set backspace=2         " Allow backspacing over characters entered in previous inserts
set pastetoggle=<f5>    " Toggle paste with F5

" Fold
set foldmethod=indent
set foldlevel=5
set foldnestmax=1

"--------------------------------------------------------------
" GUI related
"--------------------------------------------------------------
set guioptions-=T                    " TODO
"set grepprg=grep\ -nH\ $*\ /dev/null " program used for the ":grep" command
set grepprg=ack\ -H\ --nocolor\ --nogroup " program used for the ":grep" command

"--------------------------------------------------------------
" Tags
"--------------------------------------------------------------
let Tlist_WinWidth = 40
let Tlist_Sort_Type = "name"
let g:tex_flavor = "latex"


" netrw
let g:netrw_liststyle=3

"--------------------------------------------------------------
" Look - colors etc.
"--------------------------------------------------------------
set t_Co=256            " 256 colors
colorscheme wombat256   " Use colorscheme called wombat
			            " Put scheme.vim in ~/.vim/colors

"--------------------------------------------------------------
" Text formatting
"--------------------------------------------------------------

set expandtab		    " Convert tabs to spaces
set shiftwidth=4	    " number of spaces used for each step of (auto)indent
set tabstop=4           " number of spaces a <Tab> in the text stands for
set softtabstop=4       " if non-zero, number of spaces to insert for a <Tab>

" Command line two rows high
set ch=2

"--------------------------------------------------------------
" Status line
"--------------------------------------------------------------
" Git branch
" Aligning rest right (%=)
set statusline=%{fugitive#statusline()}
" Filename[file encoding, os]
set statusline+=\ %t\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]
" Whitespace
set statusline+=%<
" [RO] if file is read only (%r)
" Modified flag (%m)
" File contents, e.g. [python], [ruby] (%y)
set statusline+=%r%y%#error#%m%*%=
set statusline+=%#errormsg#%{SyntasticStatuslineFlag()}%*%h
set statusline+=%c,%l/%L\ %P
"--------------------------------------------------------------
" Textwidths for different filetypes
"--------------------------------------------------------------
autocmd FileType ruby set sw=4  " Shiftwidth (# spaces for each step of autoident)
autocmd FileType ruby set tw=4

autocmd FileType tex set tw=70

autocmd FileType python set sw=4
autocmd FileType python set tw=110

autocmd FileType xml setf xml

au BufNewFile,BufRead *.groovy  setf groovy
autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()
"

" Open vimrc in new tab with ,v
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
nmap <leader>V :so $MYVIMRC<CR>
" Cycle through location list
nmap <leader>b :lprev<CR>
nmap <leader>n :lnext<CR>
" Fold handling
nnoremap <space> za
vnoremap <space> zf
"nmap <leader>a <Esc>:Ack!<CR>

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
noremap <silent> <F1> :bnext<CR>
noremap <silent> <F2> :bprev<CR>
noremap <silent> <F3> :tabp<CR>
noremap <silent> <F4> :tabN<CR>
noremap <silent> <F5> :GundoToggle<CR>
map <F6> :Explore<CR>
"noremap <F7>
"noremap <F8>
nnoremap <silent> <F9> :call <SID>StripTrailingWhitespaces()<CR>
nnoremap <silent> <F12> :close<CR>

" mappings to search for the highlighted word when pressing * or # in visual mode
vnoremap * <Esc>/<c-r>=escape(@*, '\/.*$^~[]')<CR><CR>
vnoremap # <Esc>?<c-r>=escape(@*, '\/.*$^~[]')<CR><CR>

" Mapping for moving among windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Bubble single lines
"nmap <C-Up> ddkP
"nmap <C-Down> ddp
" Bubble multiple lines
"vmap <C-Up> xkP`[V`]
"vmap <C-Down> xp`[V`]
" Map gV to select last edited/pasted selection
nmap gV `[v`]

" Unused highly accessible keys:
" TODO: Use these
nmap ä .
nmap ö .
nmap å .
nmap ' .
nmap - .

" Ultisnips configuration
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "F11"
let g:UltiSnipsJumpBackwardTrigger = "F10"

" Gundo configuration
let g:gundo_width = 60
let g:gundo_preview_height = 20
" Place preview under open window, instead of under gundo
let g:gundo_preview_bottom = 0
let g:gundo_right = 0

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Macros
" Open up modifiable files in tabs + open a buffer with lines to remove in
" another buffer. For convenience you can do ':set nomodifiable' on the buffer
" of files to remove
" Run this macro like 'ggVG :normal @o'
" ggVG - visually select the file (file with patterns to remove)
" :normal @o - invoke the normal-mode command found in register o for each line
"
" The macro selects each line in a file, and for all other open tabs searches
" and removes lines matching it
" 0v$h - select a line (excluding newline at end)
" "lyy - yank line to register l
" :tabdo - execute the following for each tab
" exe - used to be able to reference register l:s contents in a g(lobal)
" command
" g/@l/d - delete lines matching this pattern
let @o = "0v$h\"lyy:tabdo exe 'g/' . @l . '/d'"


"--------------------------------------------------------------
" Addons
"--------------------------------------------------------------

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Syntastic
" Use pylint for python
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_checker_args = '--rcfile=~/.pylintrc'
" Use different signs to indicate different warnings/errors
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 1
" Todo: Do i want to use this
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" Had let g:syntastic_quiet_warnings=0, maybe the one below needs some
" configuration
"let g:syntastic_quiet_messages

" NERDtree for displaying directory structure
" Git Branch
" Only show current branch with current=1
let g:git_branch_status_head_current=1
let g:git_branch_status_text=""
" Surround branch name with these chars
let g:git_branch_status_around="[]"
" What to print when cwd not a git repo
let g:git_branch_status_nogit=""
let g:robot_syntax_for_txt=1

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! <SID>RemoveBasedOnThisfile()
    set modifiable
    set nomodifiable
endfunction

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()

function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

