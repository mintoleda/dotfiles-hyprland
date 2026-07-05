return {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    keys = {
        { '<leader>xw', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Workspace Diagnostics' },
        { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Document Diagnostics' },
        { '<leader>xl', '<cmd>Trouble loclist toggle<cr>',                  desc = 'Open Loclist' },
        { '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                   desc = 'Open Quickfix' },
    },
    opts = {},
}
