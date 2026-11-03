-- formatting: <leader>f, and on save (falls back to the LSP formatter)
return {
    "stevearc/conform.nvim",
    config = function()
        require("conform").setup({
            format_on_save = {
                timeout_ms = 5000,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                lua = { "stylua" },
                go = { "gofmt" },
                python = { "ruff_format" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = { "-style=file", "-fallback-style=LLVM" },
                },
            },
        })

        vim.keymap.set("n", "<leader>f", function()
            require("conform").format({ bufnr = 0 })
        end)
    end,
}
