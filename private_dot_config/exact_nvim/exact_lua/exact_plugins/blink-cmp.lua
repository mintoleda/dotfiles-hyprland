return {
    'saghen/blink.cmp',
    event = { 'CmdlineEnter', 'InsertEnter' },
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'super-tab',
            ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = { nerd_font_variant = 'mono' },
        completion = {
            list = {
                selection = { preselect = false, auto_insert = true },
            },
            menu = {
                border = 'rounded',
                draw = {
                    columns = {
                        { 'kind_icon', 'label', gap = 1 },
                        { 'label_description', gap = 1 },
                    },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
            },
        },
        signature = { enabled = true },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
}
