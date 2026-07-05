return {
    'toppair/peek.nvim',
    event = 'VeryLazy',
    build = 'deno task --quiet build:fast',
    config = function()
        require('peek').setup({
            theme = 'dark',
            app = 'browser',
        })
        vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
        vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        vim.keymap.set('n', '<leader>p', function()
            local peek = require('peek')
            if peek.is_open() then
                peek.close()
            else
                peek.open()
            end
        end, { desc = 'Toggle Peek markdown preview' })
    end,
}
