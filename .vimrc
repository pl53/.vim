" vim: set foldmarker={,} foldlevel=3 foldmethod=marker spell:
autocmd VimEnter * echo "Peng's vimrc version: 7.4"
" Notes {{{
"   ***********************************************************************   "
"   ***********************************************************************   "

    " Tips {
        " Hotkeys {
        " gx - go url under cursor
        " }
    " }
    " Todo {
        " TODO: prepare and cleanup configs {
        " write comments
        " write README about install and add screenshots
        " }
    " }
" }}}

" "General settings" {
    " Basic {{
        " Various stuff {
            syntax on
            set nocompatible
            set mouse=a
            set langmenu=en
            set fileencodings=utf-8
            set linespace=1 " add some line space for easy reading
            set ttyfast
        " }
        " Files {
            set encoding=utf-8
            set fileencoding=utf-8
            set fileencodings=utf-8,ucs-bom,cp1251
            set fileformat=unix
            set fileformats=unix,dos,mac
        " }
        " Behavior {
            set backspace=indent,eol,start " Set for maximum backspace smartness"
            set scrolloff=3 " don't scroll any closer to top/bottom
            set sidescrolloff=5 " don't scroll any closer to left/right
            set listchars=tab:▸\ ,trail:·,nbsp:+,nbsp:&,extends:>,precedes:>,conceal:~
            set list
            set display+=uhex " Show unprintables as <xx>
            set display+=lastline
            " set nolazyredraw
            set number
            set autoread
            set autowrite
            " set autochdir
            set gdefault
            set keywordprg=:help
       
            autocmd FileType * setlocal formatoptions-=o
            autocmd VimEnter * nested call SetupCtrlP()
            if has("autocmd")
              au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                    \| exe "normal! g'\"" | endif
            endif
            augroup helpfiles
             au!
             "au BufRead,BufEnter */doc/* wincmd L
             au BufRead */doc/* wincmd L
            augroup END
        "}
        " Tab and indent {
            set tabstop=4
            set shiftwidth=4
            set softtabstop=4
            set expandtab
            set smarttab
            set autoindent
            set smartindent
            set cindent
        " }
        " Line wraping {
            " set textwidth=79
            set wrap
            set linebreak " Only wrap on characters in `breakat`
            if has('multi_byte')
                let &showbreak = '↳ '
            else
                let &showbreak = '> '
            endif
        " }
        " Search {
            set showmatch
            set hlsearch
            set incsearch
            set ignorecase
            set smartcase
        " }
        " Status bar and command line settings {
            set cmdheight=1         " Less Hit Return messages
            set laststatus=2        " Always show status bar
            "set report=0            " Always report line changes for : commands
            "set ruler               " Show cursor location
            set shortmess=aoOtT     " Abbreviate the status messages
            "set showmode            " Show mode I'm in
            set showcmd             " Show command I'm typing
            "set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P
            set timeoutlen=500
        " }
        " Command line completion {
            set wildchar=<TAB>      " Character to start command line completion
            set wildmenu            " Enhanced command line completion mode
            set wildmode=longest:full,full

            " set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
            set wildignore+=*.o,*.obj,*.pyc,*.pyo,*.pyd,*.class,*.lock
            set wildignore+=*.png,*.gif,*.jpg,*.ico
            set wildignore+=.git,.svn,.hg
        " }
        " Backup,Undo,Swap {
            if isdirectory($HOME . '/.vim/backup') == 0
                silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
            endif
            set backupdir-=.
            set backupdir+=.
            set backupdir-=~/
            set backupdir^=~/.vim/backup/
            set backupdir^=./.vim-backup/
            set backup
            " Prevent backups from overwriting each other. The naming is weird,
            " since I'm using the 'backupext' variable to append the path.
            " So the file '/home/docwhat/.vimrc' becomes '.vimrc%home%docwhat~'
            autocmd BufWritePre * nested let &backupext = substitute(expand('%:p:h'), '/', '%', 'g') . '~'

            if isdirectory($HOME . '/.vim/swap') == 0
                silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
            endif
            set directory=./.vim-swap//
            set directory+=~/.vim/swap//
            set directory+=~/tmp//
            set directory+=.

            set viminfo+=n~/.vim/viminfo

            if exists("+undofile")
                " undofile - This allows you to use undos after exiting and restarting
                " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
                " :help undo-persistence
                if isdirectory($HOME . '/.vim/undo') == 0
                    silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
                endif
                set undodir=./.vim-undo//
                set undodir+=~/.vim/undo//
                set undofile
                set undolevels=1000 " maximum number of changes that can be undone
                set undoreload=10000 " maximum number lines to save for undo on a buffer reload
            endif
        " }
    " }}
    " (re)Maps {{
        let g:mapleader = ' '
            " Some useful maps {
                "imap ii <Esc>
                "nnoremap / /\v
                "vnoremap / /\v " allows use perl regexp in search patterns
                " strip trailing whitespaces
                nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
                " select pasted test
                nnoremap <leader>v V`]
                " Keep the cursor in place while joining lines
                nnoremap J mzJ`z
                nnoremap <tab> %
                vnoremap <tab> %

                " Heresy
                inoremap <c-a> <esc>I
                inoremap <c-e> <esc>A
                cnoremap <c-a> <home>
                cnoremap <c-e> <end>
                " Keep search matches in the middle of the window.
                nnoremap n nzzzv
                nnoremap N Nzzzv
                nnoremap <esc><esc> :<c-u>set nohlsearch<cr>
                nnoremap / :<C-u>set hlsearch<cr>/
                nnoremap ? :<C-u>set hlsearch<cr>?
                nnoremap * :<C-u>set hlsearch<cr>*
                nnoremap # :<C-u>set hlsearch<cr>#

                " Same when jumping around
                nnoremap g; g;zz
                nnoremap g, g,zz
                nnoremap <c-o> <c-o>zz
                nnoremap <c-i> <c-i>zz

                " Easier to type, and I never use the default behavior.
                noremap H ^
                noremap L $
                vnoremap L g_

                noremap j gj
                noremap k gk
                noremap gj j
                noremap gk k

                nnoremap ; :
                imap jj <Esc>o<Esc>
                imap kk <Esc>k
                imap ;; <Esc>A;<Esc>o
                imap jk <Esc>


                nnoremap <leader>\ :call ToggleNERDTreeAndTagbar()<CR>
                map <leader>ev <C-w><C-v><C-l>:e! $MYVIMRC<CR>
                map <leader>bd :bdelete<CR>
                map <leader>cd :cd %:p:h<CR>:pwd<CR>

                nnoremap <F2> :set invpaste paste?<CR>
                set pastetoggle=<F2>
                " <F2> setting paste mode

                nnoremap <silent> <leader>h :set invhlsearch<CR>
                " disable search highlight
                comm! W exec 'w !sudo tee % > /dev/null' | e!
                " sudo write
                vmap < <gv
                vmap > >gv
                " prevents leaving visual mode after indenting
                map <leader>os :FollowSymlink<CR>
                map <leader>, :w<CR>
                nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
                nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
                nnoremap <F5> :GundoToggle<CR>


            " }
        " Disabling arrows {
            imap <left> <nop>
            imap <right> <nop>
            imap <up> <nop>
            imap <down> <nop>
            nmap <left> <nop>
            nmap <right> <nop>
            nmap <up> <nop>
            nmap <down> <nop>
            map <left> <nop>
            map <right> <nop>
            map <up> <nop>
            map <down> <nop>
        " }
        " Splits navigation {
            nnoremap <C-h> <C-w>h
            nnoremap <C-j> <C-w>j
            nnoremap <C-k> <C-w>k
            nnoremap <C-l> <C-w>l
        " }
    " }}
    " Functions {{
        function! s:MyFollowSymlink() "{
            silent! let s:fname = resolve(expand('%:p'))
            silent! bwipeout
            silent! exec "edit " .s:fname 
            " TODO: prevent windows closing
        endfunction
        command! FollowSymlink call s:MyFollowSymlink()

        " augroup followsymlink
            " autocmd!
            " autocmd BufReadPost * FollowSymlink
        " augroup END 
        "}

        function! SetupCtrlP() "{
          if exists("g:loaded_ctrlp") && g:loaded_ctrlp
            augroup CtrlPExtension
              autocmd!
              autocmd FocusGained * nested CtrlPClearCache
              autocmd BufWritePost * nested CtrlPClearCache
            augroup END
          endif
      endfunction "}
        function! ToggleNERDTreeAndTagbar() "{
            let w:jumpbacktohere = 1
            " Detect which plugins are open
            if exists('t:NERDTreeBufName')
                let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
            else
                let nerdtree_open = 0
            endif
            let tagbar_open = bufwinnr('__Tagbar__') != -1

            " Perform the appropriate action
            if nerdtree_open && tagbar_open
                NERDTreeClose
                TagbarClose
            elseif nerdtree_open
                TagbarOpen
            elseif tagbar_open
                NERDTree
            else
                NERDTree
                TagbarOpen
            endif

            " Jump back to the original window
            for window in range(1, winnr('$'))
                execute window . 'wincmd w'
                if exists('w:jumpbacktohere')
                    unlet w:jumpbacktohere
                    break
                endif
            endfor
        endfunction "}
        function! FindDjangoSettings2() "{
            if strlen($VIRTUAL_ENV) && has('python')
                let django_check = system("pip freeze | grep -q Django")
                if v:shell_error
                    " echo 'django not installed.'
                else
                    " echo 'django is installed.'
                    let output = system("find $VIRTUAL_ENV \\( -wholename '*/lib/*' -or -wholename '*/install/' \\) -or \\( -name 'settings.py' -print0 \\) | tr '\n' ' '")
                    let outarray= split(output, '[\/]\+')
                    let module = outarray[-2] . '.' . 'settings'
                    let syspath = system("python -c 'import sys; print sys.path' | tr '\n' ' ' ")
                    " let curpath = '/' . join(outarray[:-2], '/')
                    execute 'python import sys, os'
                    " execute 'python sys.path.append("' . curpath . '")'
                    " execute 'python sys.path.append("' . syspath . '")'
                    execute 'python sys.path = ' . syspath
                    execute 'python os.environ.setdefault("DJANGO_SETTINGS_MODULE", "' . module . '")'
                endif
            endif
        endfunction "}
    " }}
" }

" "
" Package manager {

filetype off

if executable("git")

    " "Installing"  "{{{

        if !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
            echomsg "******************************"
            echomsg "Installing Vundler..."
            echomsg "******************************"
            !mkdir -p ~/.vim/bundle && git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
            let s:bootstrap=1
        endif

        set rtp+=~/.vim/bundle/Vundle.vim/
        call vundle#begin()

        if exists("s:bootstrap") && s:bootstrap
            unlet s:bootstrap
            PluginInstall
            quit
        endif

    " }}}
    " "Plugins and configs" {2

        " General {
            Plugin 'gmarik/vundle'
            " < Vundle - vim package manager > {
            " }
            Plugin 'Raimondi/delimitMate'
            " < Automatic closing of quotes, brackets, etc > {
                let g:delimitMate_expand_cr = 2
                let g:delimitMate_expand_space = 1
                let g:delimitMate_expand_inside_quotes = 1
                let g:delimitMate_balance_matchpairs = 1
                let g:delimitMate_jump_expansion = 1
                au FileType python let b:delimitMate_nesting_quotes = ['"']
            " }
            Plugin 'mattn/gist-vim'
            " < Vimscript for creating gists (http://gist.github.com) > {
                let g:gist_update_on_write = 2
                let g:gist_clip_command = 'xclip -selection clipboard'
                let g:gist_detect_filetype = 1
                let g:gist_open_browser_after_post = 1
                let g:gist_update_on_write = 2
                " Only :w! updates a gist
            " }
            Plugin 'Gundo'
            " < Undo tree >{
                map <leader>gt :GundoToggle<CR>
            " }
            Plugin 'scrooloose/nerdtree'
            " < File system explerer >{
                map <leader>nt :NERDTreeToggle<CR>
                let NERDTreeIgnore=['\.pyc$', '\~$']
            " }
            Plugin 'godlygeek/tabular'
            " < Alignment plugin > {
            " }
            Plugin 'SirVer/ultisnips'
            " < Snippets engine > {
                let g:UltiSnipsExpandTrigger="<tab>"
                let g:UltiSnipsJumpForwardTrigger="<tab>"
                let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
                let g:UltiSnipsEditSplit="horizontal"
            " }
            Plugin 'honza/vim-snippets'
            " < Snippets for ultisnips > {
            " }
            Plugin 'kien/ctrlp.vim'
            " < Fuzzy file, buffer, tag finder > {
                let g:ctrlp_cmd = 'CtrlPMRUFiles'
                let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'
                let g:ctrlp_switch_buffer = 'Et'
                let g:ctrlp_working_path_mode = 'ra'
                let g:ctrlp_arg_map = 1
                let g:ctrlp_extensions = ['mixed', 'buffertag']
                let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'

                " TODO: task-list
            " }
            Plugin 'bling/vim-airline'
            " < Pretty status line > {
                " let g:airline_theme='solarized'
                " let g:airline_theme=g:colors_name

                let g:airline_powerline_fonts = 1
                let g:airline_enable_fugitive = 1
                " let g:airline#extensions#bufferline#enabled = 1
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#branch#enabled = 1
                let g:airline#extensions#branch#empty_message = 'no scm'
                let g:airline#extensions#syntastic#enabled = 1
                " let g:airline#extensions#tagbar#enabled = 1
                let g:airline#extensions#tagbar#flags = 'f'

                let g:airline#extensions#virtualenv#enabled = 1
                let g:airline#extensions#hunks#enabled = 1
                let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
                let g:airline#extensions#ctrlp#color_template = 'normal'
                " let g:airline#extensions#ctrlp#show_adjacent_modes = 1
            " }
            Plugin 'octol/vim-cpp-enhanced-highlight'
        call vundle#end()

        filetype indent on
        filetype plugin on
    " }
endif
" }

autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -std=c++11 '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd VimEnter * NERDTree

set secure
set splitright
set splitbelow
set complete-=i
set expandtab
set shiftwidth=4
set relativenumber

" Damian Conway's Die BlinkÃ«nmatchen: highlight matches
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction
