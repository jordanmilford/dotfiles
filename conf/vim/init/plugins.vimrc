" NERDComment
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 3

" Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,scss EmmetInstall
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" compe
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.nvim_lsp = v:true
inoremap <silent><expr> <C-Space> compe#complete()

" ale
let g:ale_linters = {
\   'javascript': ['eslint', 'tsserver'],
\   'typescript': ['eslint', 'tsserver'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'typescriptreact': ['eslint'],
\}

let g:ale_javascript_eslint_options="--no-ignore"

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ctrlp
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|All\|\.yardoc\|node_modules\|log\|tmp$',
      \ 'file': '\.so$\|\.dat$|\.DS_Store$'
      \ }
let g:ctrlp_working_path_mode = ''
let g:ctrlp_custom_ignore = {
      \ 'dir':  'node_modules',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }

" base16
colorscheme dracula
set termguicolors
syntax on

" lightline
set laststatus=2
let g:lightline = {
      \   'colorscheme': 'dracula'
      \ }

" leetcode
let g:leetcode_browser = 'chrome'
let g:leetcode_solution_filetype = 'typescript'
