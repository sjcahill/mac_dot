local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = { "bash", "c", "lua", "python", "json", "yaml", "hcl" },-- one of "all", "maintained" (parsers with maintainer), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore during install
  highlight = {
    enable = true, -- false will disable this while extension
    disable = { "" }, -- list of languages to disable
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml", "python" } },
}

