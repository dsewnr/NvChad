-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the "setup_mappings" hook,
-- you can set one or many mappings
-- example below:

hooks.add("setup_mappings", function(map)
   map("n", "<leader>cc", "gg0vG$d", opt) -- example to delete the buffer

   -- lspconfig
   local opts = { noremap = true, silent = true }
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   map("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
   map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
   map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
   map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   map("n", "ge", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
   map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
   map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
   map("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
   map("n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   map("v", "<space>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
end)

-- To add new plugins, use the "install_plugin" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
   use {
     'tzachar/cmp-tabnine',
     after = "nvim-cmp",
     run='./install.sh',
   }

   use {
     "p00f/nvim-ts-rainbow",
     after = "nvim-treesitter",
   }

   use {
     "folke/todo-comments.nvim",
     config = function()
        require "plugins.configs.todocomments"
     end,
   }

   use {
     "preservim/tagbar",
   }

   use {
     "christoomey/vim-tmux-navigator",
   }

   use {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugin_confs.null-ls").setup()
      end,
   }

   use {
      "williamboman/nvim-lsp-installer",
      after = "nvim-lspconfig",
      config = function()
         local lsp_installer = require "nvim-lsp-installer"

         lsp_installer.on_server_ready(function(server)
            local opts = {}

            server:setup(opts)
            vim.cmd [[ do User LspAttachBuffers ]]
         end)
      end,
   }
end)

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
