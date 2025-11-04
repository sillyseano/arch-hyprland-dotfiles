return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            require("neo-tree").setup({
              filesystem = {
                filtered_items = {
                  hide_dotfiles = false,
                  hide_gitignored = false,
                  hide_hidden = false,
          },
        },
      })

            -- Keymap for Neo-tree
            vim.keymap.set('n', '<leader>fe', ':Neotree filesystem reveal left<CR>', { desc = "Reveal Neo-tree filesystem" })
        end,
    },
}
