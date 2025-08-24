inoremap <buffer> <C-f> <Esc>:silent exec '.!figure_manager create "'.expand('%:h').'/figures/" "'.getline('.').'"'<CR><CR>:w<CR>
nnoremap <buffer> <C-f> :silent !figure_manager edit "<C-R>=expand('%:h') . '/figures/'<CR>" > /dev/null 2>&1<CR>
