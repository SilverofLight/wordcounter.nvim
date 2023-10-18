local parser = require("wordcounter.parser")
local util = require("wordcounter.util")
local config = require("wordcounter.config")

local M = {
    _bufs = {},
}

M.count_words = function(str)
    parser.init(str)
    local words_count = 0

    local token = parser.next_token()
    while token ~= nil do
        words_count = words_count + 1
        token = parser.next_token()
    end

    return words_count
end

M.count_lines_words = function(str_lines)
    local words_count = 0
    for _, str in ipairs(str_lines) do
        if str ~= "" then
            local w = M.count_words(str)
            words_count = words_count + w
        end
    end

    return words_count
end

M.count_buf_words = function(buf_no)
    local lines = vim.api.nvim_buf_get_lines(buf_no, 0, -1, false)
    local name = vim.api.nvim_buf_get_name(buf_no)

    local bufno = "%"
    if buf_no ~= 0 then
        bufno = buf_no
    end
    local changed = util.is_buf_changed(bufno)

    if not changed and util.contains_key(M._bufs, name) then
        return M._bufs[name]
    end

    local words_count = 0

    local w = M.count_lines_words(lines)
    words_count = words_count + w

    M._bufs[name] = words_count
    return words_count
end

M.count_cur_buf_words = function()
    local fts = config.allowed_filetypes
    local ft = vim.bo.filetype

    if not util.contains(fts, "*") and not util.contains(fts, ft) then
        return 0
    end

    local words_count = M.count_buf_words(0)
    return words_count
end

M.setup = function(options)
    if options == nil then
        return
    end

    if options.allowed_filetypes ~= nil then
        config.allowed_filetypes = options.allowed_filetypes
    end
end

return M
