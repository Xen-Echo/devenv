-- This config has been adapted from nvim kickstart

require("nvim-dap-virtual-text").setup()

local dap = require("dap")
local dapui = require("dapui")

require("mason-nvim-dap").setup {

    -- Default configuration for all the debuggers
    automatic_setup = true,

    handlers = {
        function(config)
            -- adapters -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/adapters.lua
            -- configurations -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua
            -- filetypes -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/filetypes.lua
            require('mason-nvim-dap').default_setup(config)
        end,
        node2 = function(config)
            config.configurations = {
                {
                    name = 'Node2: Launch',
                    type = 'node2',
                    request = 'launch',
                    program = '${file}',
                    cwd = vim.fn.getcwd(),
                    sourceMaps = true,
                    protocol = 'inspector',
                    console = 'integratedTerminal',
                },
                {
                    name = 'Node2: Attach to process',
                    type = 'node2',
                    request = 'attach',
                    processId = require('dap.utils').pick_process,
                },
                {
                    name = 'Node2: Attach to process (Default Port)',
                    type = 'node2',
                    request = 'attach',
                    port = 9229,
                }
            }
            require('mason-nvim-dap').default_setup(config)
        end,
    },

    ensure_installed = {
        "node2",
    },

}

vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F8>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', 'S-<F8>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })

-- Dap UI setup
dapui.setup {
    icons = { expanded = '', collapsed = '', current_frame = '󰈶' },
    controls = {
        icons = {
            pause = '󰏤',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '󰑙',
            terminate = '󰓛',
            disconnect = '󰇪',
        },
    },
}

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F3>', dapui.toggle, { desc = 'Debug: See last session result.' })

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Install golang specific config
-- require('dap-go').setup()
