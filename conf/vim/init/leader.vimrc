let mapleader=","       " set leader to comma

" replace word under cursor, globally, with confirmation
nnoremap <Leader>k :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <Leader>k y :%s/<C-r>"//gc<Left><Left><Left>

" leader f for alefix
:nnoremap <Leader>f :ALEFix<CR>
:nnoremap <Leader>d :ALEDetail<CR>

" typescript leader keys
:nnoremap <Leader>g :TSDef<CR>
:nnoremap <Leader>t :TSRefs<CR>
:nnoremap <Leader>t :TSType<CR>

" LSP leader keys
:nnoremap <Leader>e :lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
:nnoremap <Leader>r :lua vim.lsp.buf.rename()<CR>

" LeetCode
nnoremap <leader>ll :LeetCodeList<cr>
nnoremap <leader>lt :LeetCodeTest<cr>
nnoremap <leader>ls :LeetCodeSubmit<cr>
nnoremap <leader>li :LeetCodeSignIn<cr>
