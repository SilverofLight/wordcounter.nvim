# wordcounter.nvim

统计中文及英文单词数。为了处理 unicode 需要依赖 `utf8` 包。

## Installations

- Packer

```lua
use({
    "/home/npc/github/lua/wordcounter.nvim",
    requires = "uga-rosa/utf8.nvim",
})
```

## Usages

命令：

```
:WordCount
```

绑定快捷键：

```lua
vim.api.nvim_set_keymap("n", "<leader>wc", ":WordCount<CR>")
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
