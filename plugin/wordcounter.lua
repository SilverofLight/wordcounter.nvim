local wc = require("wordcounter")
local util = require("wordcounter.util")

local cmd_count_cur_buf_words = function()
    local r = "words:" .. wc.count_cur_buf_words()
    vim.notify(r)
end

local cmd_count_selected_words = function()
    local text = util.get_visual_selection()
    local count = wc.count_words(text)
    local msg = "selected (" .. count .. ") words"
    vim.notify(msg)
    return count
end

vim.api.nvim_create_user_command(
    "WordCount",
    cmd_count_cur_buf_words,
    { bang = true, desc = "words' count of the current buffer" }
)

vim.api.nvim_create_user_command(
    "WordSelectedCount",
    cmd_count_selected_words,
    { bang = true, desc = "count the selected text words' count" }
)
