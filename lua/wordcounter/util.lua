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

local is_chinese_punctuation = function(char)
    for _, p in pairs(chinese_punctuations) do
        if char == p then
            return true
        end
    end
    return false
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
M.P = P
M.utf8 = utf8

return M
