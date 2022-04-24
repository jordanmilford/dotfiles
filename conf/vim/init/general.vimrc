syntax enable             " enable syntax processing
set encoding=utf-8
set hidden
set cursorline
set ttyfast
set number                " show line numbers
set showmatch             " show matching brackets
set wildmenu              " show autocomplete suggestions for command menu
set shiftwidth=2          " tab settings for auto-indent
set tabstop=2             " number of visual spaces per tab
set expandtab             " tabs are spaces
set autoindent
set nowrap           " do not automatically wrap on load

" Key bindings
set backspace=indent,eol,start
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')   "move within wrap if used without count
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')   "move within wrap if used without count

"=== buffer switching ===
noremap K :bnext<CR>
noremap J :bprevious<CR>

" Backup Buffers in /tmp {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Neovim yank highlight
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=285, on_visual=true}
