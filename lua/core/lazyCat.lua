-- https://github.com/BirdeeHub/nixCats-nvim/blob/main/nix/templates/kickstart-nvim/lua/nixCatsUtils/lazyCat.lua
-- MIT License
local M = {}

function M.mergePluginTables(table1, table2)
  return vim.tbl_extend('keep', table1, table2)
end

---used to help provide the list of plugin names for lazy wrapper.
---@param pluginTable table|string[]|nil
---@return string[]
function M.getTableNamesOrListValues(pluginTable)
  if pluginTable == nil then
    return {}
  end
  for key, _ in pairs(pluginTable) do
    if type(key) ~= 'string' then
      return vim.tbl_values(pluginTable)
    end
    break
  end
  return vim.tbl_keys(pluginTable)
end

---lazy.nvim wrapper
---@param pluginTable table|string[]|nil
---@param nixLazyPath string|nil
---@param lazySpecs any
---@param lazyCFG table
function M.setup(pluginTable, nixLazyPath, lazySpecs, lazyCFG)

  local function regularLazyDownload()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
      }
    end
    return lazypath
  end

  local ok, nixCats = pcall(require,'nixCats')
  local lazypath
  if not ok then
    -- No nixCats? Not nix. Do it normally
    lazypath = regularLazyDownload()
  else
    -- Else, its nix, so we wrap lazy with a few extra config options
    lazypath = nixLazyPath
    -- and also we probably dont have to download lazy either
    if lazypath == nil then
      lazypath = regularLazyDownload()
    end

    local oldPath
    local lazypatterns
    if type(lazyCFG) == "table" and type(lazyCFG.dev) == "table" then
      if type(lazyCFG.dev.patterns) ~= 'table' then
        lazypatterns = M.getTableNamesOrListValues(pluginTable)
      else
        local toInclude = lazyCFG.dev.patterns
        vim.list_extend(toInclude, M.getTableNamesOrListValues(pluginTable))
        lazypatterns = toInclude
      end
      oldPath = lazyCFG.dev.path
    end

    local myNeovimPackages = nixCats.vimPackDir .. "/pack/myNeovimPackages"

    local newLazyOpts = {
      performance = {
        rtp = {
          reset = false,
        },
      },
      dev = {
        path = function(plugin)
          local path = nil
          if type(oldPath) == "string" and vim.fn.isdirectory(oldPath .. "/" .. plugin.name) == 1 then
            path = oldPath .. "/" .. plugin.name
          elseif type(oldPath) == "function" then
            path = oldPath(plugin)
            if type(path) ~= "string" then
              path = nil
            end
          end
          if path == nil then
            if vim.fn.isdirectory(myNeovimPackages .. "/start/" .. plugin.name) == 1 then
              path = myNeovimPackages .. "/start/" .. plugin.name
            elseif vim.fn.isdirectory(myNeovimPackages .. "/opt/" .. plugin.name) == 1 then
              path = myNeovimPackages .. "/opt/" .. plugin.name
            else
              path = "~/projects/" .. plugin.name
            end
          end
          return path
        end,
        patterns = lazypatterns or M.getTableNamesOrListValues(pluginTable),
      }
    }
    lazyCFG = vim.tbl_deep_extend("force", lazyCFG or {}, newLazyOpts)
  end

  vim.opt.rtp:prepend(lazypath)
  require('lazy').setup(lazySpecs, lazyCFG)
end

return M
