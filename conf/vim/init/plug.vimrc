" === Vundle ===
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Editor
Plugin 'jeetsukumaran/vim-filebeagle'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'mg979/vim-visual-multi'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'raimondi/delimitmate'

" Neovim 0.5
Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-treesitter/nvim-treesitter'
Plugin 'nvim-treesitter/playground'
Plugin 'hrsh7th/nvim-compe'
Plugin 'creativenull/diagnosticls-configs-nvim'

" UI
Plugin 'myusuf3/numbers.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'psliwka/vim-smoothie'
Plugin 'ap/vim-buftabline'
Plugin 'mhinz/vim-startify'

" Syntax
Plugin 'chr4/nginx.vim'

" HTML
Plugin 'othree/html5.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'mattn/emmet-vim'

" JS
Plugin 'pangloss/vim-javascript'
" Plugin 'carlitux/deoplete-ternjs'
Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'jxnblk/vim-mdx-js'

" TS
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'mhartington/nvim-typescript'

" Ember
Plugin 'joukevandermaas/vim-ember-hbs'

" CSS
Plugin 'cakebaker/scss-syntax.vim'

" Crystal
Plugin 'vim-crystal/vim-crystal'

Plugin 'stephpy/vim-yaml'

" LeetCode
Plugin 'briemens/leetcode.vim'

" Text
Plugin 'reedes/vim-pencil' " Super-powered writing things
Plugin 'tpope/vim-abolish' " Fancy abbreviation replacements
Plugin 'junegunn/limelight.vim' " Highlights only active paragraph
Plugin 'junegunn/goyo.vim' " Full screen writing mode
Plugin 'reedes/vim-lexical' " Better spellcheck mappings
Plugin 'reedes/vim-litecorrect' " Better autocorrections
Plugin 'reedes/vim-textobj-sentence' " Treat sentences as text objects
Plugin 'reedes/vim-wordy' " Weasel words and passive voice

"=== Themes ===
" Plugin 'chriskempson/base16-vim'
" Plugin 'KeitaNakamura/neodark.vim'
" Plugin 'joshdick/onedark.vim'
" Plugin 'junegunn/seoul256.vim'
" Plugin 'yuttie/hydrangea-vim'
Plugin 'dracula/vim', { 'name': 'dracula' }

call vundle#end()         " required
filetype plugin indent on " required

lua << EOF
local nvim_lsp = require("lspconfig")
nvim_lsp.tsserver.setup{}
local eslint = require 'diagnosticls-configs.linters.eslint'
local prettier = require 'diagnosticls-configs.formatters.prettier'
require 'diagnosticls-configs'.setup {
  ['javascript'] = {
    linter = eslint,
    formatter = prettier
  },
  ['javascriptreact'] = {
    linter = eslint,
    formatter = prettier
  },
  ['typescript'] = {
    linter = eslint,
    formatter = prettier
  },
  ['typescriptreact'] = {
    linter = eslint,
    formatter = prettier
  },
}
EOF
