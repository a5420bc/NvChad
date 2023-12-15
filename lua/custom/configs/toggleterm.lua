local M = {}

local Terminal  = require('toggleterm.terminal').Terminal
local dbui = Terminal:new({
    cmd='nvim +\'exec "DBUI"\'',
    hidden=true,
    direction = "float",
    start_in_insert = true,
})

function M.dbui_toggle()
    dbui:toggle()
end


function M.set_dbui_mappings()
    require("custom.configs.dad").dbui_mappings()
end

local function inspect_table(t, depth)
    depth = depth or 0
    local padding = string.rep("  ", depth)
    for k, v in pairs(t) do
        if type(v) == "table" then
            print(padding .. k .. " (table):")
            inspect_table(v, depth + 1)
        else
            print(padding .. k .. ": " .. tostring(v))
        end
    end
end

function M.restore_dbui_mappings()
    local saved_keymaps = require("custom.mappings").floaterm
    for mode, keymap in pairs(saved_keymaps) do
        for key, value in pairs(keymap) do
            -- print("Field Name:", key)
            -- for key1, value1 in pairs(value) do
            --     print("Field Name:",key1, value1)
            -- end
            print(mode, key, value[1], value[2], value[3])
            vim.api.nvim_set_keymap(mode, key, value[1], {})
        end
    end
end

return M
