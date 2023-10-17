local wc = require("wordcounter")

local cmd_count_cur_buf_words = function()
    local r = "words:" .. wc.count_cur_buf_words()
    vim.notify(r)
end

vim.api.nvim_create_user_command(
    "WordCount",
    cmd_count_cur_buf_words,
    { bang = true, desc = "words' count of the current buffer" }
)
