local ok, utf8 = pcall(require, "utf8")
if not ok then
    vim.notify("can not load utf8 lib")
    return
end

local M = {}

local chinese_punctuations = {
    '，',
    '。',
    '？',
    '《',
    '》',
    '（',
    '）',
    '【',
    '】',
    '「',
    '」',
    '『',
    '』',
    '❲',
    '❳',
    '［',
    '］',
    '、',
    '|',
    '；',
    '：',
    '“',
    '”',
    "",
    '',
    '—',
    '…',
    '！',
    '～',
    '`',
}

local contains = function(list, element)
    for _, e in pairs(list) do
        if e == element then
            return true
        end
    end
    return false
end

local is_chinese_punctuation = function(char)
    return contains(chinese_punctuations, char)
end

-- inspect the value
local P = function(value)
    print(vim.inspect(value))
    return value
end

local function get_visual_selection()
    vim.cmd('noau silent! normal!  "vy"')
    local text = vim.fn.getreg("v")
    vim.fn.setreg("v", {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ""
    end
end

M.is_chinese_punctuation = is_chinese_punctuation
M.get_visual_selection = get_visual_selection
M.contains = contains
M.P = P
M.utf8 = utf8

return M
