local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

local b = null_ls.builtins

local sources = {

   -- JS html css stuff
   b.formatting.prettierd.with {
      filetypes = { "html", "json", "markdown", "scss", "css", "javascript", "javascriptreact", "yaml" },
   },
   b.diagnostics.eslint.with {
      command = "eslint_d",
   },

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- Python
   b.formatting.black.with {
     filetypes = { "python" },
     command = "black",
     args = { "--quiet", "--fast", "-" },
   },

   -- rust
   b.formatting.rustfmt.with {
     filetypes = { "rust" },
     command = "rustfmt",
     args = { "--emit=stdout", "--edition=2018" },
   },

   -- terraform
   b.formatting.terraform_fmt.with {
     filetypes = { "tf", "hcl" },
     command = "terraform",
     args = { "fmt", "-" },
   },
}

local M = {}
M.setup = function(on_attach)
   null_ls.config {
      sources = sources,
   }
   require("lspconfig")["null-ls"].setup { on_attach = on_attach }
end

return M
