vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
	  "tpope/vim-fugitive",
	  lazy = false,
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"


local transparency = function()
    vim.cmd [[
        hi Normal guibg=NONE ctermbg=NONE
        hi NonText guibg=NONE ctermbg=NONE
        hi NvimTreeNormal guibg=NONE ctermbg=NONE
        hi NvimTreeNormalNC guibg=NONE ctermbg=NONE
    ]]
end

vim.schedule(function()
  require "mappings"
  transparency()
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function ()
    transparency()
  end,
})


