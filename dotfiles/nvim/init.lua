-- Bootstrap Lazy.Nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
-- True colors
vim.o.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#F38BA8 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#FAB387 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#F9E2Af gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#A6E3A1 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#89B4FA gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#B4BEFE gui=nocombine]]
-- Line numbers
vim.o.mouse = "nv"
vim.o.number = true
vim.o.relativenumber = true
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.runtimepath:prepend(lazypath)
-- Indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 0
vim.o.expandtab = true
pcall(require, "plugins")
vim.lsp.inlay_hint.enable(true)
-- Colorscheme
vim.g.catppuccin_flavour = "mocha"
vim.cmd.colorscheme "catppuccin"
-- Keymaps
vim.keymap.set("n", "L", "<cmd>BufferLineCycleNext<CR>")     -- Next buffer
vim.keymap.set("n", "H", "<cmd>BufferLineCyclePrev<CR>")     -- Prev buffer
vim.keymap.set("n", ">b", "<cmd>BufferLineMoveNext<CR>")     -- Move buffer ->
vim.keymap.set("n", "<b", "<cmd>BufferLineMovePrev<CR>")     -- Move buffer <-
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>") -- Pick buffer
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<CR>")         -- Close buffer
vim.keymap.set("n", "<leader>C", "<cmd>bdelete!<CR>")         -- Close buffer
vim.keymap.set("n", "<leader>hc", "<cmd>noh<CR>")            -- Clear highlight
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
-- LspSaga
vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>')
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>hd', '<cmd>Lspsaga hover_doc<CR>')
vim.keymap.set('n', '<leader>lr', '<cmd>Lspsaga rename<CR>')
-- Trouble
vim.keymap.set('n', '<leader>td', '<cmd>Trouble diagnostics toggle<CR>')
-- NvimTree
vim.keymap.set('n', '<leader>tt', '<cmd>NvimTreeFocus<CR>') -- Focus tree
vim.keymap.set('n', '<leader>st', function() require('nvim-tree.api').tree.toggle(false, true) end) -- Show tree
vim.keymap.set('n', '<leader>ht', '<cmd>NvimTreeClose<CR>') -- Hide tree
-- ToggleTerm
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _Lazygit_toggle()
  lazygit:toggle()
end
vim.keymap.set('n', '<leader>gg', '<cmd>lua _Lazygit_toggle()<CR>', {noremap = true, silent = true}) -- LazyGit
vim.keymap.set('n', '<leader>tf', '<cmd>:ToggleTerm direction=float<CR>', {noremap = true, silent = true}) -- Terminal Floating
vim.keymap.set('n', '<leader>to', '<cmd>:ToggleTerm <CR>', {noremap = true, silent = true}) -- Terminal Open
-- Clipboard
vim.keymap.set('n', '<leader>p', '"+p') -- Paste
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>y', '"+y') -- Yank
vim.keymap.set('v', '<leader>y', '"+y')
