local Language = {}
Language.__index = Language

-- Constructor
function Language:new(name)
  local obj = setmetatable({}, Language)
  obj.name = name
  obj.treesitter_parsers = { name }
  obj.formatters = {}
  obj.mason_tools = {}
  return obj
end

-- Fluent API for chaining configuration
function Language:add_treesitter(langs)
  if type(langs) == "string" then
    table.insert(self.treesitter_parsers, langs)
  else
    for _, lang in ipairs(langs) do
      table.insert(self.treesitter_parsers, lang)
    end
  end
  return self
end

function Language:add_formatters(ft_formatters)
  for ft, formatters in pairs(ft_formatters) do
    if type(formatters) == "string" then
      self.formatters[ft] = { formatters }
    else
      self.formatters[ft] = formatters
    end
  end
  return self
end

function Language:add_lsp_installation(tools)
  if type(tools) == "string" then
    table.insert(self.mason_tools, tools)
  else
    for _, tool in ipairs(tools) do
      table.insert(self.mason_tools, tool)
    end
  end
  return self
end

-- Methods to be overridden by subclasses
function Language:get_treesitter_config()
  return {
    ensure_installed = self.treesitter_parsers,
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  }
end

function Language:get_formatter_config()
  return self.formatters
end

function Language:get_mason_tools()
  return self.mason_tools
end

function Language:setup_lsp()
  -- Override in subclass
end

return Language
