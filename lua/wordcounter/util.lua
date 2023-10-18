local ok, utf8 = pcall(require, "utf8")
if not ok then
    vim.notify("can not load utf8 lib")
    return
end

local M = {}

local chinese_punctuations = {
    "，",
    "。",
    "？",
    "《",
    "》",
    "（",
    "）",
    "【",
    "】",
    "「",
    "」",
    "『",
    "』",
    "❲",
    "❳",
    "［",
    "］",
    "、",
    "|",
    "；",
    "：",
    "“",
    "”",
    "—",
    "…",
    "！",
    "～",
}

local function now()
    return os.date('%Y-%m-%d %H:%M:%S')
end

---@type fun(tbl: table, key: string): boolean
local contains_key = function(tbl, key)
    for k, _ in pairs(tbl) do
        if k == key then
            return true
        end
    end
    return false
end

---@type fun(list: table, element: string): boolean
local contains = function(list, element)
    for _, e in pairs(list) do
        if e == element then
            return true
        end
    end
    return false
end

---@type fun(char: string): boolean
local is_chinese_punctuation = function(char)
    return contains(chinese_punctuations, char)
end

-- inspect the value
local P = function(value)
    print(now(), vim.inspect(value))
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

local function is_buf_changed(bufno)
    return vim.fn.getbufinfo(bufno)[1].changed == 1
end

M.is_chinese_punctuation = is_chinese_punctuation
M.get_visual_selection = get_visual_selection
M.contains = contains
M.contains_key = contains_key
M.is_buf_changed = is_buf_changed
M.P = P
M.utf8 = utf8

return M
