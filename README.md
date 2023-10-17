# wordcounter.nvim

统计中文及英文单词数。为了处理 unicode 需要依赖 `utf8` 包。

## Installations

- Packer

```lua
use({
    "npc-z/wordcounter.nvim",
    requires = "uga-rosa/utf8.nvim",
})
```

## Usages

命令：

统计当前 buffer 的词数

```
:WordCount
```

绑定快捷键：

```lua
vim.api.nvim_set_keymap("n", "<leader>wc", ":WordCount<CR>", { noremap = true })
```

统计选中的文本：

```lua
vim.api.nvim_set_keymap("n", "<leader>ws", "<cmd>WordSelectedCount<CR>", { noremap = true })
```

配合 `lualine` 使用：

```lua
lualine.setup({
    sessions = {
        lualine_x = {
            require("wordcounter").count_cur_buf_words,
        },
    },
})
```

## Config

```lua
local wc = require("wordcounter")

-- 默认配置
wc.setup({
    -- set to "*" for all filetype
    allowed_filetypes = { "markdown", "text" },
})
```
