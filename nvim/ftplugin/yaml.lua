-- NOTE: yaml requires spaces not tabs!
-- We're overriding default `expandtab`
-- We should probably change this setting not per filetype but per extension - `*.yaml/*.yml`
-- see ./ftplugin/yaml.ansible.lua
vim.opt_local.expandtab = true

-- Automation for syntax=on not working
-- https://github.com/HiPhish/jinja.vim/issues/8
-- When opening yaml.j2 file treesitter highlights only yaml parts.
-- This autocmd enables jinja syntax inside yaml templates
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "set syntax=on on attached buffer",
	group = vim.api.nvim_create_augroup("JinjaSyntaxOn", { clear = true }),
	pattern = {
		"*.yml.j2",
		"*.yaml.j2"
	},
	callback = function ()
		vim.opt.syntax = "on"
	end
})

-- Modify default keybind `gf` (go to file)
-- It default action is unchanged
-- However if file cannot be found, it will treat string under
-- cursor as a role and scan for `tasks/main.yml`
-- If it doesn't succeed it will ask if it should be created

-- ~/.config/nvim/ftplugin/yaml.lua

if vim.bo.filetype ~= "yaml.ansible" then
  return
end

vim.keymap.set("n", "gf", function()
  local word = vim.fn.expand("<cfile>")
  local cwd = vim.fn.getcwd()

  -- 1. Try role-style path: roles/<word>/tasks/main.yml
  local role_path = cwd .. "/roles/" .. word .. "/tasks/main.yml"
  if vim.fn.filereadable(role_path) == 1 then
    vim.cmd("edit " .. role_path)
    return
  end

  -- 2. Try plain file in vim path + ansible-specific subdirs
  local stripped = word:gsub("^%./", "")
  local search_path = vim.o.path

  -- Role root = 2 levels up from current file (tasks/ -> role/)
  local current_dir = vim.fn.expand("%:p:h")
  local role_root = vim.fn.fnamemodify(current_dir, ":h")

  for _, dir in ipairs({ "templates", "files" }) do
    search_path = search_path .. "," .. role_root .. "/" .. dir
    search_path = search_path .. "," .. cwd .. "/" .. dir
  end

  local plain = vim.fn.findfile(stripped, search_path .. ";")
  if plain ~= "" then
    vim.cmd("edit " .. vim.fn.fnamemodify(plain, ":p"))
    return
  end

  -- 3. Nothing found — offer to create as a new role
  local answer = vim.fn.confirm(
    ('"%s" not found. Create role skeleton at %s?'):format(word, role_path),
    "&Yes\n&No", 2
  )

  if answer == 1 then
    local dir = vim.fn.fnamemodify(role_path, ":h")
    vim.fn.mkdir(dir, "p")
    vim.cmd("edit " .. role_path)
  end
end, { buffer = true, desc = "gf with Ansible role fallback" })
