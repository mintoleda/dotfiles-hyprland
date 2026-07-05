return {
    'folke/flash.nvim',
    ---@module "flash"
    ---@type Flash.Config
    opts = {
        modes = {
            char = {
                enabled = true,
                jump_labels = true,
                highlight = { backdrop = false },
            },
        },
        label = {
            rainbow = { enabled = true, shade = 5 },
        },
        highlight = { backdrop = false },
    },
    keys = {
        { '<leader><leader>', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,       desc = 'Flash' },
        { '<leader><cr>',     mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    },
}
