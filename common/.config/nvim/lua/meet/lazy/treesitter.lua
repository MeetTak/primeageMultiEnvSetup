-- nvim-treesitter (main branch): needs the tree-sitter CLI (./run neovim installs it)
return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        init = function()
            local parsers = {
                "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
                "bash", "json", "yaml", "toml", "gitignore",
                "python", "java", "c", "cpp", "go",
                "javascript", "typescript", "tsx", "html", "css",
            }

            local group = vim.api.nvim_create_augroup("MeetTreesitter", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
                group = group,
                callback = function()
                    if vim.bo.buftype ~= "" then
                        return
                    end
                    pcall(vim.treesitter.start, 0)
                end,
            })

            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "VeryLazy",
                once = true,
                callback = function()
                    require("nvim-treesitter").install(parsers)
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = { lookahead = true },
            })
            local select = require("nvim-treesitter-textobjects.select")
            vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
            vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
        end,
    },
}
