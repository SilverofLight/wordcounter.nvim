local util = require("wordcounter.util")

local parser = {
    codes = {},
    next = 1,
    length = 0,
}

parser.current_char = function()
    return parser.codes[parser.next]
end

parser.reset = function()
    parser.codes = {}
    parser.next = 1
    parser.length = 0
end

parser.init = function(str)
    parser.reset()
    for _, code in util.utf8.codes(str) do
        table.insert(parser.codes, code)
    end
    parser.length = #parser.codes
end

parser.at_end = function()
    if parser.next > parser.length then
        return true
    end
    return false
end

parser.peek = function()
    if parser.next + 1 > parser.length then
        return nil
    end
    return parser.codes[parser.next + 1]
end

parser.advance = function()
    if parser.at_end() then
        return
    end
    parser.next = parser.next + 1
end

parser.is_whitspace = function(code)
    return code == " " or code == "\t"
end

parser.is_aplphanum = function(char)
    return string.match(char, "%w") ~= nil
end

parser.sikp_whitspace = function()
    while not parser.at_end() and parser.is_whitspace(parser.current_char()) do
        parser.advance()
    end
end

parser.ascii_word = function()
    local token = ""
    while not parser.at_end()
        and (
            parser.current_char() == "-"    -- eg: <animal-like> as ONE word
            or parser.current_char() == "'" -- eg: <It's> as ONE word
            or parser.is_aplphanum(parser.current_char())
        ) do
        token = token .. parser.current_char()
        parser.advance()
    end
    return token
end

parser.next_token = function()
    if parser.at_end() then
        return nil
    end

    local code = parser.current_char()
    if parser.is_whitspace(code) then
        parser.sikp_whitspace()
        return parser.next_token()
    end

    if util.is_chinese_punctuation(code) then
        parser.advance()
        return parser.next_token()
    end

    if string.match(code, "%p") or string.match(code, "%c") then
        parser.advance()
        return parser.next_token()
    end

    if string.match(code, "%w") then
        return parser.ascii_word()
    end

    parser.advance()
    return code
end

return parser
