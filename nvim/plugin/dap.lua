local dap = require("dap")
dap.set_log_level 'TRACE'

dap.adapters.perl = {
  type = 'executable',
  command = 'node',
  args = { '/home/bmeneg/git/vscode-perl-debug/out/debugAdapter.js' },
}
dap.configurations.perl = {
  {
    type = 'perl',
    request = 'launch',
    name = 'Launch Perl',
    program = '${workspaceFolder}/${relativeFile}',
  },
}

dap.adapters.cppdbg = {
  type = 'executable',
  command = '/home/bmeneg/bin/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
-- dap.configurations.cpp = {
--   {
--     type = 'cppdbg',
--     name = '(gdb) Launch',
--     request = 'launch',
--     program = function ()
--       return require('cmake-tools').get_launch_target_path()
--     end,
--     args = {},
--     cwd = '${workspaceFolder}/build',
--     stopAtEntry = true,
--     MIMode = 'gdb',
--     miDebuggerPath = vim.env.GDB or '/usr/bin/gdb',
--     miDebuggerServerAddress = vim.env.DEBUG_GDBSERVER_ADDRESS or 'localhost:2345',
-- 	setupCommands = {
--       {
--         description = 'Enable pretty-printing for gdb',
-- 		text = '-enable-pretty-printing',
-- 		ignoreFailures = true,
-- 	  },
-- 	},
--   },
-- }

require('dap-go').setup()

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F6>', function() require('dap').terminate() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>dd', function() require('dapui').toggle() end)
vim.keymap.set('n', '<Leader>bb', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>BB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

local dapui = require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
