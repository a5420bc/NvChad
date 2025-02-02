vim.api.nvim_exec(
[[
  " For built in omnifunc
  autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

  " hrsh7th/nvim-cmp
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

  " Source is automatically added, you just need to include it in the chain complete list
  let g:completion_chain_complete_list = {
      \   'sql': [
      \    {'complete_items': ['vim-dadbod-completion']},
      \   ],
      \ }
  " Make sure `substring` is part of this list. Other items are optional for this completion source
  let g:completion_matching_strategy_list = ['exact', 'substring']
  " Useful if there's a lot of camel case items
  let g:completion_matching_ignore_case = 1
]],
  true
)

local M = {}
function M.dbui_mappings()
    vim.api.nvim_set_keymap("t", '<A-h>', "<C-w>h", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", '<A-l>',"<C-w>l", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", '<A-j>',"<C-w>j", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", '<A-k>',"<C-w>k", { noremap = true, silent = true })
end

function M.DBUI()
    vim.cmd('set showtabline=0 nonu signcolumn=no nofoldenable')
    vim.cmd('exec "DBUI"')
end

vim.cmd('com! CALLDB lua require("custom.configs.dad").DBUI()')

M.DBUI_Name = "DBUI"
return M
