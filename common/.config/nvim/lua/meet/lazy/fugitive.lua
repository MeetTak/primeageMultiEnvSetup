return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local Meet_Fugitive = vim.api.nvim_create_augroup("Meet_Fugitive", {})
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = Meet_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local opts = { buffer = vim.api.nvim_get_current_buf(), remap = false }
                vim.keymap.set("n", "<leader>p", function() vim.cmd.Git("push") end, opts)
                -- rebase always
                vim.keymap.set("n", "<leader>P", function() vim.cmd.Git({ "pull", "--rebase" }) end, opts)
                -- set the upstream when pushing a new branch
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
            end,
        })

        -- pick a side while resolving merge conflicts
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end,
}
