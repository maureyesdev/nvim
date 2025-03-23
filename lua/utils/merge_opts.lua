local M = {
  keymaps = {}, -- storage for metadata
}

--- Merges vim opts and stores metadata for later use
--- @param config { opts: table, [string]: any }
function M.merge_opts(config)
  local result = vim.tbl_extend("force", {}, config.opts or {})

  -- Capture metadata separately before removing it from the vim opts
  local metadata = {
    keys = config.keys,
    desc = config.desc,
    mode = config.mode or "n", -- optional future-proofing
  }

  table.insert(M.keymaps, metadata)

  -- Only include valid vim.keymap options in the result
  for key, value in pairs(config) do
    if key ~= "opts" and key ~= "keys" and key ~= "desc" and key ~= "mode" then
      result[key] = value
    end
  end

  return result
end

--- Expose stored metadata
function M.get_keymap_metadata()
  return M.keymaps
end

return M
